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



<!--
## 1. Provider Read ##

Provider API to support read access to NRLS pointers.

### 1.1 Provider Read Request Headers ###
-->

<!--
All Provider API read requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->

<!--All Provider API read requests SHALL include the following HTTP request headers:-->
<!--
Provider API read requests support the following HTTP request headers:



| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |
-->


<!--


| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |  MUST |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. | MUST |
| `Ssp-From`           | Client System ASID | MUST |
| `Ssp-To`             | The Spine ASID | MUST |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:read:documentreference`| MUST |
| `Ssp-Version`  | `1` | MUST |

Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.   

| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:read:documentreference`|
| `Ssp-Version`  | `1` |


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

<!--

### 1.2 Provider Read Operation ###

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference/[id]</div>
-->
<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header. </p>

<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>.</p>
-->

<!--
### 1.3 Provider Read Response ###

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a DocumentReference resource that conforms to the nrls-documentReference-1 profile.
-->
<!--- The NRLS server will return the versionId of each DocumentReference.-->

<!--
Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.
-->
<!--
{% include custom/read.response.html resource="DocumentReference" content="" %}
-->


<!--
| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
-->
<!--
| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|
-->
<!--

- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)
- See the 'General API Guidance' section for full on details NRLS [Error Handling](development_general_api_guidance.html#error-handling)
-->

## 1. Provider Search ##

<!--Provider API to support pointer owner (custodian) searches based on ODS code. -->

<!--Provider API to support parameterised search based on custodian and/or patient associated with a DocumentReference.-->

Provider API to support parameterised search of the NRLS.

### 1.1 Search Request Headers ###

<!--
All Provider API searches should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->

<!--All Provider API searches SHALL include the following HTTP request headers:-->

Provider API search requests support the following HTTP request headers:


| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |


<!--


| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |  MUST |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. | MUST |
| `Ssp-From`           | Client System ASID | MUST |
| `Ssp-To`             | The Spine ASID | MUST |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:search:documentreference`| MUST |
| `Ssp-Version`  | `1` | MUST |



Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.



| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:search:documentreference`|
| `Ssp-Version`  | `1` |




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

### 1.2. Search ###

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference?[searchParameters]</div>

Search for all custodian pointers. Fetches a bundle of all `DocumentReference` resources for the specified pointer owner (custodian).

Providers MUST only search for pointers where they are the pointer owner (custodian).

Though the NRLS does not keep a version history of each DocumentReference each one does hold a versionId. 

<!--Though the NRLS does not keep a version history of each DocumentReference each one does hold a versionId to support the NRLS update strategy. -->

In responding to a search request the NRLS server will populate the versionId of each matching DocumentReference.

### 1.3 Search Parameters ###

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



<!-- Include file removed % include custom/search.pagination.html para="2.3.4." values="" content="DocumentReference" %-->




<!--
{% include custom/search.date.plus.html para="1.1.2." content="DocumentReference" name="period" %}
-->
<!--
{% include custom/search.token.html para="1.1.3." content="type" resource="DocumentReference" text1="type" text2="'End of Life Care Coordination Summary'" example="http://snomed.info/sct|861421000000109" %}
-->
<!--{% include custom/search.response.html para="1.2." content="DocumentReference" %}-->

<!--{% include custom/search.response.html resource="DocumentReference" %}-->

### 1.4 Search Response ###

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a `Bundle` of `type` searchset, containing either:
    - One or more `documentReference` resource that conforms to the `NRLS-DocumentReference-1` profile; or
    - A '0' (zero) total value indicating no record was matched i.e. an empty 'Bundle'.

      {% include note.html content="The returned searchset bundle does NOT currently support: <br/> <br/> (1) the `self link`, which carries the encoded parameters that were actually used to process the search. <br/> <br/> (2) the identity of resources in the entry using the `fullUrl` element. <br/> <br/> (3) resources matched in a successful search using the `search.mode` element. <br/> <br/> NB: The NRLS Service will ONLY return an empty bundle if a Spine Clincals record exists and there is no DocumentReference for that specific Clinicals record." %}

 
<!--- The NRLS server will return the versionId of each DocumentReference.-->
- Where a documentReference is returned, it SHALL include the versionId <!--and fullUrl--> of the current version of the documentReference resource

Failure: 
<!-- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).-->
- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the 'Spine-OperationOutcome-1-0' profile if the search cannot be executed (not that there is no match).

- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|<font color="red">Guidance TBA</font>|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|<font color="red">Guidance TBA</font>|
|404|error|not-found|NO_RECORD_FOUND|No record found|<font color="red">Guidance TBA</font>|

<!--
| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|<font color="blue">Note:</font> See [INVALID_NHS_NUMBER Exception Scenarios](api_provider_documentreference.html#invalid_nhs_number-search-exception-scenarios)|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|<font color="blue">Note:</font> See [INVALID_PARAMETER Exception Scenarios](api_provider_documentreference.html#invalid_parameter-search-exception-scenarios)|
|404|error|not-found|NO_RECORD_FOUND|No record found|<font color="blue">Note:</font> See [NO_RECORD_FOUND Exception Scenarios](api_provider_documentreference.html#no_record_found-exception-scenarios)|
-->

<!--
#### INVALID_PARAMETER Search Exception Scenarios: ####

Example 1: The search request specifies an unsupported parameter value e.g. incorrect URL of the FHIR server that hosts the Patient resource. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|The given resource URL does not conform to the expected format - https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]|

Example 2: The search request specifies an unsupported parameter value i.e. incorrect URL of the FHIR server that hosts the custodian resource. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|The given resource URL does not conform to the expected format - https://directory.spineservices.nhs.uk/STU3/Organization/[ODS Code]|

#### INVALID_NHS_NUMBER Search Exception Scenarios: ####

Example 1: The search request specifies that either (a) a patient URL but the NHS number is missing (b) a search with an omitted logicalId `_id`. The following response is returned to the client

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|One of logical ID and/or NHS number must be supplied.

Example 2: The search request specifies an unsupported parameter value i.e. incorrect URL of the FHIR server that hosts the custodian resource. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|The NHS number format does not apply to the given NHS Number - [nhs number]|



#### NO_RECORD_FOUND Exception Scenarios: ####
-->
<!--
Example 1: The DocumentReference in the request body contains an invalid URL for the referenced Patient resource. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|No record found for supplied DocumentReference identifier – [logicalID].|

Example 2: The DocumentReference in the request body contains an invalid URL of the referenced author or custodian Organization resource. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|The given NHS number could not be found [nhsNumber]|
-->
<!--
Example 1: The client attempts to retrieve a DocumentReference(s) using an NHS Number where no Clinicals record exists in the Spine Clinicals data store for that NHS Number. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|The given NHS number could not be found [nhsNumber]|

Example 2: The client attempts to retrieve a pointer using a URL that does not resolve to a DocumentReference. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|No record found for supplied DocumentReference identifier - [logicalID]|
-->

<!--<font color="red">NB: Need to check OperationOutcome conforming to the http://fhir.nhs.net/StructureDefinition/spine-operationoutcome-1-0 profile + http://fhir.nhs.net/ValueSet/spine-response-code-2-0</font>-->





<!--
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
-->
<!--
| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|400|error|invalid|BAD_REQUEST|Bad request|
|400|error|code-invalid|INVALID_CODE_SYSTEM|Invalid code system|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|
-->
- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)
- See the 'General API Guidance' section for full on details NRLS [Error Handling](development_general_api_guidance.html#error-handling)

<!--- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.-->









## 2. Provider Create ##

Provider API to support creation of NRLS pointers.

### 2.1 Provider Create Request Headers ###

<!--
All Provider API create requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->

<!--All Provider API create requests SHALL include the following HTTP request headers:-->


Provider API create requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |



<!--


| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |  MUST |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. | MUST |
| `Ssp-From`           | Client System ASID | MUST |
| `Ssp-To`             | The Spine ASID | MUST |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:create:documentreference`| MUST |
| `Ssp-Version`  | `1` | MUST |

Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.

| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:create:documentreference`|
| `Ssp-Version`  | `1` |



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

### 2.2. Provider Create Operation ###

Provider system will construct a new Pointer (DocumentReference) and submit this to NRLS using the FHIR RESTful [create](https://www.hl7.org/fhir/http.html#create) interaction.

<div markdown="span" class="alert alert-success" role="alert">
POST [baseUrl]/DocumentReference</div>


Providers systems SHALL only create pointers for records where they are the pointer owner (custodian). 

For all create requests the `custodian` ODS code in the DocumentReference resource SHALL be affiliated with the `Client System ASID` value in the `fromASID` HTTP request header sent to the NRLS.


<p>In addition to the base mandatory data-elements, the following data-elements are also mandatory:</p>

- The `type` data-element MUST be included in the payload request.

<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header. </p>
<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>.</p>
-->

#### 2.2.1 XML Example of a new DocumentReference resource (pointer) ####

<script src="https://gist.github.com/swk003/ddd53998c6021c357cdccd3bce839a7a.js"></script>

### 2.3 Create Response ###

Success:

- SHALL return a `201` **CREATED** HTTP status code on successful execution of the interaction and the entry has been successfully created in the NRLS.
- SHALL return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Operation Outcome'](http://hl7.org/fhir/STU3/operationoutcome.html) core FHIR resource. See table below.
- SHALL return an HTTP `Location` response header containing the full resolvable URL to the newly created 'single' DocumentReference. 
  - The URL will contain the 'server' assigned `logical Id` of the new DocumentReference resource.
  - The URL format MUST be: `https://[host]/[path]?_id=[id]`. 
  - An example `Location` response header: 
    - `https://psis-sync.national.ncrs.nhs.uk/DocumentReference?_id=297c3492-3b78-11e8-b333-6c3be5a609f5`
- When a resource has been created it will have a `versionId` of 1. The `versionId` will not be incremented. <!-- Following an update the `versionId` will be incremented by 1.-->

 

<!--
- SHALL return an HTTP `Location header` containing the full URL to the newly created DocumentReference. This URL will contain the 'server' assigned `logical Id` and `versionId` of the new DocumentReference resource. When a resource has been created it will have an initial `versionId` of 1. Following an update the `versionId` will be incremented by 1.
-->
{% include note.html content="The versionId is an integer that is assigned and maintained by the NRLS server. When a new DocumentReference is created the server assigns it a versionId of 1. As pointer updates are not supported by the NRLS Service the versionId will not be incremented.<br/><br/> The NRLS server will ignore any versionId value sent by a client in a create interaction. Instead the server will ensure that the newly assigned verionId adheres to the rules laid out above. 
" %}


The table summarises the `create` interaction HTTP response code and the values expected to be conveyed in the successful response body `OperationOutcome` payload:


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Details.Text |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|201|information|informational|RESOURCE_CREATED|New resource created | Spine message UUID |Successfully created resource DocumentReference|

{% include note.html content="Upon either successful creation or deletion of a pointer the NRLS Service returns in the reponse payload an OperationOutcome resource with the OperationOutcome.issue.details.text element populated with a Spine internal message UUID. This UUID is used to identify the client's Delete or Create transaction within Spine. A client system SHOULD reference the UUID in any calls raised with the Deployment Issues Resolution Team. The UUID will be used to retrieve log entries that relate to a specific client transaction." %}

<!--
ORIGINAL include note.html FOR ABOVE: 
include note.html content="The versionId is an integer that is assigned and maintained by the NRLS server. When a new DocumentReference is created the server assigns it a versionId of 1. If a Provider subsequently updates that DocumentReference the server will increment the versionId by 1. <br/><br/> The NRLS server will ignore any versionId value sent by a client in an update or create interaction. Instead the server will ensure that the newly assigned verionId adheres to the rules laid out above. The NRLS server will ensure that it maintains the latest versionId of a DocumentReference
-->

Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the 'Spine-OperationOutcome-1-0' profile if the pointer cannot be created.
<!--SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).-->
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|value|INVALID_REQUEST_MESSAGE|Invalid Request Message|Invalid Request Message|
|400|error|invalid|INVALID_RESOURCE|Invalid validation of resource|<font color="red">Guidance TBA</font>|
|400|error|not-found|ORGANISATION_NOT_FOUND|Organisation record not found|The ODS code in the custodian and/or author element is not resolvable – [ods code].|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|The NHS number does not conform to the NHS Number format: [nhs number].|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|<font color="red">Guidance TBA</font>|

<!--

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|value|INVALID_REQUEST_MESSAGE|Invalid Request Message|Invalid Request Message|
|400|error|invalid|INVALID_RESOURCE|Invalid validation of resource|<font color="blue">Note:</font> See [INVALID_RESOURCE Exception Scenarios](api_provider_documentreference.html#invalid_resource-exception-scenarios)|
|400|error|not-found|ORGANISATION_NOT_FOUND|Organisation record not found|The ODS code in the custodian and/or author element is not resolvable – [ods code].|
|400|error|invalid|INVALID_NHS_NUMBER|Invalid NHS number|The NHS number does not conform to the NHS Number format: [nhs number].|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|<font color="blue">Note:</font> See [INVALID_PARAMETER Exception Scenarios](api_provider_documentreference.html#invalid_parameter-exception-scenarios)|


#### INVALID_RESOURCE Exception Scenarios: ####

Example 1: The DocumentReference in the request body is missing one or more mandatory elements. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_RESOURCE|Resource is invalid - [property]|Resource is invalid - [property]|
-->
<!--
NB: If a mandatory node is missing from the POST DocumentReference payload, the Spine NRLS Service SHALL return an OperationOutcome resource with support for the optional OperationOutcome.issue.diagnostics element. This element SHALL NOT contain diagnostic information about the issue, instead it SHALL carry an ‘empty’ string.
-->

<!--
Example 2: The DocumentReference in the request body contains a mandatory element however with an empty value. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_RESOURCE|Invalid validation of resource|Resource is invalid : [property]|
-->
<!--
NB:  If a mandatory node is missing a value in the POST DocumentReference payload, the Spine NRLS Service SHALL return an OperationOutcome resource with support for the optional OperationOutcome.issue.diagnostics element. This element SHALL contain diagnostic information about the issue e.g. "Resource is invalid - status".
-->
<!--
Example 3: The DocumentReference in the request body specifies an ODS code on the custodian that is not tied to the ASID supplied in the HTTP request header `fromASID`. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_RESOURCE|Resource is invalid: [property]|The sender ASID is not affiliated with the Custodian ODS code:[ODS].|


Example 4:  The DocumentReference in the request body specifies an attachment.creation element value that is not a valid dateTime type as per the FHIR specification (https://www.hl7.org/fhir/datatypes.html#dateTime). The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_RESOURCE|Resource is invalid : [property e.g.creation]|The attachment creation date value is not a valid dateTime type: [date].|

Example 5:  The DocumentReference in the request body specifies a `status` code that is not part of the FHIR REQUIRED valueSet [DocumentReferenceStatus](http://hl7.org/fhir/STU3/valueset-document-reference-status.html). The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_RESOURCE|Resource is invalid : [property]|The NRLS DocumentReferenceStatus  valueset does not contain the status: [status]|

Example 6:  The DocumentReference in the request body specifies a `type` code that is not part of the valueset defined in the NRLS DocumentReference FHIR profile. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|<font color="red">structure</font> |INVALID_RESOURCE|Invalid validation of resource|The type value (value) is not a valid value.|
-->
<!--|400|error|invalid|INVALID_RESOURCE|Resource is invalid : [property]|The NRLS types valueset does not contain the type: [type]|-->
<!--
Example 7:  The DocumentReference in the request body specifies an indexed element that is not a valid [instant](http://hl7.org/fhir/STU3/datatypes.html#instant) as per the FHIR specification. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_RESOURCE|Resource is invalid : [property]|The DocumentReference.indexed value is not a valid dateTime type: [instant].|


#### INVALID_PARAMETER Exception Scenarios: ####

Example 1: The DocumentReference in the request body contains an invalid URL for the referenced Patient resource. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|The given resource URL does not conform to the expected format - https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]|

Example 2: The DocumentReference in the request body contains an invalid URL of the referenced author or custodian Organization resource. The following response SHALL be returned to the client.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid|INVALID_PARAMETER|Invalid parameter|The given resource URL does not conform to the expected format - https://directory.spineservices.nhs.uk/STU3/Organization/[ODS Code]|
-->
<!--
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|400|error|invalid|INVALID_RESOURCE|Invalid validation of resource|
|400|error|structure|MESSAGE_NOT_WELL_FORMED|Message not well formed|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
-->

<!--
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
-->

- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)
- See the 'General API Guidance' section for full on details NRLS [Error Handling](development_general_api_guidance.html#error-handling)

<!--- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.-->

<!--
#### 3.3.1 Example Error Response (OperationOutcome): #### 

- HTTP 400-Invalid validation of resource. This is a resource validation error type and if there are problems with one or more of the DocumentReference resource elements this error may be thrown.
- OperationOutcome resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the create interaction DocumentReference resource is not valid. An XML example is below:

<script src="https://gist.github.com/swk003/c147ae7dd8fc0f518984f7bfcb4bebe1.js"></script>
-->



<!--

## 4. Provider Update ##

Provider API to support NRLS pointer updates.

Update cannot be used to create new pointers. See [Payload Business Rules](development_general_api_guidance.html#id) Error Handling section.
-->

<!--
All provider documentReference update requests should contain a version id to avoid lost updates. See [FAQ](support_faq.html).
-->

<!--
### 4.1 Provider Update Request Headers ###
-->
<!--
All Provider API update requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->
<!--All Provider API update requests SHALL include the following HTTP request headers:-->

<!--
Provider API update requests support the following HTTP request headers:


Provider API create requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |
-->




<!--


| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |  MUST |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. | MUST |
| `Ssp-From`           | Client System ASID | MUST |
| `Ssp-To`             | The Spine ASID | MUST |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:update:documentreference`| MUST |
| `Ssp-Version`  | `1` | MUST |


Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.



| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:update:documentreference`|
| `Ssp-Version`  | `1` |



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

<!--
### 4.2. Provider Update Operation ###

<div markdown="span" class="alert alert-success" role="alert">
PUT [baseUrl]/DocumentReference/[id]</div>

<p>The 'update' interaction is performed by an HTTP PUT of the <code class="highlighter-rouge">DocumentReference</code> and creates a new current version of the resource to the NRLS Registry endpoint.</p>
-->

<!--{{include.content}}

<p>The 'update' interaction is performed by an HTTP PUT of the <code class="highlighter-rouge">{{include.content}}</code> and creates a new current version of the resource to the NRLS Registry endpoint.</p>-->

<!--
<p>In addition to the base mandatory data-elements, the following data-elements are also mandatory:</p>

- The `type` data-element MUST be included in the payload request.
-->


<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header and SHALL contain an ‘If-Match’ header. </p>
<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. </p>
-->

<!--
### 4.3 Update Response ###

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction and the entry has been successfully updated on the NRLS. 
-->
<!--- The NRLS server will return an Etag which matches the new versionId.-->
<!--
- SHALL return an `ETag` header which matches the incremented `versionId`. The `ETag` header holds the current version of the Pointer. It will be an integer. The greater the value the more recent the version (see below for further details).
- SHALL return a `Last-Modified` header. The `Last-Modified` header refers to the datetime (in UTC) that the Pointer was last changed in the NRLS. It is a timestamp that carries the instant that the Pointer was changed. The timestamp holds the `year, month, day, hour, minute and number of seconds in UTC` at the instant the Pointer was changed.
-->
<!--- SHALL return an HTTP `Location` header containing the full URL to the updated DocumentReference. This URL will contain the 'server' assigned `logical Id` and incremented `versionId` of the new DocumentReference resource. -->

<!--
{% include note.html content="The versionId is an integer that is assigned and maintained by the NRLS server. When a new DocumentReference is created the server assigns it a versionId of 1. If a Provider subsequently updates that DocumentReference the server will increment the versionId by 1. <br/><br/> The NRLS server will ignore any versionId value sent by a client in an update or create interaction. Instead the server will ensure that the newly assigned verionId adheres to the rules laid out above. The NRLS server will ensure that it maintains the latest versionId of a DocumentReference.
" %}

Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|400|error|invalid|INVALID_RESOURCE|Invalid validation of resource|
|400|error|structure|MESSAGE_NOT_WELL_FORMED|Message not well formed|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|

-->

<!--
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
-->

<!--
- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)
- See the 'General API Guidance' section for full on details NRLS [Error Handling](development_general_api_guidance.html#error-handling)
-->


<!--A 409 HTTP response is expected for versionId conflict when performing an update or delete of a DocumentReference.-->


<!--- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.-->





## 3. Provider Delete ##

Provider API to support deletion of NRLS pointers.
<!--
Deletes are version aware. In order to conduct an update the Provider should submit the request with an If-Match header where the ETag matches the versionId of the DocumentReference in question from the server. If the version id given in the If-Match header does not match the versionId that the server holds for that DocumentReference, the server returns a 409 Conflict status code instead of deleting the resource. In this situation the client should read the DocumentReference from the server to get the most recent versionId and use that to populate the Etag in a fresh delete request.-->

### 3.1 Provider Delete Request Headers ###

<!--
All Provider API delete requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->
<!--All Provider API delete requests SHALL include the following HTTP request headers:-->


Provider API delete requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |





<!--


| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |  MUST |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. | MUST |
| `Ssp-From`           | Client System ASID | MUST |
| `Ssp-To`             | The Spine ASID | MUST |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:delete:documentreference`| MUST |
| `Ssp-Version`  | `1` | MUST |

| `If-Match`      | The ‘If-Match’ header makes the request conditional. The server will process the requested DocumentReference only if it’s versionId property matches one of the listed ETags.|

Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.

| Header               | Value |
|----------------------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:delete:documentreference`|
| `Ssp-Version`  | `1` |

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

### 3.2 Provider Delete Operation ###

The Provider API supports the conditional delete interaction which allows a provider to delete an existing pointer based on the search parameter `_id` which refers to the logical id of the pointer. To accomplish this, the provider issues an HTTP DELETE as shown:

<div markdown="span" class="alert alert-success" role="alert">
DELETE [baseUrl]/DocumentReference?_id=[id]</div>

<!--DELETE [baseUrl]/DocumentReference/[id]</div>-->



Providers systems SHALL only delete pointers for records where they are the pointer owner (custodian). 

For all delete requests the `custodian` ODS code in the DocumentReference to be deleted SHALL be affiliated with the Client System `ASID` value in the `fromASID` HTTP request header sent to the NRLS.

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">DELETE [baseUrl]/DocumentReference?_id=da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Delete the DocumentReference resource for a pointer with a logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'.</pre>
</div>


### 3.3 Delete Response ###

<p>The 'delete' interaction removes an existing resource. The interaction is performed by an HTTP DELETE of the <code class="highlighter-rouge">DocumentReference</code> resource.</p>

<!--<p>Return a single <code class="highlighter-rouge">{{include.resource}}</code> for the specified id{{include.content}}.</p>-->

<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header and SHALL contain an ‘If-Match’ header. </p>
<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. </p>

<p>The ‘If-Match’ header makes the request conditional. The server will process the requested DocumentReference only if it’s versionId property matches one of the listed ETags.</p>
-->

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) FHIR profile. 

The table summarises the successful `delete` interaction scenario and includes HTTP response code and the values expected to be conveyed in the response body `OperationOutcome` payload:


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Details.Text |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|200|information|informational|RESOURCE_DELETED|Resource removed | Spine message UUID |Successfully removed resource DocumentReference: [url]|

{% include note.html content="Upon either successful creation or deletion of a pointer the NRLS Service returns in the reponse payload an OperationOutcome resource with the OperationOutcome.issue.details.text element populated with a Spine internal message UUID. This UUID is used to identify the client's Delete or Create transaction within Spine. A client system SHOULD reference the UUID in any calls raised with the Deployment Issues Resolution Team. The UUID will be used to retrieve log entries that relate to a specific client transaction." %}


Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the 'Spine-OperationOutcome-1-0' profile if the pointer cannot be created.
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|No record found for supplied DocumentReference identifier - [id]|
|400|error|invalid|INVALID_RESOURCE|Resource is invalid - [custodian]|The custodian ODS code is not affiliated with the sender ASID.|




<!--
Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match).
- The below table summarises the types of error that could occur, and the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body.




| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|404|error|not-found|NO_RECORD_FOUND|No record found|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
-->
<!--
| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|
|403|error|forbidden|ACCESS_DENIED|Access has been denied to process this request|
|403|error|forbidden|ACCESS_DENIED_SSL|SSL Protocol or Cipher requirements not met|
|403|error|forbidden|ASID_CHECK_FAILED|The sender or receiver's ASID is not authorised for this interaction|
|404|error|not-found|NO_RECORD_FOUND|No record found|

-->

- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)
- See the 'General API Guidance' section for full on details NRLS [Error Handling](development_general_api_guidance.html#error-handling)

<!--A 409 HTTP response is expected for versionId conflict when performing an update or delete of a DocumentReference.-->


<!--- Error REQUEST_UNMATCHED would occur if the NHS number being requested in the search request does not match the requested_record value in the JWT - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.-->