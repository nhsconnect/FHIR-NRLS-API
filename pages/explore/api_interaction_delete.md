---
title: API Delete Interaction
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_delete.html
summary: To support the deletion of NRLS pointers.
---

<!--
summary: A DocumentReference resource is used to describe a document that is made available to a healthcare system. A document is some sequence of bytes that is identifiable, establishes its own context (e.g., what subject, author, etc. can be displayed to the user), and has defined update management. The DocumentReference resource can be used with any document format that has a recognized mime type and that conforms to this definition.
-->


{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Delete ##

API to support the deletion of NRLS pointers. This functionality is only available for providers.
<!--
Deletes are version aware. In order to conduct an update the Provider should submit the request with an If-Match header where the ETag matches the versionId of the DocumentReference in question from the server. If the version id given in the If-Match header does not match the versionId that the server holds for that DocumentReference, the server returns a 409 Conflict status code instead of deleting the resource. In this situation the client should read the DocumentReference from the server to get the most recent versionId and use that to populate the Etag in a fresh delete request.-->

## Delete Request Headers ##

<!--
All Provider API delete requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->
<!--All Provider API delete requests SHALL include the following HTTP request headers:-->


Provider API delete requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |




## Delete Operation ##

### Delete by *'id'* ###

The API supports the conditional delete interaction which allows a provider to delete an existing pointer based on the search parameter `_id` which refers to the logical id of the pointer. To accomplish this, the provider issues an HTTP DELETE as shown:

<div markdown="span" class="alert alert-success" role="alert">
DELETE [baseUrl]/DocumentReference?_id=[id]</div>



Providers systems SHALL only delete pointers for records where they are the pointer owner (custodian). 

For all delete requests the `custodian` ODS code in the DocumentReference to be deleted SHALL be affiliated with the Client System `ASID` value in the `fromASID` HTTP request header sent to the NRLS.

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">DELETE [baseUrl]/DocumentReference?_id=da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Delete the DocumentReference resource for a pointer with a logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'.</pre>
</div>


### Delete by *'masterIdentifier'* ###

The API supports the conditional delete interaction which allows a provider to delete an existing pointer using the masterIdentifier
so they do not have to persist or query for the NRLS generated logical id for the Pointer.
To accomplish this, the provider issues an HTTP DELETE as shown:

<div markdown="span" class="alert alert-success" role="alert">
DELETE [baseUrl]/DocumentReference?subject[https://demographics.spineservices.nhs.uk/STU3/Patient/[nhsNumber]&identifier=[system][value]</div>

*[nhsNumber]* - The NHS number of the patient whose DocumentReferences the client is requesting

*[system]* - The namespace of the masterIdentifier value that is associated with the DocumentReference(s)

*[value]* - The value of the masterIdentifier that is associated with the DocumentReference(s)

Providers systems SHALL only delete pointers for records where they are the pointer owner (custodian). 



## Delete Response ##

<p>The 'delete' interaction removes an existing resource. The interaction is performed by an HTTP DELETE of the <code class="highlighter-rouge">DocumentReference</code> resource.</p>


Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) FHIR profile. 

The table summarises the successful `delete` interaction scenario and includes HTTP response code and the values expected to be conveyed in the response body `OperationOutcome` payload:


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Details.Text |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|200|information|informational|RESOURCE_DELETED|Resource removed | Spine message UUID |Successfully removed resource DocumentReference: [url]|

{% include note.html content="Upon successful deletion of a pointer the NRLS Service returns in the reponse payload an OperationOutcome resource with the OperationOutcome.issue.details.text element populated with a Spine internal message UUID. This UUID is used to identify the client's Delete transaction within Spine. A client system SHOULD reference the UUID in any calls raised with the Deployment Issues Resolution Team. The UUID will be used to retrieve log entries that relate to a specific client transaction." %}


Failure: 

The following errors can be triggered when performing this operation:

- [No record found](development_general_api_guidance.html#resource-not-found)
- [Invalid Resource](development_general_api_guidance.html#invalid-resource)
