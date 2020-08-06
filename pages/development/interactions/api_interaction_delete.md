---
title: API Delete Interaction
keywords: structured rest documentreference
tags: [fhir,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_delete.html
summary: To support the deletion of NRL pointers.
---

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Delete

Provider interaction to support the deletion of NRL pointers. 

## Prerequisites

In addition to the requirements on this page the general guidance and requirements detailed on the [Development Overview](development_overview.html) page MUST be followed when using this interaction.

## Delete Request Headers

Provider API delete requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. | OPTIONAL |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the JWT section of the [Development Overview](development_overview.html) page for details. | REQUIRED |
| `fromASID`           | Client System ASID | REQUIRED |
| `toASID`             | The Spine ASID | REQUIRED |

## Delete Operation

{% include note.html content="All query parameters must be percent encoded. In particular, the pipe (`|`) character must be percent encoded (`%7C`)." %}

Provider systems MUST only delete pointers for records where they are the pointer owner (custodian).

For all delete requests the `custodian` ODS code in the DocumentReference to be deleted MUST be affiliated with the Client System `ASID` value in the `fromASID` HTTP request header sent to the NRL.

### Delete by `id`

The API supports the delete by ID interaction which allows a provider to delete an existing pointer based on the logical ID of the pointer.

The logical id can be obtained from the Location header which is contained in the create response - see the [Create API Interaction](api_interaction_create.html#create-response) for details.

To accomplish this, the provider issues an HTTP DELETE as shown:

<div markdown="span" class="alert alert-success" role="alert">
`DELETE [baseUrl]/DocumentReference/[id]`
</div>

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">DELETE [baseUrl]/DocumentReference/da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Delete the DocumentReference resource for a pointer with a logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'.</pre>
</div>

### Conditional Delete by `id`

The API supports the conditional delete by `id` interaction which allows a provider to delete an existing pointer based on the search parameter `_id` which refers to the logical id of the pointer. 

The logical id can be obtained from the Location header which is contained in the create response - see the [Create API Interaction](api_interaction_create.html#create-response) for details.

To accomplish this, the provider issues an HTTP DELETE as shown:

<div markdown="span" class="alert alert-success" role="alert">
`DELETE [baseUrl]/DocumentReference?_id=[id]`
</div>

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">DELETE [baseUrl]/DocumentReference?_id=da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Delete the DocumentReference resource for a pointer conditionally with a logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'.</pre>
</div>

{% include important.html content="Conditional delete by logical ID may be deprecated in the future, therefore it is recommended to implement [delete by ID](#delete-by-id) as a path variable." %}

### Conditional Delete by `masterIdentifier`'*`

The API supports the conditional delete by `masterIdentifier` interaction which allows a provider to delete an existing pointer using the masterIdentifier
so they do not have to persist or query for the NRL generated logical id for the Pointer.

To accomplish this, the provider issues an HTTP DELETE as shown:

<div markdown="span" class="alert alert-success" role="alert">
`DELETE [baseUrl]/DocumentReference?subject=[https://demographics.spineservices.nhs.uk/STU3/Patient/[nhsNumber]&identifier=[system]%7C[value]`
</div>

*[nhsNumber]* - The NHS number of the patient whose `DocumentReference`s the client is requesting

*[system]* - The namespace of the masterIdentifier value that is associated with the DocumentReference(s)

*[value]* - The value of the masterIdentifier that is associated with the DocumentReference(s)

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">DELETE [baseUrl]/DocumentReference?subject=https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210&identifier=urn:ietf:rfc:3986%7Curn:oid:1.3.6.1.4.1.21367.2005.3.71
</span></code>
Delete the DocumentReference resource for a pointer with a subject and identifier.</pre>
</div>

## Delete Response

<p>The 'delete' interaction removes an existing resource. The interaction is performed by an HTTP DELETE of the <code class="highlighter-rouge">DocumentReference</code> resource.</p>

Success:

- will return a `200` **OK** HTTP status code on successful execution of the interaction.
- will return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) FHIR profile. 

The table summarises the successful `delete` interaction scenario and includes HTTP response code and the values expected to be conveyed in the response body `OperationOutcome` payload:

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Details.Text |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|200|information|informational|RESOURCE_DELETED|Resource removed | Spine message UUID |Successfully removed resource DocumentReference: [url]|

{% include note.html content="Upon successful deletion of a pointer the NRL Service returns in the response payload an OperationOutcome resource with the OperationOutcome.issue.details.text element populated with a Spine internal message UUID. This UUID is used to identify the client's Delete transaction within Spine. A client system SHOULD reference the UUID in any calls raised with the Deployment Issues Resolution Team. The UUID will be used to retrieve log entries that relate to a specific client transaction." %}

Failure: 

The following errors can be triggered when performing this operation:

- [No record found](nrl_error_guidance.html#resource-not-found)
- [Invalid Resource](nrl_error_guidance.html#invalid-resource)


## Explore the NRL
You can explore and test the NRL DELETE command using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html#/Nrls/deletePointer).
