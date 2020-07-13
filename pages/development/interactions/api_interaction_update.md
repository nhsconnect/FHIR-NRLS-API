---
title: API Update Interaction
keywords: structured update rest documentreference
tags: [fhir,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_update.html
summary: To support the update of NRL pointers
---

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Update

{% include important.html content="The Supersede interaction previously detailed on this page has been moved to the [Supersede Interaction](api_interaction_supersede.html) page." %}

Provider interaction to support the update of NRL pointers. The update functionality will be used in cases where a Provider wishes to update a pointer status value, changing it from “current” to “entered-in-error”. 

## Prerequisites

In addition to the requirements on this page the general guidance and requirements detailed on the [Development Guidance](explore.html#2-prerequisites-for-nrl-api) page MUST be followed when using this interaction.

## Update Request Headers

Provider API update requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | OPTIONAL |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details. | REQUIRED |
| `fromASID`           | Client System ASID | REQUIRED |
| `toASID`             | The Spine ASID | REQUIRED |

## Update Operation

Provider systems MUST construct a [FHIRPath PATCH Parameters resource](https://www.hl7.org/fhir/STU3/fhirpatch.html) and submit this to NRL using the FHIR RESTful [patch](https://www.hl7.org/fhir/STU3/http.html#patch) interaction.

<div markdown="span" class="alert alert-success" role="alert">
`PATCH [baseUrl]/DocumentReference/[id]`
</div>

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">PATCH [baseUrl]/DocumentReference/da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Update the DocumentReference resource status for a pointer with the logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'.</pre>
</div>

The API supports the conditional update interaction which allows a provider to update a pointer using the masterIdentifier so they do not have to persist or query for the NRL generated logical id for the pointer. The query parameters should be used as shown:

<div markdown="span" class="alert alert-success" role="alert">
`PATCH [baseUrl]/DocumentReference?subject=[https://demographics.spineservices.nhs.uk/STU3/Patient/[nhsNumber]&amp;identifier=[system]%7C[value]`
</div>

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">PATCH [baseUrl]/DocumentReference?subject=https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210&identifier=urn:ietf:rfc:3986%7Curn:oid:1.3.6.1.4.1.21367.2005.3.71
</span></code>
Update the DocumentReference resource status for a pointer with a subject and identifier.</pre>
</div>

*[nhsNumber]* - The NHS number of the patient whose `DocumentReference`s the client is requesting

*[system]* - The namespace of the masterIdentifier value that is associated with the DocumentReference(s)

*[value]* - The value of the masterIdentifier that is associated with the DocumentReference(s)

Providers systems MUST only update pointers for records where they are the pointer owner (custodian).
For all update requests the custodian ODS code in the DocumentReference resource MUST be affiliated with the Client System ASID value in the fromASID HTTP request header sent to the NRL.

The FHIRPath PATCH operation must be encoded in a Parameters resource as follows:
- A single operation as a Parameter named "operation"
- The single parameter has a series of mandatory parts, with required values as listed in  following table:

| Parameter | Type | Required Value |
|-------|-------|-------|
|`Type`|code|`replace`|
|`Path`|string|`DocumentReference.status`|
|`Value`|string|`entered-in-error`|

Only the first parameter within the Parameters resource will be used to perform a PATCH. Any additional parameters included within the request will not be processed. More details on the validation of the Parameters resource can be found in the [error handling guidance](development_general_api_guidance.html#invalid-resource).

XML and JSON examples of the FHIRPath Parameters resource are shown below. 

### XML FHIRPath PATCH Parameters Resource

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/patch_parameters_resource.xml %}
{% endhighlight %}
</div>

### JSON FHIRPath PATCH Parameters Resource

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/patch_parameters_resource.json %}
{% endhighlight %}
</div>

## Response

Success:

- MUST return a `200` **SUCCESS** HTTP status code on successful execution of the interaction and the entry has been successfully updated in the NRL.
- MUST return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Operation Outcome'](http://hl7.org/fhir/STU3/operationoutcome.html) core FHIR resource (see the table below).
- When a resource has been updated, its `versionId` will be incremented.

{% include note.html content="The `versionId` is an integer that is assigned and maintained by the NRL server. When a new DocumentReference is created, the server assigns it a `versionId` of 1. The `versionId` will be incremented during an update or supersede transaction. <br/><br/> The NRL server will ignore any `versionId` value sent by a client in a `create` interaction. Instead, the server will ensure that the newly assigned `versionId` adheres to the rules laid out above.
" %}

The table summarises the `update` interaction HTTP response code and the values expected to be conveyed in the successful response body `OperationOutcome` payload:

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Details.Text |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|200|information|informational|RESOURCE_UPDATED|Resource has been updated| Spine message UUID |Successfully updated resource DocumentReference|

{% include note.html content="Upon successful update of a pointer the NRL Service returns in the response payload an OperationOutcome resource with the OperationOutcome.issue.details.text element populated with a Spine internal message UUID. This UUID is used to identify the client's Update transaction within Spine. A client system SHOULD reference the UUID in any calls raised with the Deployment Issues Resolution Team. The UUID will be used to retrieve log entries that relate to a specific client transaction." %}

Failure: 

The following errors can be triggered when performing this operation:

- [Invalid Request Message](development_general_api_guidance.html#invalid-request-message)
- [Invalid Resource](development_general_api_guidance.html#update-invalid-resource-errors)
- [Invalid Parameter](development_general_api_guidance.html#parameters)
- [Resource Not Found](development_general_api_guidance.html#resource-not-found)
- [Inactive Document Reference](development_general_api_guidance.html#inactive-documentreference)