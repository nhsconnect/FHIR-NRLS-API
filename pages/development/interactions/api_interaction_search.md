---
title: API Search Interaction
keywords: structured rest documentreference
tags: [fhir,pointers,for_consumers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_search.html
summary: To support a parameterised search of the NRL.
---

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl="https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Search

Consumer interaction to support a parameterised search of the NRL. The search interaction is a FHIR RESTful [search](https://www.hl7.org/fhir/STU3/http.html#search) interaction.

## Prerequisites

In addition to the requirements on this page, the general guidance and requirements detailed on the [Development Overview](development_overview.html) page **MUST** be followed when using this interaction.

## Search Request Headers

Consumer API search requests support the following HTTP request headers:

|Header|Value|Conformance|
|------|-----|-----------|
| `Accept` | The `Accept` header indicates the format of the response the client is able to understand, if set, this must be either `application/fhir+json` or `application/fhir+xml`. | OPTIONAL |
| `Authorization` | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](jwt_guidance.html) page for details. | REQUIRED |
| `fromASID` | Client System ASID. | REQUIRED |
| `toASID` | The Spine ASID. | REQUIRED |

## Search DocumentReference

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?[searchParameters]`
</div>

## Search Parameters

This implementation guide outlines the search parameters for the `DocumentReference` resource in the table below:

|Name|Type|Description|Path|
|----|----|-----------|----|
|`_id`|[id](http://hl7.org/fhir/stu3/datatypes.html#id)|Logical ID of the resource.|`DocumentReference.id`|
|`subject`|[reference](https://www.hl7.org/fhir/STU3/references.html)|Subject (patient) of the `DocumentReference`.|`DocumentReference.subject` (Patient NHS Number)|
|`custodian`|[reference](https://www.hl7.org/fhir/STU3/references.html)|Organisation which maintains the `DocumentReference`.|`DocumentReference.custodian` (Organisation ODS Code)|
|`type`|[Coding](http://hl7.org/fhir/stu3/datatypes.html#coding)|Information type (SNOMED CT).|`DocumentReference.type.coding`|
|`_summary`|[summary](https://www.hl7.org/fhir/search.html#summary)|Total number of matching results.|N/A|

A search is made using either the `_id` or `subject` search parameter.

- The `_id` search parameter **MUST NOT** be used in conjunction with any other search parameter (with the exception of the `_format` parameter).
- The `custodian` and/or `type` search parameters can only be used in conjunction with the `subject` search parameter to form a combination search query.

{% include note.html content="All query parameters must be percent encoded. In particular, the pipe (`|`) character must be percent encoded (`%7C`)." %}

### **`_id`**

The `_id` search parameter refers to the logical ID of the `DocumentReference` resource.

Functionally this search is the equivalent to a simple pointer read operation.

See [`_id`](https://www.hl7.org/fhir/stu3/search.html#id) for details on this search parameter. The `_id` search parameter can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?_id=[id]`</div>

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?_id=da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Search for the DocumentReference resource for a pointer with the logical ID of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'</pre>
</div>

The `_id` search parameter cannot be used in conjunction with any other search parameter (with the exception of the `_format` parameter.)

### **`subject`**

See [`reference`](https://www.hl7.org/fhir/STU3/search.html#reference) for details on this search parameter. The `subject` search parameter can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]`</div>

The `subject` search parameter **MUST** follow the format:

`https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]`

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210
</span></code>
Return all DocumentReference resources for a patient with an NHS Number of 9876543210.</pre>
</div>

### **`subject` and `type`**

The `subject` and `type` search parameters can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]&type.coding=[system]%7C[code]`</div>

The `subject` search parameter **MUST** follow the format:

`https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]`

The `type` search parameter **MUST** follow the format:

`[system]|[code]`

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https%3A%2F%2Fdemographics.spineservices.nhs.uk%2FSTU3%2FPatient%2F9876543210&type.coding=http%3A%2F%2Fsnomed.info%2Fsct%7C736253002
</span></code>
Return all DocumentReference resources for a patient with an NHS Number of 9876543210 and pointer type 'Mental health crisis plan'.</pre>
</div>

### **`subject` and `custodian`**

The `subject` and `custodian` search parameters can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]&custodian=[reference]`</div>

