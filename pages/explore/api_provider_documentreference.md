---
title: Provider API
keywords: getcarerecord, structured, rest, documentreference
tags: [rest,fhir,documents,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_provider_documentreference.html
summary: A Provider has a read-write view of Pointers within the NRLS. A Provider can only view and modify the Pointers that they own.
---

<!--
summary: A DocumentReference resource is used to describe a document that is made available to a healthcare system. A document is some sequence of bytes that is identifiable, establishes its own context (e.g., what subject, author, etc. can be displayed to the user), and has defined update management. The DocumentReference resource can be used with any document format that has a recognized mime type and that conforms to this definition.
-->


{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

<!--[SKETCH profile. Not official]-->




## 1. Provider Read ##

Provider API to support read access to NRLI pointers.

### 1.1 Provider Read Request Headers ###


<!--
All Provider API read requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->

All Provider API read requests SHALL include the following HTTP request headers:


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

### 1.2 Provider Read Operation ###

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference/[id]</div>

<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header. </p>

<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>.</p>
-->


### 1.3 Provider Read Response ###

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


## 2. Provider Search ##

Provider API to support pointer owner (custodian) searches based on ODS code.

### 2.1 Search Request Headers ###

<!--
All Provider API searches should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->

All Provider API searches SHALL include the following HTTP request headers:


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

Search for all custodian pointers. Fetches a bundle of all `DocumentReference` resources for the specified pointer owner (custodian).

Providers MUST only search for pointers where they are the pointer owner (custodian).

Though the NRLS does not keep a version history of each DocumentReference each one does hold a versionId to support the NRLS update strategy. In responding to a search request the NRLS server will populate the versionId of each matching DocumentReference.

### 2.3 Search Parameters ###

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
    <td><code class="highlighter-rouge">custodian</code></td>
    <td><code class="highlighter-rouge">reference</code></td>
    <td>Organization which maintains the document reference</td>
    <td>SHOULD</td>
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
    <td><code class="highlighter-rouge">_count</code></td>
    <td><code class="highlighter-rouge">number</code></td>
    <td>Number of results per page</td>
    <td>SHOULD</td>
    <td>N/A</td>
</tr>
</table>

{% include custom/search.warn.subject.custodian.html %}

<!--
Systems SHOULD support the following search combinations:

* TBC
-->
{% include custom/search.custodian.html para="2.3.1." content="DocumentReference" %}

{% include custom/search.patient.html para="2.3.2." content="DocumentReference" %}

{% include custom/search.pagination.html para="2.3.3." values="" content="DocumentReference" %}


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
- The NRLS server will return the versionId of each DocumentReference.


Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|400|error|invalid|BAD_REQUEST|Bad request|
|400|error|code-invalid|INVALID_CODE_SYSTEM|Invalid code system|
|400|error|invalid|INVALID_CODE_VALUE|Invalid code system|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|


- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/ValueSet/spine-error-or-warning-code-1)

<!--- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.-->









## 3. Provider Create ##

Provider API to support creation of NRLI pointers.

### 3.1 Provider Create Request Headers ###

<!--
All Provider API create requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->

All Provider API create requests SHALL include the following HTTP request headers:


| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:create:documentreference`|
| `Ssp-Version`  | `1` |

Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.

<!--

| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:create:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64url encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |

- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.
-->

### 3.2. Provider Create Operation ###

<div markdown="span" class="alert alert-success" role="alert">
POST [baseUrl]/DocumentReference</div>

<p>In addition to the base mandatory data-elements, the following data-elements are also mandatory:</p>

- The `type` data-element MUST be included in the payload request.

<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header. </p>
<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>.</p>
-->


### 3.3 Create Response ###

Success:

- SHALL return a `201` **OK** HTTP status code on successful execution of the interaction and the entry has been successfully created and the NRLS.
- The NRLS server will return an HTTP Location header containing the 'server' assigned logical Id <!--and versionId-->of the created DocumentReference resource.

Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|400|error|invalid|INVALID_RESOURCE|Invalid validation of resource|
|400|error|invalid|INVALID_CODE_SYSTEM|Invalid code system|
|400|error|invalid|INVALID_CODE_VALUE|Invalid code value|
|400|error|structure|MESSAGE_NOT_WELL_FORMED|Message not well formed|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|


- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/ValueSet/spine-error-or-warning-code-1)

<!--- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.-->


## 4. Provider Update ##

Provider API to support NRLI pointer updates.
<!--
All provider documentReference update requests should contain a version id to avoid lost updates. See [FAQ](support_faq.html).

Updates are version aware. In order to conduct an update the Provider should submit the request with an If-Match header where the ETag matches the versionId of the DocumentReference in question from the server. If the version id given in the If-Match header does not match the versionId that the server holds for that DocumentReference, the server returns a 409 Conflict status code instead of updating the resource. In this situation the client should read the DocumentReference from the server to get the most recent versionId and use that to populate the Etag in a fresh update request.-->

### 4.1 Provider Update Request Headers ###

<!--
All Provider API update requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->
All Provider API update requests SHALL include the following HTTP request headers:


| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:update:documentreference`|
| `Ssp-Version`  | `1` |

<!--| `If-Match`      | The ‘If-Match’ header makes the request conditional. The server will process the requested DocumentReference only if it’s versionId property matches one of the listed ETags.|-->

Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.


<!--

| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:update:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64url encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |

- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.
-->

### 4.2. Provider Update Operation ###

<div markdown="span" class="alert alert-success" role="alert">
PUT [baseUrl]/DocumentReference/[id]</div>

<p>The 'update' interaction is performed by an HTTP PUT of the <code class="highlighter-rouge">{{include.resource}}</code> and creates a new current version of the resource to the NRLS Registry endpoint.</p>

<p>In addition to the base mandatory data-elements, the following data-elements are also mandatory:</p>

- The `type` data-element MUST be included in the payload request.

<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header and SHALL contain an ‘If-Match’ header. </p>
<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. </p>

<p>The ‘If-Match’ header makes the request conditional. The server will process the requested DocumentReference only if it’s versionId property matches one of the listed ETags.</p>
-->

### 4.3 Update Response ###

Success:

- SHALL return a `204` **OK** HTTP status code on successful execution of the interaction and the entry has been successfully created and the NRLS.
<!--- The NRLS server will return an Etag which matches the new versionId.-->

Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|400|error|invalid|INVALID_RESOURCE|Invalid validation of resource|
|400|error|invalid|INVALID_CODE_SYSTEM|Invalid code system|
|400|error|invalid|INVALID_CODE_VALUE|Invalid code value|
|400|error|structure|MESSAGE_NOT_WELL_FORMED|Message not well formed|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|
|404|error|not-found|NO_RECORD_FOUND|No record found|



- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/ValueSet/spine-error-or-warning-code-1)

