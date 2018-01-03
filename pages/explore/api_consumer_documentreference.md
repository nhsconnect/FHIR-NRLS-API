---
title: Consumer API
keywords: getcarerecord, structured, rest, documentreference
tags: [rest,fhir,documents,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_consumer_documentreference.html
summary: A Consumer has a read-only view of the Pointers within NRLS. A Consumer is interested in being able to retrieve Pointers that relate to a given Patient (via their NHS number).
---

<!--
summary: A DocumentReference resource is used to describe a document that is made available to a healthcare system. A document is some sequence of bytes that is identifiable, establishes its own context (e.g., what subject, author, etc. can be displayed to the user), and has defined update management. The DocumentReference resource can be used with any document format that has a recognized mime type and that conforms to this definition.
-->



{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

<!--[SKETCH profile. Not official]-->

<!--
## 1. Read Operation ##

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference/[id]</div>

{% include custom/read.response.html resource="DocumentReference" content="" %}
-->


## 1. Consumer Read ##

Consumer API to support read access of NRLI pointers.

### 1.1 Consumer Read Request Headers ###


<!--
All Provider API read requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->

All Consumer API read requests SHALL include the following HTTP request headers:


| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:read:documentreference`|
| `Ssp-Version`  | `1` |

Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.

<!--
| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:read:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64url encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |

- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.
-->

### 1.2 Consumer Read Operation ###

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference/[id]</div>

<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header. </p>

<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>.</p>
-->


### 1.3 Consumer Read Response ###

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- The NRLS server will return the versionId of each DocumentReference.


Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.

<!--
{% include custom/read.response.html resource="DocumentReference" content="" %}
-->



| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|


- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/ValueSet/spine-error-or-warning-code-1)



## 2. Consumer Search ##

Consumer API to support discovery of NRLI pointers.

### 2.1 Search Request Headers ###

All Consumer API searches SHALL include the following HTTP request headers:


| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:search:documentreference`|
| `Ssp-Version`  | `1` |


Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.

<!--
| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:search:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64url encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |


- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.
-->


### 2.2. Search ###

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference?[searchParameters]</div>

Search for all records for a patient. Fetches a bundle of all `DocumentReference` resources for the specified patient.

Though the NRLS does not keep a version history of each DocumentReference each one does hold a versionId to support the NRLS update strategy. In responding to a search request the NRLS server will populate the versionId of each matching DocumentReference.

### 2.3. Search Parameters ###

{% include custom/search.parameters.html resource="DocumentReference"     link="https://www.hl7.org/fhir/STU3/documentreference.html#search" %}

<table style="min-width:100%;width:100%">
<tr id="clinical">
    <th style="width:15%;">Name</th>
    <th style="width:15%;">Type</th>
    <th style="width:30%;">Description</th>
    <th style="width:5%;">Conformance</th>
    <th style="width:35%;">Path</th>
</tr>
<tr>
    <td><code class="highlighter-rouge">patient</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Who/what is the subject of the document</td>
    <td>SHALL</td>
    <td>DocumentReference.subject<br>(Patient)</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">created</code></td>
    <td><code class="highlighter-rouge">date</code></td>
    <td>Document creation time</td>
    <td>SHOULD</td>
    <td>DocumentReference.created</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">_count</code></td>
    <td><code class="highlighter-rouge">number</code></td>
    <td>Number of results per page</td>
    <td>SHOULD</td>
    <td>N/A</td>
</tr>
<tr>
    <td><code class="highlighter-rouge">_sort</code></td>
    <td><code class="highlighter-rouge">string</code></td>
    <td>Order to sort results in</td>
    <td>SHOULD</td>
    <td>N/A</td>
</tr>
<!--
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
<tr>
    <td><code class="highlighter-rouge">custodian</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Organization which maintains the document</td>
    <td>SHOULD</td>
    <td>DocumentReference.custodian</td>
</tr>
-->
</table>

<!--
Systems SHOULD support the following search combinations:

* TBC
-->

{% include custom/search.patient.html para="2.3.1." content="DocumentReference" %}

{% include custom/search.nopat.date.multiprefix.html para="2.3.2." multi="a maximum of two" name="created" content="DocumentReference" %}

<div markdown="span" class="alert alert-info" role="alert"><i class="fa fa-info-circle"></i> <b>Note:</b> If a DocumentReference Pointer points to a dynamically generated record then the created date will be blank. In this instance Pointers for dynamically generated records will be returned regardless of the created date range search parameters included.</div>
<br>

{% include custom/search.pagination.html para="2.3.3." values="created [TODO] add more parameters" content="DocumentReference" %}

<!--
{% include custom/search.date.plus.html para="1.1.2." content="DocumentReference" name="period" %}
-->
<!--
{% include custom/search.token.html para="1.1.3." content="type" resource="DocumentReference" text1="type" text2="'End of Life Care Coordination Summary'" example="http://snomed.info/sct|861421000000109" %}
-->
<!--{% include custom/search.response.html para="1.2." content="DocumentReference" %}-->

<!--{% include custom/search.response.html resource="DocumentReference" %}-->


### 2.4 Search Response ###

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a `Bundle` of `type` searchset, containing either:
    - One or more `documentReference` resource that conforms to the `nrls-documentReference-1` profile; or
    - One `OperationOutcome` resource if the interaction is a success, however no documentReference record has been found.
- Where an documentReference is returned, it SHALL include the `versionId` and `fullUrl` of the current version of the `documentReference` resource.


Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|400|error|code-invalid|INVALID_CODE_SYSTEM|Invalid code system|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|


- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/ValueSet/spine-error-or-warning-code-1)

<!--- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.-->

### 2.5. Example ###

### 2.5.1 Request Query ###

Return all DocumentReference resources for Patient with a NHS Number of 9876543210, and a record created date greater than or equal to 1st Jan 2010, and a record created date less than or equal to 31st Dec 2011, the format of the response body will be xml. Replace 'baseUrl' with the actual base Url of the FHIR Server.

#### 2.5.2 cURL ####

{% include custom/embedcurl.html title="Search DocumentReference" command="curl -H 'Accept: application/fhir+xml' -H 'Authorization: BEARER [token]' -X GET  '[baseUrl]/DocumentReference?patient.identifier=https://fhir.nhs.uk/Id/nhs-number|9876543210&start=ge2010-01-01&amp;end=le2011-12-31'" %}


#### 2.5.3 Query Response Http Headers ####

<script src="https://gist.github.com/KevinMayfield/74fdaf9414b08038552715fabba8828b.js"></script>

<!--
{% include custom/search.response.headers.html resource="DocumentReference" %}
-->

[TODO Response]
