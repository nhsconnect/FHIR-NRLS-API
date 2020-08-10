---
title: API Create Interaction
keywords: structured rest documentreference
tags: [fhir,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_create.html
summary: To support the creation of NRL pointers
---

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Create

Provider interaction to support the creation of NRL pointers.

## Prerequisites

In addition to the requirements on this page the general guidance and requirements detailed on the [Development Overview](development_overview.html) page MUST be followed when using this interaction.

## Create Request Headers

Provider API create requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. | OPTIONAL |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](jwt_guidance.html) page for details. | REQUIRED |
| `fromASID`           | Client System ASID | REQUIRED |
| `toASID`             | The Spine ASID | REQUIRED |

## Create Operation

<div markdown="span" class="alert alert-success" role="alert">
`POST [baseUrl]/DocumentReference`
</div>

Provider systems:

- MUST construct and send a new Pointer (DocumentReference) resource that conforms to the NRL-DocumentReference-1 profile and submit this to NRL using the FHIR RESTful [create](https://www.hl7.org/fhir/stu3/http.html#create) interaction.
- MUST include the URI of the NRL-DocumentReference-1 profile StructureDefinition in the DocumentReference.meta.profile element of the DocumentReference resource.
- MUST include all of the mandatory data-elements contained in the `NRL-DocumentReference-1` profile when constructing a DocumentReference. The mandatory data-elements are detailed on the [Developer FHIR Resource](explore_reference.html) page.
- MUST supply `subject`, `custodian` and `author` attributes as absolute literal references, the formats of which can be found on the [Developer FHIR Resource](explore_reference.html) page.
- MUST only create pointers for records where they are the pointer owner (custodian). 

For all create requests the `custodian` ODS code in the DocumentReference resource MUST be affiliated with the `Client System ASID` value in the `fromASID` HTTP request header sent to the NRL.

### XML Example of a New DocumentReference Resource (Pointer)

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/create_documentreference_resource.xml %}
{% endhighlight %}
</div>

### JSON Example of a New DocumentReference Resource (Pointer)
<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/create_documentreference_resource.json  %}
{% endhighlight %}
</div>

## Create Response

### Success

- will return a `201` **CREATED** HTTP status code on successful execution of the interaction and the entry has been successfully created in the NRL.
- will return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Operation Outcome'](http://hl7.org/fhir/STU3/operationoutcome.html) core FHIR resource (see the table below).
- will return an HTTP `Location` response header containing the full resolvable URL to the newly created 'single' DocumentReference. 
  - The URL will contain the 'server' assigned `logical Id` of the new DocumentReference resource.
  - The URL format will be: `https://[host]/[path]/[id]`. 
  - An example `Location` response header: 
    - `https://psis-sync.national.ncrs.nhs.uk/DocumentReference/297c3492-3b78-11e8-b333-6c3be5a609f5-54477876544511209789`
- When a resource has been created it will have a `versionId` of 1.

{% include note.html content="The versionId is an integer that is assigned and maintained by the NRL server. When a new DocumentReference is created the server assigns it a versionId of 1. The versionId will be incremented during an update or supersede transaction. See [API Interaction - Update](api_interaction_update.html) and [API Interaction - Supersede](api_interaction_supersede.html) for more details on these transactions.<br/><br/> The NRL server will ignore any versionId value sent by a client in a create interaction. Instead, the server will ensure that the newly assigned versionId adheres to the rules laid out above. 
" %}

The table summarises the `create` interaction HTTP response code and the values expected to be conveyed in the successful response body `OperationOutcome` payload:

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Details.Text |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|201|information|informational|RESOURCE_CREATED|New resource created | Spine message UUID |Successfully created resource DocumentReference|

{% include note.html content="Upon successful creation of a pointer the NRL Service returns in the response payload an OperationOutcome resource with the OperationOutcome.issue.details.text element populated with a Spine internal message UUID. This UUID is used to identify the client's Create transaction within Spine. A client system SHOULD reference the UUID in any calls raised with the Deployment Issues Resolution Team. The UUID will be used to retrieve log entries that relate to a specific client transaction." %}

### Failure

The following errors can be triggered when performing this operation:

- [Invalid Request Message](nrl_error_guidance.html#invalid-request-message)
- [Invalid Resource](nrl_error_guidance.html#invalid-resource)
- [Organisation not found](nrl_error_guidance.html#organisation-not-found)
- [Invalid NHS Number](nrl_error_guidance.html#invalid-nhs-number)
- [Invalid Parameter](nrl_error_guidance.html#parameters)
- [Duplicate Resource](nrl_error_guidance.html#duplicate-resource)
- [Missing or Invalid Headers](nrl_error_guidance.html#headers)


## Explore the NRL

You can explore and test the NRL POST command using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html#/Nrls/createPointer).
