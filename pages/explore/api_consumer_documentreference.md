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

## 1. Consumer Search ##

Consumer API to support discovery of NRLI pointers.

### 1.1 Search Request Headers ###

All Consumer API searches should include the below additional HTTP request headers to support audit and security requirements on the Spine:

| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:search:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64 encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |

- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.


### 1.2. Search ###

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference?[searchParameters]</div>

Search for all records for a patient. Fetches a bundle of all `DocumentReference` resources for the specified patient.

{% include custom/search.header.html resource="DocumentReference" %}

Though the NRLS does not keep a version history of each DocumentReference each one does hold a versionId to support the NRLS update strategy. In responding to a search request the NRLS server will populate the versionId of each matching DocumentReference.

### 1.2.1. Search Parameters ###

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
    <td>SHOULD</td>
    <td>DocumentReference.subject<br>(Patient)</td>
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

{% include custom/search.patient.html para="2.1.1." content="DocumentReference" %}

<!--
{% include custom/search.date.plus.html para="1.1.2." content="DocumentReference" name="period" %}
-->
<!--
{% include custom/search.token.html para="1.1.3." content="type" resource="DocumentReference" text1="type" text2="'End of Life Care Coordination Summary'" example="http://snomed.info/sct|861421000000109" %}
-->
<!--{% include custom/search.response.html para="1.2." content="DocumentReference" %}-->

<!--{% include custom/search.response.html resource="DocumentReference" %}-->

### 1.3 Search Response ###

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a `Bundle` of `type` searchset, containing either:
    - One or more `documentReference` resource that conforms to the `nrls-documentReference-1` profile; or
    - One `OperationOutcome` resource if the interaction is a success, however no documentReference record has been found.
- Where an documentReference is returned, it SHALL include the `versionId` and `fullUrl` of the current version of the `documentReference` resource.


Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the `spine-operationoutcome-1` profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|404|error|not-found|PATIENT_NOT_FOUND|Patient not found|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|
|400|error|code-invalid|INVALID_CODE_SYSTEM|Invalid code system|
|400|error|code-invalid|INVALID_CODE_VALUE|Invalid code value|
|400|error|code-invalid|INVALID_IDENTIFIER_SYSTEM|Invalid identifier system|
|400|error|value|INVALID_ELEMENT|Invalid element|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|
|400|error|unknown|REQUEST_UNMATCHED|Request does not match authorisation token|
|400|error|structure|MESSAGE_NOT_WELL_FORMED|Message not well formed|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|


- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/ValueSet/spine-error-or-warning-code-1)
- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.


### 1.3. Example ###

### 1.3.1 Request Query ###

Return all DocumentReference resources for Patient with a NHS Number of 9876543210, the format of the response body will be xml. Replace 'baseUrl' with the actual base Url of the FHIR Server.

#### 1.3.2 cURL ####

{% include custom/embedcurl.html title="Search DocumentReference" command="curl -H 'Accept: application/fhir+xml' -H 'Authorization: BEARER [token]' -X GET  '[baseUrl]/DocumentReference?patient.identifier=https://fhir.nhs.uk/Id/nhs-number|9876543210'" %}

{% include custom/search.response.headers.html resource="DocumentReference" %}

[TODO Response]
