---
title: API Search Interaction
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_search.html
summary: To support parameterised search of the NRL.
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Search ##

API to support parameterised search of the NRL. This functionality is available for both consumer and provider systems.

## Search Request Headers ##


Provider API search requests support the following HTTP request headers:


| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |


## Search DocumentReference ##

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference?[searchParameters]</div>

Though the NRL does not keep a version history of each DocumentReference each one does hold a versionId. 

<!--Though the NRL does not keep a version history of each DocumentReference each one does hold a versionId to support the NRL update strategy. -->

In responding to a search request the NRL server will populate the versionId of each matching DocumentReference.

## Search Parameters ##

{% include custom/search.parameters.html resource="DocumentReference"     link="https://www.hl7.org/fhir/STU3/documentreference.html#search" %}

<table style="min-width:100%;width:100%">
<tr id="clinical">
    <th style="width:15%;">Name</th>
    <th style="width:15%;">Type</th>
    <th style="width:30%;">Description</th>
    <th style="width:5%;">Conformance</th>
    <th style="width:35%;">Path</th>
</tr>
<!--
<tr>
    <td><code class="highlighter-rouge">patient</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Who/what is the subject of the document</td>
    <td>SHOULD</td>
    <td>DocumentReference.subject<br>(Patient)</td>
</tr>

<tr>
    <td><code class="highlighter-rouge">period</code></td>
    <td><code class="highlighter-rouge">date</code></td>
    <td>Time of service that is being documented</td>
    <td>SHOULD</td>
    <td>DocumentReference.context.period</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">type</code></td>
    <td><code class="highlighter-rouge">token</code></td>
    <td>Kind of document (SNOMED CT if possible)</td>
    <td>SHOULD</td>
    <td>DocumentReference.type</td>
</tr> 
-->
<tr>
    <td><code class="highlighter-rouge">_id</code></td>
    <td><code class="highlighter-rouge">token</code></td>
    <td>The logical id of the resource</td>
    <td>SHOULD</td>
    <td>DocumentReference.id</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">custodian</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Organization which maintains the document reference</td>
    <td>MAY</td>
    <td>DocumentReference.custodian(Organization)</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">subject</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Who/what is the subject of the document</td>
    <td>SHOULD</td>
    <td>DocumentReference.subject<br>(Patient)</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">type</code></td>
    <td><code class="highlighter-rouge">token</code></td>
    <td>Kind of document (SNOMED CT)</td>
    <td>MAY</td>
    <td>DocumentReference.type</td>
</tr> 
<tr>
    <td><code class="highlighter-rouge">_summary</code></td>
    <td><code class="highlighter-rouge">Summary</code></td>
    <td>Total number of matching results</td>
    <td>MAY</td>
    <td>N/A</td>
</tr>
</table>

{% include custom/search.warn.subject.custodian.html %}
{% include note.html content="Please make sure that all query parameters are URL encoded. In particular the pipe (|) character must be URL encoded (%7C)." %}


{% include custom/search._id.html values="" content="DocumentReference" %}

{% include custom/search.patient.html content="DocumentReference" %}

{% include custom/search.patient.custodian.html values="" content="DocumentReference" %}

{% include custom/search.patient.type.html values="" content="DocumentReference" %}

{% include custom/search._summary.html values="" content="DocumentReference" %}


## Search Response ##

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a `Bundle` of `type` searchset, containing either:
    - One or more `documentReference` resource that conforms to the `NRLS-DocumentReference-1` profile and has the status value "current"; or
    - A '0' (zero) total value indicating no record was matched i.e. an empty 'Bundle'.

      {% include note.html content="The returned searchset bundle does NOT currently support: <br/> <br/> (1) the `self link`, which carries the encoded parameters that were actually used to process the search. <br/> <br/> (2) the identity of resources in the entry using the `fullUrl` element. <br/> <br/> (3) resources matched in a successful search using the `search.mode` element. <br/> <br/> NB: The NRL Service will ONLY return an empty bundle if a Spine Clincals record exists and there is no DocumentReference for that specific Clinicals record." %}

 
- Where a documentReference is returned, it SHALL include the versionId <!--and fullUrl--> of the current version of the documentReference resource

- When a Consumer retrieves a DocumentReference if the masterIdentifier is set then it should be included in the returned DocumentReference

- When a Consumer retrieves a DocumentReference if the relatesTo is set then it should be included in the returned DocumentReference

Failure: 

The following errors can be triggered when performing this operation:

