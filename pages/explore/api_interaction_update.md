---
title: API Update Interaction
keywords: structured, update, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_update.html
summary: To support the update of NRLS pointers
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Update ##

API to support the update of NRLS pointers. This functionality is only available for providers.
The update functionality will be used in cases where a Provider wishes to deprecate the Document that the current DocumentReference points to and replace it with a new version.

## Update Request Headers ##

Provider API update requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |


## Update Operation ##

Currently the API does not allow a true update i.e. the HTTP PUT verb is not supported. 
At the moment the Provider can only update a DocumentReference’s status property. This is described below.

### Update status Operation ###

The NRLS will only allow a provider to supersede a Pointer at the moment i.e. to transition a DocumentReference’s status from 
current to superseded. No other [transitions](pointer_lifecycle.html) are supported at this time.

Note also that currently the NRLS will only attempt to interpret the first relatesTo element. Subsequent elements will be persisted as part of the containing DocumentReference but their contents will not be processed i.e. no attempt will be made to resolve the relatesTo.reference nor will any validation be applied to the code property. This behaviour is subject to change in future releases of the NRLS API.

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

### XML Example of a DocumentReference resource that supersedes an existing DocumentReference ###

<script src="https://gist.github.com/sufyanpat/22bd1935648a7055f0836ed888917b85.js"></script>

### JSON Example of a DocumentReference resource that supersedes an existing DocumentReference ###

<script src="https://gist.github.com/sufyanpat/fd3f828fe535299752632319257c43ce.js"></script>

## Response ##

Success and Failure:

See [Create Response](api_interaction_create.html#create-response) for the response behaviour and codes.

## Code Examples ##

Code examples about updating the pointer can be found [here](api_interaction_create.html#code-examples).