<!--A 409 HTTP response is expected for versionId conflict when performing an update or delete of a DocumentReference.-->


<!--- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.-->





## 5. Provider Delete ##

Provider API to support deletion of NRLI pointers.
<!--
Deletes are version aware. In order to conduct an update the Provider should submit the request with an If-Match header where the ETag matches the versionId of the DocumentReference in question from the server. If the version id given in the If-Match header does not match the versionId that the server holds for that DocumentReference, the server returns a 409 Conflict status code instead of deleting the resource. In this situation the client should read the DocumentReference from the server to get the most recent versionId and use that to populate the Etag in a fresh delete request.-->

### 5.1 Provider Delete Request Headers ###

<!--
All Provider API delete requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->
All Provider API delete requests SHALL include the following HTTP request headers:


| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:delete:documentreference`|
| `Ssp-Version`  | `1` |

<!--| `If-Match`      | The ‘If-Match’ header makes the request conditional. The server will process the requested DocumentReference only if it’s versionId property matches one of the listed ETags.|-->

Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.


<!--

| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:delete:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64url encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |

- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.
-->

### 5.2 Provider Delete Operation ###

<div markdown="span" class="alert alert-success" role="alert">
DELETE [baseUrl]/DocumentReference/[id]</div>



### 5.3 Delete Response ###

<p>The 'delete' interaction removes an existing resource. The interaction is performed by an HTTP DELETE of the <code class="highlighter-rouge">{{include.resource}}</code> resource.</p>

<!--<p>Return a single <code class="highlighter-rouge">{{include.resource}}</code> for the specified id{{include.content}}.</p>-->

<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header and SHALL contain an ‘If-Match’ header. </p>
<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. </p>

<p>The ‘If-Match’ header makes the request conditional. The server will process the requested DocumentReference only if it’s versionId property matches one of the listed ETags.</p>
-->

Success:

- SHALL return a `204` **OK** HTTP status code on successful execution of the interaction.

Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|
|404|error|not-found|NO_RECORD_FOUND|No record found|


- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/ValueSet/spine-error-or-warning-code-1)

<!--A 409 HTTP response is expected for versionId conflict when performing an update or delete of a DocumentReference.-->


<!--- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.-->