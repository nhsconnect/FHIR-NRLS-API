---
title: API Search Interaction
keywords: structured rest documentreference
tags: [fhir,pointers,for_consumers]
sidebar: overview_sidebar
permalink: api_interaction_search.html
summary: How to perform a parameterised search of the NRL.
---

{% include custom/fhir.reference.nonecc.html NHSDProfiles="[NRL-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1), [Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1)" HL7Profiles="[Bundle](https://www.hl7.org/fhir/STU3/bundle.html)" %}

## Search

Consumer interaction to support a parameterised search of the NRL. The `search` interaction is a FHIR RESTful [search](https://www.hl7.org/fhir/STU3/http.html#search) interaction.

## Prerequisites

In addition to the requirements on this page, the general guidance and requirements detailed on the [NRL interaction overview](nrl_interaction_overview.html) page **MUST** be followed when using this interaction.

## Search Request Headers

Consumer API search requests support the following HTTP request headers:

|Header|Value|Conformance|
|------|-----|-----------|
| `Accept` | The `Accept` header indicates the format of the response the client is able to understand, if set, this must be either `application/fhir+json` or `application/fhir+xml`. | OPTIONAL |
| `Authorization` | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](guidance_jwt.html) page for details. | REQUIRED |
| `fromASID` | Client System ASID. | REQUIRED |
| `toASID` | The Spine ASID. | REQUIRED |

## Search Operation

The `search` interaction allows a consumer to query the NRL to obtain:
- all pointers (`DocumentReference`s) related to a specific NHS Number.
- a specific pointer (equivalent to the [read](api_interaction_read.html) interaction).

The consumer **MUST** submit the request to the NRL using:
- the following URL format (details on search parameters below):
    <div markdown="span" class="alert alert-success" role="alert">
    `GET [baseUrl]/STU3/DocumentReference?[searchParameters]`
    </div>
