---
title: API Search Interaction
keywords: structured rest documentreference
tags: [fhir,pointers,for_consumers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_search.html
summary: To support parameterised search of the NRL.
---

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Search

Consumer interaction to support parameterised search of the NRL. The delete interaction is a FHIR RESTful [search](https://www.hl7.org/fhir/STU3/http.html#search) interaction.


## Prerequisites

In addition to the requirements on this page, the general guidance and requirements detailed on the [Development Overview](development_overview.html) page MUST be followed when using this interaction.

## Search Request Headers

Consumer and Provider API search requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. | OPTIONAL |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](jwt_guidance.html) page for details. | REQUIRED |
| `fromASID`           | Client System ASID | REQUIRED |
| `toASID`             | The Spine ASID | REQUIRED |

## Search DocumentReference

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?[searchParameters]`
</div>


## Search Parameters

This implementation guide outlines the search parameters for the `DocumentReference` resource in the table below. 

<table style="min-width:100%;width:100%">
<tr id="clinical">
    <th style="width:15%;">Name</th>
    <th style="width:15%;">Type</th>
    <th style="width:35%;">Description</th>
    <th style="width:35%;">Path</th>
</tr>
<tr>
    <td><code class="highlighter-rouge">_id</code></td>
    <td><code class="highlighter-rouge">token</code></td>
    <td>The logical id of the resource</td>
    <td>DocumentReference.id</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">custodian</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Organisation which maintains the document reference</td>
    <td>DocumentReference.custodian<br>(Organisation ODS Code)</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">subject</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Who/what is the subject of the document</td>
    <td>DocumentReference.subject<br>(Patient NHS Number)</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">type</code></td>
    <td><code class="highlighter-rouge">token</code></td>
    <td>Information type (SNOMED CT)</td>
    <td>DocumentReference.type</td>
</tr> 
<tr>
    <td><code class="highlighter-rouge">_summary</code></td>
    <td><code class="highlighter-rouge">Summary</code></td>
    <td>Total number of matching results</td>
    <td>N/A</td>
</tr>
</table>

When the `_id` search parameter is used by a client it MUST only be used as a single search parameter and MUST not be used in conjunction with any other search parameter to form part of a combination search query with the exception of the `_format` parameter.

When the `subject` parameter is used by a client it MAY be used in conjunction with the `custodian` and/or `type` search parameters to form a combination search query. The `custodian` and `type` search parameters MUST only be used to form combination search queries.

{% include note.html content="All query parameters must be percent encoded. In particular, the pipe (`|`) character must be percent encoded (`%7C`)." %}

### **`_id`**

The search parameter `_id` refers to the logical id of the DocumentReference resource and can be used when the search context specifies the DocumentReference resource type.

Functionally this search is the equivalent to a simple pointer read operation.

See [`_id`](https://www.hl7.org/fhir/stu3/search.html#id) for details on this parameter. The _id parameter can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?_id=[id]`</div>

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?_id=da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Search for the DocumentReference resource for a pointer with the logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'</pre>
</div>

When the `_id` search parameter is used by a client, this search parameter MUST only be used as a single search parameter and MUST not be used in conjunction with any other parameter to form part of a combination search query with the exception of the`‘_format’` parameter.

### **`subject`**

See [`reference`](https://www.hl7.org/fhir/STU3/search.html#reference) for details on this parameter. The subject parameter can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]`</div>

The `subject` query parameter MUST follow the format:

`https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]`

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210
</span></code>
Return all DocumentReference resources for a patient with a NHS Number of 9876543210</pre>
</div>

### **`subject` and `type`**

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]&type.coding=[system]%7C[code]`</div>

The `subject` query parameter MUST follow the format:

`https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]`

The `type` query parameter MUST follow the format:

`[system]|[code]`

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https%3A%2F%2Fdemographics.spineservices.nhs.uk%2FSTU3%2FPatient%2F9876543210&type.coding=http%3A%2F%2Fsnomed.info%2Fsct%7C736253002
</span></code>
Return all DocumentReference resources for a patient with a NHS Number of 9876543210 and pointer type mental health crisis plan</pre>
</div>

### **`subject` and `custodian`**

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]&custodian=[reference]`</div>