The `subject` search parameter **MUST** follow the format:

`https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]`

The `custodian` search parameter **MUST** follow the format:

`https://directory.spineservices.nhs.uk/STU3/Organization/[ODS Code]`

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https%3A%2F%2Fdemographics.spineservices.nhs.uk%2FSTU3%2FPatient%2F9876543210&custodian=https%3A%2F%2Fdirectory.spineservices.nhs.uk%2FSTU3%2FOrganization%2FRR8
</span></code>
Return all DocumentReference resources for a patient with an NHS Number of 9876543210 and pointer owner with ODS code RR8.</pre>
</div>

### **`_summary`**

The `_summary` search parameter allows the consumer to retrieve the number of `DocumentReference`s that match a given search.

See [`_summary`](https://www.hl7.org/fhir/search.html#summary) for details on this search parameter. The `_summary` search parameter can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]&_summary=count`</div>

The `subject` search parameter **MUST** follow the format:

`https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]`

The `_summary` search parameter **MUST** have the value `count` (other FHIR values for this search parameter are not supported).

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https%3A%2F%2Fdemographics.spineservices.nhs.uk%2FSTU3%2FPatient%2F9876543210&_summary=count
</span></code>
Return a count of resources for a patient with an NHS Number of 9876543210.</pre>
</div>

## Search Response

### Success

A successful execution of the search interaction will:
- return a `200` **OK** HTTP status code.
- return a `Bundle` response boby of type `searchset`, containing either:
    - A `0` (zero) total value indicating no records matched the search criteria, i.e. an empty `Bundle`.

    {% include note.html content="The NRL service will ONLY return an empty bundle if a Spine Clinicals record exists and there is no DocumentReference for that specific Clinicals record." %}
    
    - One or more `DocumentReference` resources (with a `current` status) that conform to the NRL `DocumentReference` FHIR profile.
        - The current `versionId` will be included.
        - If `masterIdentifier` and/or `relatesTo` are set, they will be included.
    
    {% include note.html content="The version of the pointer model (FHIR profile) will be indicated in the `DocumentReference.meta.profile` metadata attribute for each pointer (see [FHIR Resources & References](explore_reference.html#1-profiles)). A 'Bundle' may contain pointers which conform to different versions of the pointer model." %}

### Failure

The following errors can be triggered when performing this operation:

- [Invalid NHS number](nrl_error_guidance.html#invalid-nhs-number)
- [Invalid parameter](nrl_error_guidance.html#parameters)
- [No record found](nrl_error_guidance.html#resource-not-found)

### Example: Single Pointer Response

- Request was successfully executed (`200` **OK** HTTP status).
- Response body is a `Bundle` resource of type `searchset` containing 1 `DocumentReference` resource conforming to the `NRL-DocumentReference-1` profile.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_single_pointer.xml %}
{% endhighlight %}
</div>

### Example: Multiple Pointers Response

- Request was successfully executed (`200` **OK** HTTP status).
- Response body is a `Bundle` resource of type `searchset` containing 2 `DocumentReference` resources conforming to the `NRL-DocumentReference-1` profile.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_multiple_pointers.xml %}
{% endhighlight %}
</div>

### Example: No Pointers Response

- Request was successfully executed (`200` **OK** HTTP status).
- Response body is an empty `Bundle` resource of type `searchset` containing 0 (zero) `DocumentReference` resources indicating no record was matched.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_empty.xml %}
{% endhighlight %}
</div>

### Examples: `_summary=count` Response

When using the `_summary=count` search parameter, the response body will contain an XML or JSON formatted `Bundle` of type `searchset` that reports the total number of resources matching the search criteria in field `Bundle.total` (no entries or prev/next/last links).

#### Three `DocumentReference`s exist for patient

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_summary_count3.xml %}
{% endhighlight %}
</div>

#### No `DocumentReference`s exist for patient

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_summary_count0.xml %}
{% endhighlight %}
</div>

## Explore the NRL

You can explore and test the search interaction using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).
