---
title: API Search Interaction
keywords: structured, rest, documentreference
tags: [rest,fhir,documents,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_search.html
summary: To support parameterised search of the NRLS.
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Provider Search ##

Provider API to support parameterised search of the NRLS.

## Search Request Headers ##


Provider API search requests support the following HTTP request headers:


| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |




## Search ##

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference?[searchParameters]</div>

Search for all custodian pointers. Fetches a bundle of all `DocumentReference` resources for the specified pointer owner (custodian).

Providers MUST only search for pointers where they are the pointer owner (custodian).

Though the NRLS does not keep a version history of each DocumentReference each one does hold a versionId. 

<!--Though the NRLS does not keep a version history of each DocumentReference each one does hold a versionId to support the NRLS update strategy. -->

In responding to a search request the NRLS server will populate the versionId of each matching DocumentReference.

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

<!--
<tr>
    <td><code class="highlighter-rouge">_count</code></td>
    <td><code class="highlighter-rouge">number</code></td>
    <td>Number of results per page</td>
    <td>MAY</td>
    <td>N/A</td>
</tr>
-->
</table>

{% include custom/search.warn.subject.custodian.html %}

<!--
Systems SHOULD support the following search combinations:

* TBC
-->

<!-- Include file removed: % include custom/search.custodian.html para="2.3.1." content="DocumentReference" %-->

{% include custom/search._id.html para="1.3.1." values="" content="DocumentReference" %}

{% include custom/search.patient.html para="1.3.2." content="DocumentReference" %}

{% include custom/search.patient.custodian.html para="1.3.3." values="" content="DocumentReference" %}

{% include custom/search.patient.type.html para="1.3.4." values="" content="DocumentReference" %}


## Search Response ##

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a `Bundle` of `type` searchset, containing either:
    - One or more `documentReference` resource that conforms to the `NRLS-DocumentReference-1` profile; or
    - A '0' (zero) total value indicating no record was matched i.e. an empty 'Bundle'.

      {% include note.html content="The returned searchset bundle does NOT currently support: <br/> <br/> (1) the `self link`, which carries the encoded parameters that were actually used to process the search. <br/> <br/> (2) the identity of resources in the entry using the `fullUrl` element. <br/> <br/> (3) resources matched in a successful search using the `search.mode` element. <br/> <br/> NB: The NRLS Service will ONLY return an empty bundle if a Spine Clincals record exists and there is no DocumentReference for that specific Clinicals record." %}

 
- Where a documentReference is returned, it SHALL include the versionId <!--and fullUrl--> of the current version of the documentReference resource

Failure: 
- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the 'Spine-OperationOutcome-1-0' profile if the search cannot be executed (not that there is no match).

- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|<font color="red">Guidance TBA</font>|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|<font color="red">Guidance TBA</font>|
|404|error|not-found|NO_RECORD_FOUND|No record found|<font color="red">Guidance TBA</font>|


- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)
- See the 'General API Guidance' section for full on details NRLS [Error Handling](development_general_api_guidance.html#error-handling)