- the FHIR RESTful [search](https://www.hl7.org/fhir/stu3/http.html#search) interaction.

### Search Parameters

A variety of search parameters can be used to perform different types of search:

|Name|Type|Description|`DocumentReference` FHIRPath|
|----|----|-----------|--------|
|`_id`|[id](http://hl7.org/fhir/stu3/datatypes.html#id)|Logical ID of the resource.<br /><br />See [`_id`](https://www.hl7.org/fhir/stu3/search.html#id) for more details on this search parameter.|`id`|
|`subject`|[reference](https://www.hl7.org/fhir/STU3/references.html)|Subject (patient) of the `DocumentReference` (patient's NHS Number).<br /><br />See [`reference`](https://www.hl7.org/fhir/STU3/search.html#reference) for more details on this search parameter.|`subject`|
|`type`|[Coding](http://hl7.org/fhir/stu3/datatypes.html#coding)|Information type (SNOMED CT).|`type.coding`|
|`custodian`|[reference](https://www.hl7.org/fhir/STU3/references.html)|Organisation which maintains the `DocumentReference` (organisation's ODS code).|`custodian`|

Each search **MUST** include either the `_id` or `subject` search parameter.

- The `_id` search parameter **MUST NOT** be used in conjunction with any other search parameter (with the exception of the `_format` parameter).
- The `type` and `custodian` search parameters can **ONLY** be used in conjunction with the `subject` search parameter, but cannot be combined with each other.

{% include note.html content="All query parameters must be percent encoded. In particular, the pipe (`|`) character must be percent encoded (`%7C`)." %}

#### **`_id`**

The `_id` search parameter refers to the logical ID of the `DocumentReference` resource (which can be obtained from the `Location` header returned in a `create` interaction [response](api_interaction_create.html#create-response)).

Functionally, this search is the equivalent to the [read](api_interaction_read.html) interaction.

The `_id` search parameter can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?_id=[id]`</div>

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?_id=da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Search for the DocumentReference resource for a pointer with the logical ID of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'</pre>
</div>

The `_id` search parameter **CANNOT** be used in conjunction with any other search parameter (with the exception of the `_format` parameter.)

#### **`subject`**

The `subject` search parameter refers to a patient's NHS Number and can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]`</div>

The `subject` search parameter **MUST** follow the format:

`https://demographics.spineservices.nhs.uk/STU3/Patient/[nhsNumber]`

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210
</span></code>
Return all DocumentReference resources for a patient with an NHS Number of 9876543210.</pre>
</div>

#### **`subject` and `type`**

The `type` search parameter can be combined as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]&type.coding=[system]%7C[code]`</div>

The `type` search parameter **MUST** follow the format:

`[system]|[code]`

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https%3A%2F%2Fdemographics.spineservices.nhs.uk%2FSTU3%2FPatient%2F9876543210&type.coding=http%3A%2F%2Fsnomed.info%2Fsct%7C736253002
</span></code>
Return all DocumentReference resources for a patient with an NHS Number of 9876543210 and pointer type 'Mental health crisis plan'.</pre>
</div>

#### **`subject` and `custodian`**

The `custodian` search parameter can be combined as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]&custodian=[reference]`</div>

The `custodian` search parameter **MUST** follow the format:

`https://directory.spineservices.nhs.uk/STU3/Organization/[ODS Code]`

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https%3A%2F%2Fdemographics.spineservices.nhs.uk%2FSTU3%2FPatient%2F9876543210&custodian=https%3A%2F%2Fdirectory.spineservices.nhs.uk%2FSTU3%2FOrganization%2FRR8
</span></code>
Return all DocumentReference resources for a patient with an NHS Number of 9876543210 and pointer owner with ODS code RR8.</pre>
</div>


## Search Response

### Success

A successful execution of the `search` interaction will return:
- a `200` **OK** HTTP status code.
- a [`Bundle`](https://www.hl7.org/fhir/STU3/bundle.html) response body of type `searchset`, containing either:
    - A `0` (zero) `Bundle.total` value indicating no records matched the search criteria i.e. an empty `Bundle`.

    {% include note.html content="The NRL will only return an empty bundle if a Spine Clinicals record exists and there are no `DocumentReference`s for that specific Clinicals record." %}
    
    - One or more `DocumentReference` resources (with a `current` status) that conform to the `NRL-DocumentReference-1` profile.
        - The current `versionId` will be included.
        - If `masterIdentifier` and/or `relatesTo` are set, they will be included.
    
    {% include note.html content="The version of the pointer model (FHIR profile) will be indicated in the `DocumentReference.meta.profile` attribute for each pointer (see [Pointer FHIR Resource](pointer_fhir_resource.html#fhir-profile)). A 'Bundle' may contain pointers which conform to different versions of the pointer model." %}


#### Example: Single Pointer Response

- Request was successfully executed (`200` **OK** HTTP status).
- Response body is a `Bundle` resource of type `searchset` containing 1 `DocumentReference` resource conforming to the `NRL-DocumentReference-1` profile.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_single_pointer.xml %}
{% endhighlight %}
</div>

#### Example: Multiple Pointers Response

- Request was successfully executed (`200` **OK** HTTP status).
- Response body is a `Bundle` resource of type `searchset` containing 2 `DocumentReference` resources conforming to the `NRL-DocumentReference-1` profile.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_multiple_pointers.xml %}
{% endhighlight %}
</div>

#### Example: No Pointers Response

- Request was successfully executed (`200` **OK** HTTP status).
- Response body is an empty `Bundle` resource of type `searchset` containing 0 (zero) `DocumentReference` resources indicating no record was matched.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_empty.xml %}
{% endhighlight %}
</div>

### Failure

The following errors may be triggered when performing this operation:

- [Invalid NHS number](guidance_errors.html#invalid-nhs-number)
- [Invalid parameter](guidance_errors.html#parameters)
- [No record found](guidance_errors.html#resource-not-found)

## Explore the NRL

You can explore and test the search interaction using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).