The `subject` query parameter MUST follow the format:

`https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]`

The `custodian` query parameter MUST follow the format:

`https://directory.spineservices.nhs.uk/STU3/Organization/[ODS Code]`

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https%3A%2F%2Fdemographics.spineservices.nhs.uk%2FSTU3%2FPatient%2F9876543210&custodian=https%3A%2F%2Fdirectory.spineservices.nhs.uk%2FSTU3%2FOrganization%2FRR8
</span></code>
Return all DocumentReference resources for a patient with a NHS Number of 9876543210 and pointer owner with ODS code RR8</pre>
</div>

### **`_summary`**

The search parameter `_summary` allows the client to retrieve the number of `DocumentReference`s that match a given search.

See [`_summary`](https://www.hl7.org/fhir/search.html#summary) for details on this parameter. The _summary parameter can be used as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference?subject=[reference]&_summary=count`</div>

The `subject` query parameter MUST follow the format:

`https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]`

The `_summary` search parameter MUST be set to the value `count` to retrieve the number of matching results. Other FHIR values for this search parameter are not supported.

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">GET [baseUrl]/STU3/DocumentReference?subject=https%3A%2F%2Fdemographics.spineservices.nhs.uk%2FSTU3%2FPatient%2F9876543210&_summary=count
</span></code>
Return a count of resources for a patient with a NHS Number of 9876543210</pre>
</div>

## Search Response

Success:

- will return a `200` **OK** HTTP status code on successful execution of the interaction.
- will return a `Bundle` of `type` searchset, containing either:
    - One or more `DocumentReference` resources that conform to the NRL `DocumentReference` FHIR profile and that have the status value of "current". 
    
      {% include note.html content="The version of the pointer model (FHIR profile) will be indicated in the `DocumentReference.meta.profile` metadata attribute for each pointer (see [FHIR Resources & References](explore_reference.html#1-profiles)). A 'Bundle' may contain pointers which conform to different versions of the pointer model." %}

    - A `0` (zero) total value indicating no record was matched, i.e. an empty `Bundle`.

      {% include note.html content="The NRL Service will ONLY return an empty bundle if a Spine Clincals record exists and there is no DocumentReference for that specific Clinicals record." %}

- Where a `DocumentReference` is returned, it will include the `versionId` of the current version of the `DocumentReference` resource.

- When a Consumer retrieves a `DocumentReference`, if the `masterIdentifier` is set then it will be included in the returned `DocumentReference`.

- When a Consumer retrieves a `DocumentReference`, if the relatesTo is set then it will be included in the returned `DocumentReference`.

Failure: 

The following errors can be triggered when performing this operation:

- [Invalid NHS number](nrl_error_guidance.html#invalid-nhs-number)
- [Invalid parameter](nrl_error_guidance.html#parameters)
- [No record found](nrl_error_guidance.html#resource-not-found)


### Example Single Pointer Response

- HTTP 200-Request was successfully executed
- Bundle resource of type searchset containing a total value '1' DocumentReference resource that conforms to the `NRL-DocumentReference-1` profile.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_single_pointer.xml %}
{% endhighlight %}
</div>

### Example Multiple Pointers Response

- HTTP 200-Request was successfully executed
- Bundle resource of type searchset containing a total value '2' DocumentReference resources that conform to the `NRL-DocumentReference-1` profile

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_multiple_pointers.xml %}
{% endhighlight %}
</div>

### Example No Pointers Response

- HTTP 200-Request was successfully executed
- Empty bundle resource of type searchset containing a '0' (zero) total value indicating no record was matched

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_empty.xml %}
{% endhighlight %}
</div>


### Example `_summary=count` Response

- Response body will contain XML or JSON formatted Bundle of type searchset, containing a bundle that reports the 
total number of resources that match in Bundle.total, but with no entries, and no prev/next/last links. Note that the Bundle.total 
only include the total number of matching `DocumentReference`s.

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