- [Invalid NHS number](development_general_api_guidance.html#invalid-nhs-number)
- [Invalid parameter](development_general_api_guidance.html#parameters)
- [No record found](development_general_api_guidance.html#resource-not-found)


## Example Scenario ##

An authorised NRL Consumer searches for a patient's relevant health record using the NRL to discover potentially vital information to support a patient's emergency crisis care.

### Request Query ###

Return all DocumentReference resources (pointers) for a patient with a NHS Number of 9876543210. The format of the response body will be XML. 

<!--Return all DocumentReference resources for a patient with a NHS Number of 9876543210 and a pointer provider ODS code of RR8. The format of the response body will be xml. -->


<!--Return all DocumentReference resources for Patient with a NHS Number of 9876543210, and a record created date greater than or equal to 1st Jan 2010, and a record created date less than or equal to 31st Dec 2011, the format of the response body will be xml. Replace 'baseUrl' with the actual base Url of the FHIR Server.-->


#### cURL ####

{% include custom/embedcurl.html title="Search DocumentReference" command="curl -H 'Accept: application/fhir+xml' -H 'Authorization: BEARER [token]' -X GET  '[baseUrl]/DocumentReference?subject=https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210&_format=xml'" %}

#### Query Response Http Headers ####

```
{% include /examples/search_response_headers %}
```

#### Query Response ####

##### **Single Pointer (DocumentReference) Returned:** ##### 

- HTTP 200-Request was successfully executed
- Bundle resource of type searchset containing a total value '1' DocumentReference resource that conforms to the `nrls-documentReference-1` profile.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_single_pointer.xml %}
{% endhighlight %}
</div>

##### **Multiple Pointers (DocumentReference) Returned:** ##### 

- HTTP 200-Request was successfully executed
- Bundle resource of type searchset containing a total value '2' DocumentReference resources that conform to the `nrls-documentReference-1` profile

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_multiple_pointers.xml %}
{% endhighlight %}
</div>

##### **No Record (pointer) Matched:** ##### 

- HTTP 200-Request was successfully executed
- Empty bundle resource of type searchset containing a '0' (zero) total value indicating no record was matched

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_empty.xml %}
{% endhighlight %}
</div>

##### **Error Response (OperationOutcome) Returned:** ##### 

- HTTP 400-Bad Request. Invalid Parameter. 
- OperationOutcome resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match)

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_error.xml %}
{% endhighlight %}
</div>

See Consumer Search section for all [HTTP Error response codes](api_consumer_documentreference.html#24-search-response) supported by Consumer Search API.

##### **_summary=count response:** ##### 

- Response body SHALL return a valid XML or JSON formatted Bundle of type searchset, containing a bundle that reports the 
total number of resources that match in Bundle.total, but with no entries, and no prev/next/last links. Note that the Bundle.total 
only include the total number of matching DocumentReferences.

Examples
- 3 DocumentReferences exist for patient with NHS number passed into the search
<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_summary_count3.xml %}
{% endhighlight %}
</div>

- 0 DocumentReferences exist for patient with NHS number passed into the search
<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/search_response_summary_count0.xml %}
{% endhighlight %}
</div>

## Code Examples ##

### GET Pointers with C# ###

The following code samples are taken from the NRL Demonstrator application which has both Consumer and Provider client implementations built in. More information about the design solution can be found
on the [NRL Demonstrator Wiki](https://github.com/nhsconnect/nrls-reference-implementation/wiki)

First we generate a base pointer request model that includes the patients NHS Number used for the subject parameter. 
The NHS Number is obtained through a stub PDS Trace performed within the Demonstrator Consumer system.

Then we call our DocumentReference service GetPointersBundle method which will build a GET command request and then start the call to the NRL API.

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/nrls-reference-implementation/blob/d6e952bd1ee53988bb8005b3a27f3fe16355b3ab/Demonstrator/Demonstrator.Services/Service/Nrls/PointerService.cs#L34-L36 %}
{% highlight csharp %}
{% github_sample /nhsconnect/nrls-reference-implementation/blob/d6e952bd1ee53988bb8005b3a27f3fe16355b3ab/Demonstrator/Demonstrator.Services/Service/Nrls/PointerService.cs 33 35 %}
{% endhighlight %}
</div>

Once we have received pointers from the NRL when then look up the custodian (and author) organisation details using the ODS Code's held within each pointer via a stub ODS lookup. We can then present actual organisation details to the end users.

<b>Calling the NRL</b><br />
Using our GET command request model we create a connection to the NRL using HttpClient.

You can view the common connection code example [here](connectioncode_example.html).

<b>Explore the NRL</b><br />
You can explore and test the NRL GET command using Swagger in our [Reference implementation](https://data.developer.nhs.uk/nrls-ri/index.html#/Nrls/searchPointers).

{% include note.html content="The code in these examples is standard C# v7.2 taken direct from the [NRL Demonstrator](https://nrls.digital.nhs.uk) code.<br /><br />The official <b>[.NET FHIR Library](https://ewoutkramer.github.io/fhir-net-api/)</b> is utilised to construct, test, parse and serialize FHIR models with ease." %}
