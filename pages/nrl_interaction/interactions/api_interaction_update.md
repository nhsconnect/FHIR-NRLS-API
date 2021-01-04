---
title: API Update Interaction
keywords: structured update rest documentreference
tags: [fhir,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_update.html
summary: To support the update of NRL pointers.
---

{% include custom/fhir.reference.nonecc.html NHSDProfiles="[Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1)" HL7Profiles="[Parameters](https://www.hl7.org/fhir/STU3/parameters.html)" %}

## Update

Provider interaction to support the update of NRL pointers. The update functionality will be used in cases where a provider wishes to change a pointer's status from `current` to `entered-in-error`. The `update` interaction is a FHIR RESTful [patch](https://www.hl7.org/fhir/STU3/http.html#patch) interaction.

## Prerequisites

In addition to the requirements on this page, the general guidance and requirements detailed on the [NRL interaction overview](nrl_interaction_overview.html) page **MUST** be followed when using this interaction.

## Update Request Headers

The `update` interaction supports the following HTTP request headers:

|Header|Value|Conformance|
|------|-----|-----------|
| `Accept` | The `Accept` header indicates the format of the response the client is able to understand, if set, this must be either `application/fhir+json` or `application/fhir+xml`. | OPTIONAL |
| `Authorization` | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](guidance_jwt.html) page for details. | REQUIRED |
| `fromASID` | Client System ASID. | REQUIRED |
| `toASID` | The Spine ASID. | REQUIRED |

## Update Operation

Providers systems **MUST**:
- only update pointers for records where they are the pointer owner (custodian).
    - the custodian ODS code in the `DocumentReference` being updated **MUST** be affiliated with the Client System ASID value in the `fromASID` HTTP request header.
- construct a request body that conforms to the [FHIRPath PATCH](https://www.hl7.org/fhir/STU3/fhirpatch.html) [Parameters](https://www.hl7.org/fhir/STU3/parameters.html) FHIR resource (more details below).
- Use one of the two supported methods of pointer identification:
    - logical ID
        - The logical ID can be obtained from the `Location` header returned in a `create` interaction [response](api_interaction_create.html#create-response).
        - Example:
            <div markdown="span" class="alert alert-success" role="alert">
            `PATCH [baseUrl]/STU3/DocumentReference/[id]`
            </div>

            <div class="language-http highlighter-rouge">
            <pre class="highlight">
            <code><span class="err">PATCH [baseUrl]/STU3/DocumentReference/da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
            </span></code>
            Update the DocumentReference status for a pointer with the logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'.</pre>
            </div>
    - `masterIdentifier`
        - This option negates a need to persist or query the NRL to obtain the generated logical ID for the pointer.
        - The following query parameters should be used:
            - *[nhsNumber]* - The NHS Number of the patient related to the `DocumentReference`.
            - *[system]* - The namespace of the `masterIdentifier` value associated with the `DocumentReference`.
            - *[value]* - The value of the `masterIdentifier` associated with the `DocumentReference`.
        - Example:
            <div markdown="span" class="alert alert-success" role="alert">
            `PATCH [baseUrl]/STU3/DocumentReference?subject=[https://demographics.spineservices.nhs.uk/STU3/Patient/[nhsNumber]&amp;identifier=[system]%7C[value]`
            </div>

            <div class="language-http highlighter-rouge">
            <pre class="highlight">
            <code><span class="err">PATCH [baseUrl]/STU3/DocumentReference?subject=https%3A%2F%2Fdemographics.spineservices.nhs.uk%2FSTU3%2FPatient%2F9876543210%26identifier%3Durn%3Aietf%3Arfc%3A3986%257Curn%3Aoid%3A1.3.6.1.4.1.21367.2005.3.71
            </span></code>
            Update the DocumentReference status for a pointer with a subject and identifier.</pre>
            </div>

            {% include note.html content="All query parameters must be percent encoded. In particular, the pipe (`|`) character must be percent encoded (`%7C`)." %}
- submit the request to the NRL using the FHIR RESTful [patch](https://www.hl7.org/fhir/STU3/http.html#patch) interaction.

### Request Body

The [`Parameters`](https://www.hl7.org/fhir/STU3/parameters.html) resource **MUST** meet the following conditions:

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `parameter` | 1..1 | |
| `parameter.name` | 1..1 | Fixed value: `operation` |
| `parameter.part` | 3..3 | See table below. |

Three `part` elements are required as follows:

|`part.name`|`part.value[x]` name|`part.value[x]` value|
|------|---------------|----------------|
| Fixed value: `type` | Fixed value: `valueCode` | Fixed value: `replace` |
| Fixed value: `path` | Fixed value: `valueString` | Fixed value: `DocumentReference.status` |
| Fixed value: `value` | Fixed value: `valueString` | Fixed value: `entered-in-error` |

{% include note.html content="Only the first `parameter` element within the `Parameters` resource will be used to perform a PATCH. Any additional `parameter` elements included within the request will be ignored." %}

### XML FHIRPath PATCH `Parameters` Resource Example

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/patch_parameters_resource.xml %}
{% endhighlight %}
</div>

### JSON FHIRPath PATCH `Parameters` Resource Example

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/patch_parameters_resource.json %}
{% endhighlight %}
</div>

## Response

### Success

A successful execution of the `update` interaction will:
- return a `200` **OK** HTTP status code confirming the entry has been successfully updated in the NRL.
- return a response body containing an `OperationOutcome` resource (see below for full details).
- increment the resource's `versionId` by 1.

#### OperationOutcome

The `OperationOutcome` resource in the response body will conform to the [Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) FHIR resource:

|Element|Content|
|-------|-------|
|`id`|A UUID for this `OperationOutcome`.|
|`meta.profile`|Fixed value: `https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1`|
|`issue.severity`|Fixed value: `information`|
|`issue.code`|Fixed value: `informational`|
|`issue.details.coding.system`|Fixed value: `https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1`|
|`issue.details.coding.code`|Fixed value: `RESOURCE_UPDATED`|
|`issue.details.coding.display`|Fixed value: `Resource has been updated`|
|`issue.details.text`| A Spine internal message UUID which can be used to identify the client’s create transaction within Spine. A client system SHOULD reference this UUID in any related incidents raised with the [National Service Desk](https://digital.nhs.uk/services/spine/spine-mini-service-provider-for-personal-demographics-service/service-management-live-service). The UUID will be used to retrieve log entries that relate to a specific client transaction. |
|`issue.diagnostics`|Dynamic value: `Successfully updated resource DocumentReference: [URL]`|

#### Example success response body (XML)

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/update_response.xml %}
{% endhighlight %}
</div>

#### Example success response body (JSON)

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/update_response.json %}
{% endhighlight %}
</div>

### Failure

The following errors may be triggered when performing this operation:

- [Invalid Request Message](guidance_errors.html#invalid-request-message)
- [Invalid Resource](guidance_errors.html#invalid-resource)
- [Invalid Parameter](guidance_errors.html#parameters)
- [Resource Not Found](guidance_errors.html#resource-not-found)
- [Inactive DocumentReference](guidance_errors.html#inactive-documentreference)

## Explore the NRL
You can explore and test the update interaction using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).
