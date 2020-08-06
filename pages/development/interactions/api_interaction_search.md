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

Consumer interaction to support parameterised search of the NRL. 

## Prerequisites

In addition to the requirements on this page the general guidance and requirements detailed on the [Development Overview](development_overview.html) page MUST be followed when using this interaction.

## Search Request Headers

Consumer and Provider API search requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. | OPTIONAL |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the JWT section of the [Development Overview](development_overview.html) page for details. | REQUIRED |
| `fromASID`           | Client System ASID | REQUIRED |
| `toASID`             | The Spine ASID | REQUIRED |

## Search DocumentReference

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/DocumentReference?[searchParameters]`
</div>


## Search Parameters

{% include custom/search.parameters.html resource="DocumentReference" link="https://www.hl7.org/fhir/STU3/documentreference.html#search" %}

<table style="min-width:100%;width:100%">
<tr id="clinical">
    <th style="width:15%;">Name</th>
    <th style="width:15%;">Type</th>
    <th style="width:30%;">Description</th>
    <th style="width:5%;">Conformance</th>
    <th style="width:35%;">Path</th>
</tr>
<tr>
    <td><code class="highlighter-rouge">_id</code></td>
    <td><code class="highlighter-rouge">token</code></td>
    <td>The logical id of the resource</td>
    <td>RECOMMENDED</td>
    <td>DocumentReference.id</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">custodian</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Organisation which maintains the document reference</td>
    <td>OPTIONAL</td>
    <td>DocumentReference.custodian<br>(Organisation ODS Code)</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">subject</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Who/what is the subject of the document</td>
    <td>RECOMMENDED</td>
    <td>DocumentReference.subject<br>(Patient NHS Number)</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">type</code></td>
    <td><code class="highlighter-rouge">token</code></td>
    <td>Kind of document (SNOMED CT)</td>
    <td>OPTIONAL</td>
    <td>DocumentReference.type</td>
</tr> 
<tr>
    <td><code class="highlighter-rouge">_summary</code></td>
    <td><code class="highlighter-rouge">Summary</code></td>
    <td>Total number of matching results</td>
    <td>OPTIONAL</td>
    <td>N/A</td>
</tr>
</table>

{% include custom/search.warn.subject.custodian.html %}
{% include note.html content="Please make sure that all query parameters are percent encoded. In particular the pipe (|) character must be percent encoded (%7C)." %}

{% include custom/search._id.html values="" content="DocumentReference" %}

{% include custom/search.patient.html content="DocumentReference" %}

{% include custom/search.patient.custodian.html values="" content="DocumentReference" %}

{% include custom/search.patient.type.html values="" content="DocumentReference" %}

{% include custom/search._summary.html values="" content="DocumentReference" %}

## Search Response

Success:

- will return a `200` **OK** HTTP status code on successful execution of the interaction.
- will return a `Bundle` of `type` searchset, containing either:
    - One or more `DocumentReference` resources that conform to the NRL DocumentReference FHIR profile and that have the status value of "current". 
    
      {% include note.html content="The version of the pointer model (FHIR profile) will be indicated in the `DocumentReference.meta.profile` metadata attribute for each pointer (see [FHIR Resources & References](explore_reference.html#1-profiles)). A 'Bundle' may contain pointers which conform to different versions of the pointer model." %}

    - A `0` (zero) total value indicating no record was matched, i.e. an empty `Bundle`.

      {% include note.html content="The NRL Service will ONLY return an empty bundle if a Spine Clincals record exists and there is no DocumentReference for that specific Clinicals record." %}

    <!--{% include note.html content="The returned searchset bundle does NOT currently support: <br/> <br/> (1) the `self link`, which carries the encoded parameters that were actually used to process the search. <br/> <br/> (2) the identity of resources in the entry using the `fullUrl` element. <br/> <br/> (3) resources matched in a successful search using the `search.mode` element. <br/> <br/> NB: The NRL Service will ONLY return an empty bundle if a Spine Clincals record exists and there is no DocumentReference for that specific Clinicals record." %}-->

- Where a DocumentReference is returned, it will include the versionId of the current version of the DocumentReference resource.

- When a Consumer retrieves a DocumentReference if the masterIdentifier is set then it will be included in the returned DocumentReference.

- When a Consumer retrieves a DocumentReference if the relatesTo is set then it will be included in the returned DocumentReference.

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

You can explore and test the NRL GET command using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html#/Nrls/searchPointers).

