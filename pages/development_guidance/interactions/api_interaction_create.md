---
title: API Create Interaction
keywords: structured rest documentreference
tags: [fhir,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_create.html
summary: To support the creation of NRL pointers.
---

{% include custom/fhir.reference.nonecc.html resource="NRL-DocumentReference-1" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Create

Provider interaction to support the creation of NRL pointers. The create interaction is a FHIR RESTful [create](https://www.hl7.org/fhir/STU3/http.html#create) interaction.

## Prerequisites

In addition to the requirements on this page, the general guidance and requirements detailed on the [Development Overview](development_overview.html) page **MUST** be followed when using this interaction.

## Create Request Headers

Provider API create requests support the following HTTP request headers:

|Header|Value|Conformance|
|------|-----|-----------|
| `Accept` | The `Accept` header indicates the format of the response the client is able to understand, if set, this must be either `application/fhir+json` or `application/fhir+xml`. | OPTIONAL |
| `Authorization` | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](guidance_jwt.html) page for details. | REQUIRED |
| `fromASID` | Client System ASID. | REQUIRED |
| `toASID` | The Spine ASID. | REQUIRED |

## Create Operation

<div markdown="span" class="alert alert-success" role="alert">
`POST [baseUrl]/STU3/DocumentReference`
</div>

Provider systems **MUST**:

- construct and send a new pointer (DocumentReference) resource that conforms to the `NRL-DocumentReference-1` profile and submit this to the NRL using the FHIR RESTful [create](https://www.hl7.org/fhir/stu3/http.html#create) interaction.
- include all of the mandatory data-elements contained in the `NRL-DocumentReference-1` profile when constructing a `DocumentReference`. The mandatory data-elements are detailed on the [Developer FHIR Resource](pointer_fhir_resource.html) page.
- follow all population guidance as outlined on the [Developer FHIR Resource](pointer_fhir_resource.html) page when constructing a `DocumentReference`.
- only create pointers for records where they are the pointer owner (custodian).

For all create requests the `custodian` ODS code in the `DocumentReference` **MUST** be affiliated with the `Client System ASID` value in the `fromASID` HTTP request header sent to the NRL.

### XML Example of a New DocumentReference Resource (Pointer)

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/create_documentreference_resource.xml %}
{% endhighlight %}
</div>

### JSON Example of a New DocumentReference Resource (Pointer)
<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/create_documentreference_resource.json %}
{% endhighlight %}
</div>

## Create Response

### Success

A successful execution of the `create` interaction will return:
- a `201` **CREATED** HTTP status code confirming the entry has been successfully created in the NRL.
- a response body containing an `OperationOutcome` resource (see below for full details).
- an HTTP `Location` response header containing the full resolvable URL to the newly created 'single' `DocumentReference`:
  - The URL will contain the 'server' assigned `logical id` of the new `DocumentReference` resource.
  - The URL format will be: `https://[host]/[path]/[id]`.
  - An example `Location` response header:
    - `https://psis-sync.national.ncrs.nhs.uk/DocumentReference/297c3492-3b78-11e8-b333-6c3be5a609f5-54477876544511209789`

When a resource has been created it will have a `versionId` of 1.

{% include note.html content="The versionId is an integer that is assigned and maintained by the NRL server. When a new DocumentReference is created the server assigns it a versionId of 1. The versionId will be incremented during an update or supersede transaction. See [API Interaction - Update](api_interaction_update.html) and [API Interaction - Supersede](api_interaction_supersede.html) for more details on these transactions.<br /><br />The NRL server will ignore any versionId value sent by a client in a create interaction. Instead, the server will ensure that the newly assigned versionId adheres to the rules laid out above." %}

#### OperationOutcome

The `OperationOutcome` resource in the response body will conform to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) FHIR resource:

|Element|Content|
|-------|-------|
| `id` | A UUID for this `OperationOutcome`. |
| `meta.profile` | Fixed value: `https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1` |
| `issue.severity` | Fixed value: `information` |
| `issue.code` | Fixed value: `informational` |
| `issue.details.coding.system` | Fixed value: `https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1` |
| `issue.details.coding.code` | Fixed value: `RESOURCE_CREATED` |
| `issue.details.coding.display` | Fixed value: `New resource created` |
| `issue.details.text` | A Spine internal message UUID which can be used to identify the client's create transaction within Spine. A client system SHOULD reference this UUID in any related incidents raised with the [National Service Desk](https://digital.nhs.uk/services/spine/spine-mini-service-provider-for-personal-demographics-service/service-management-live-service). The UUID will be used to retrieve log entries that relate to a specific client transaction. |
| `issue.diagnostics` | Fixed value: `Successfully created resource DocumentReference` |

#### Example success response body (XML)

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/create_response.xml %}
{% endhighlight %}
</div>

#### Example success response body (JSON)

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/create_response.json %}
{% endhighlight %}
</div>

### Failure

The following errors can be triggered when performing this operation:

- [Invalid Request Message](guidance_errors.html#invalid-request-message)
- [Invalid Resource](guidance_errors.html#invalid-resource)
- [Organisation not found](guidance_errors.html#organisation-not-found)
- [Invalid NHS Number](guidance_errors.html#invalid-nhs-number)
- [Invalid Parameter](guidance_errors.html#parameters)
- [Duplicate Resource](guidance_errors.html#duplicate-resource)
- [Missing or Invalid Headers](guidance_errors.html#headers)

## Explore the NRL

You can explore and test the create interaction using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).
