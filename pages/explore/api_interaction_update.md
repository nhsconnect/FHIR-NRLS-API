---
title: API Update Interaction
keywords: structured, update, rest, documentreference
tags: [rest,fhir,documents,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_update.html
summary: To support the update of NRLS pointers
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Update ##

API to support the update of NRLS pointers. This functionality is only available for providers.
The update functionality will be used in cases where a Provider wishes to deprecate the Document that the current DocumentReference points to and replace it with a new version.

The end result will be that the DocumentReference that is being superseded will have a status of "superseded" and there will be a newly created DocumetReference that points to the new version of the Document.

To perform this activity the client (Provider) will POST a new DocumentReference that points to the new document. Within that DocumentReference the relatesTo property will have been populated. 
See the [create](/api_interaction_create.html) interaction for more information about creating a pointer.

Along with creating the new DocumentReference for each element in relatesTo that targets a DocumentReference the NRLS should perform the following checks and actions -

1. Ignore any relatesTo element where the code property's value is not "replaces"
2. Ensure that the related DocumentReference exists. 
3. Ensure that the requesting party has permissions to modify the related DocumentReference.
4. Set the status on the linked DocumentReference to “superseded”
5. Calculate the versionId of the new (to be created) current DocumentReference as follows -
	1. Take the value of the versionId property from the superseded DocumentReference
	2. Increment the value by one
	3. Use incremented value as the versionId in the new (to be created) current DocumentReference
6. Persist the change

## Update Request Headers ##

Provider API update requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |


## Provider Update Operation ##

Currently the API does not allow a true update i.e. the HTTP PUT verb is not supported. 
At the moment the Provider can only update a DocumentReference’s status property. This is described below.

### Provider Update status Operation ###

The NRLS will only allow a provider to supersede a Pointer and the moment i.e. to transition a DocumentReference’s status from 
current to superseded. No other [transitions](/pointer_lifecycle.html) are supported at this time.

A Provider transitions an existing Pointer’s status from current to superseded as part of the act of creating its replacement. In effect the POSTing of a new DocumentReference provides a means to specify an existing DocumentReference whose status should be moved to superseded. Concretely this is achieved as follows –

1.	Provider assembles a new DocumentReference resource
2.	Provider populates the relatesTo property with a new target element which holds  –
	- an identifier that is the masterIdentifier of the existing DocumentReference
	- the action code “replaces”
3.	Provider POSTs the DocumentReference resource
4.	NRLS will transactionally -
	1. create the new DocumentReference marking it as current
	2. resolve the existing DocumentReference using the relatesTo.target.identifer
	3. mark that DocumentReference as superseded

### XML Example of a bundle with a new DocumentReference resource that supersedes an existing DocumentReference ###

<script src="https://gist.github.com/sufyanpat/b85394951c3df416e3001611238ffd3b.js"></script>


## Response ##

Success:

See [Create Response](/api_interaction_create.html#create-response) for the success response behaviour and codes.


Failure:


- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the 'Spine-OperationOutcome-1-0' profile if the pointer cannot be created.
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.

