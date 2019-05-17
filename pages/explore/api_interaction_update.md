---
title: API Update Interaction
keywords: structured, update, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_update.html
summary: To support the update of NRL pointers
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Update ##

API to support the update of NRL pointers. This functionality is only available for providers. The update functionality will be used in cases where a Provider wishes to update a pointer status value from “current” of “entered-in-error”. 

## Update Request Headers ##

Provider API update requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |


## Update Operation ##

Provider system will construct a [FHIRPath PATCH Parameters resource](https://www.hl7.org/fhir/fhirpatch.html) and submit this to NRL using the FHIR RESTful [patch](https://www.hl7.org/fhir/http.html#patch) interaction.

<div markdown="span" class="alert alert-success" role="alert">
PATCH [baseUrl]/DocumentReference/[id]</div>

The API supports the conditional update interaction which allows a provider to update a pointer using the masterIdentifier so they do not have to persist or query for the NRL generated logical id for the pointer. The query parameters should be used as shown:

<div markdown="span" class="alert alert-success" role="alert">
PATCH [baseUrl]/DocumentReference?subject=[https://demographics.spineservices.nhs.uk/STU3/Patient/[nhsNumber]&amp;identifier=[system]%7C[value]</div>

*[nhsNumber]* - The NHS number of the patient whose DocumentReferences the client is requesting

*[system]* - The namespace of the masterIdentifier value that is associated with the DocumentReference(s)

*[value]* - The value of the masterIdentifier that is associated with the DocumentReference(s)

Providers systems SHALL only update pointers for records where they are the pointer owner (custodian).
For all update requests the custodian ODS code in the DocumentReference resource SHALL be affiliated with the Client System ASID value in the fromASID HTTP request header sent to the NRL.

The FHIRPath Parameters resource must conform either the XML or JSON example as shown below. All parameters and their associated values are mandatory. 

### XML FHIRPath PATCH Parameters resource ###

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/patch_parameters_resource.xml %}
{% highlight XML %}
{% github_sample /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/patch_parameters_resource.xml 0 16 %}
{% endhighlight %}
</div>

### JSON FHIRPath PATCH Parameters resource ###

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/patch_parameters_resource.json %}
{% highlight json-doc %}
{% github_sample /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/patch_parameters_resource.json %}
{% endhighlight %}
</div>

## Response ##

Success:

- SHALL return a `200` **SUCCESS** HTTP status code on successful execution of the interaction and the entry has been successfully updated in the NRL.
- SHALL return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Operation Outcome'](http://hl7.org/fhir/STU3/operationoutcome.html) core FHIR resource. See table below.
- SHALL return an HTTP `Location` response header containing the full resolvable URL to the newly created 'single' DocumentReference. 
  - The URL will contain the 'server' assigned `logical Id` of the new DocumentReference resource.
  - The URL format MUST be: `https://[host]/[path]/[id]`. 
  - An example `Location` response header: 
    - `https://psis-sync.national.ncrs.nhs.uk/DocumentReference/297c3492-3b78-11e8-b333-6c3be5a609f5-54477876544511209789`
- When a resource has been upcated it will have a `versionId` of 2.


{% include note.html content="The versionId is an integer that is assigned and maintained by the NRL server. When a new DocumentReference is created the server assigns it a versionId of 1. The versionId will be incremeted during an update or supersede transaction. <br/><br/> The NRL server will ignore any versionId value sent by a client in a create interaction. Instead the server will ensure that the newly assigned verionId adheres to the rules laid out above. 
" %}

The table summarises the `update` interaction HTTP response code and the values expected to be conveyed in the successful response body `OperationOutcome` payload:

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Details.Text |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|200|information|informational|RESOURCE_UPDATED|Resource has been updated| Spine message UUID |Successfully updated resource DocumentReference|

{% include note.html content="Upon successful creation of a pointer the NRL Service returns in the reponse payload an OperationOutcome resource with the OperationOutcome.issue.details.text element populated with a Spine internal message UUID. This UUID is used to identify the client's Create transaction within Spine. A client system SHOULD reference the UUID in any calls raised with the Deployment Issues Resolution Team. The UUID will be used to retrieve log entries that relate to a specific client transaction." %}

Failure: 

The following errors can be triggered when performing this operation:

- [Invalid Request Message](development_general_api_guidance.html#invalid-request-message)
- [Invalid Resource](development_general_api_guidance.html#invalid-resource)
- [Organisation not found](development_general_api_guidance.html#organisation-not-found)
- [Invalid NHS Number](development_general_api_guidance.html#invalid-nhs-number)
- [Invalid Parameter](development_general_api_guidance.html#parameters)
- [Duplicate Resource](development_general_api_guidance.html#duplicate-resource)