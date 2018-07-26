---
title: Consumer API
keywords: getcarerecord, structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
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

<!--
## 1. Consumer Read ##

Consumer API to support read access of NRLS pointers.

### 1.1 Consumer Read Request Headers ###
-->

<!--
All Provider API read requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:
-->
<!--
All Consumer API read requests SHALL include the following HTTP request headers:
-->
<!--
Consumer API read requests support the following HTTP request headers:


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
### 1.2 Consumer Read Operation ###

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference/[id]</div>
-->
<!--
<p>All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header. </p>

<p>The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>.</p>
-->

<!--
### 1.3 Consumer Read Response ###

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


## 1. Consumer Search ##

Consumer API to support parameterised search based on a patient associated with a DocumentReference.

<!--Consumer API to support parameterised search based on a patient and/or custodian associated with a DocumentReference.-->

<!--Consumer API to support discovery of NRLS pointers.-->

### 1.1 Search Request Headers ###

<!--All Consumer API searches SHALL include the following HTTP request headers:-->

Consumer API search requests support the following HTTP request headers:



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

Search for all records for a patient. Fetches a bundle of all `DocumentReference` resources for the specified patient.

Though the NRLS does not keep a version history of each DocumentReference each one does hold a versionId. 

<!--Though the NRLS does not keep a version history of each DocumentReference each one does hold a versionId to support the NRLS update strategy. -->

### 1.3. Search Parameters ###

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
    <td><code class="highlighter-rouge">created</code></td>
    <td><code class="highlighter-rouge">date</code></td>
    <td>Document creation time</td>
    <td>SHOULD</td>
    <td>DocumentReference.created</td>
</tr>
-->
<!--
<tr>
    <td><code class="highlighter-rouge">_count</code></td>
    <td><code class="highlighter-rouge">number</code></td>
    <td>Number of results per page</td>
    <td>MAY</td>
    <td>N/A</td>
</tr>
-->
<!--
<tr>
    <td><code class="highlighter-rouge">_sort</code></td>
    <td><code class="highlighter-rouge">string</code></td>
    <td>Order to sort results in</td>
    <td>SHOULD</td>
    <td>N/A</td>
</tr>
-->
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

{% include custom/search.warn.subject.custodian.html %}
<!--
<p>When performing a consumer search the <code class="highlighter-rouge">patient</code> parameter SHALL be supported and the <code class="highlighter-rouge">custodian</code> parameter MAY be supported in the search query. </p> -->   

<!--When performing a consumer search the `patient` parameter SHALL be supported and the `custodian` parameter MAY be supported in the search query.-->


<!--Systems SHOULD support the following search combinations:* TBC-->

<!--Removed include link to custom/search.warn.subject.custodian.html-->


{% include custom/search._id.html para="1.3.1." values="" content="DocumentReference" %}



{% include custom/search.patient.html para="1.3.2." content="DocumentReference" %}

{% include custom/search.patient.custodian.html para="1.3.3." values="" content="DocumentReference" %}

{% include custom/search.patient.type.html para="1.3.4." values="" content="DocumentReference" %}



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

<!--

Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a `Bundle` of `type` searchset, containing either:
    - [One](api_consumer_documentreference.html#2541-single-pointer-documentreference-returned) or [more](api_consumer_documentreference.html#2542-multiple-pointers-documentreference-returned) `documentReference` resources that conform to the `nrls-documentReference-1` profile; or
    - A '0' (zero) total value indicating no record was matched i.e. an [empty](api_consumer_documentreference.html#2543-no-record-pointer-matched) 'Bundle'.
- Where a documentReference is returned, it SHALL include the `versionId` and `fullUrl` of the current version of the `documentReference` resource.


Failure: 

- SHALL return one of the below HTTP status error codes with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match) - see example [OperationOutcome](api_consumer_documentreference.html#2544-error-response-operationoutcome-returned) error response.
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

### 1.5. Example Scenario ###

An authorised NRLS Consumer searches for a patient's relevant health record using the NRLS to discover potentially vital information to support a patient's emergency crisis care.

#### 1.5.1 Request Query ####

Return all DocumentReference resources (pointers) for a patient with a NHS Number of 9876543210. The format of the response body will be XML. 

<!--Return all DocumentReference resources for a patient with a NHS Number of 9876543210 and a pointer provider ODS code of RR8. The format of the response body will be xml. -->


<!--Return all DocumentReference resources for Patient with a NHS Number of 9876543210, and a record created date greater than or equal to 1st Jan 2010, and a record created date less than or equal to 31st Dec 2011, the format of the response body will be xml. Replace 'baseUrl' with the actual base Url of the FHIR Server.-->


#### 1.5.2 cURL ####

{% include custom/embedcurl.html title="Search DocumentReference" command="curl -H 'Accept: application/fhir+xml' -H 'Authorization: BEARER [token]' -X GET  '[baseUrl]/DocumentReference?subject=https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210&_format=xml'" %}

#### 1.5.3 Query Response Http Headers ####

<script src="https://gist.github.com/swk003/1fb79ea938f6f5f984069819a29c2356.js"></script>



#### 1.5.4 Query Response ####

##### 1.5.4.1 Single Pointer (DocumentReference) Returned: ##### 

- HTTP 200-Request was successfully executed
- Bundle resource of type searchset containing a total value '1' DocumentReference resource that conforms to the `nrls-documentReference-1` profile.



<script src="https://gist.github.com/swk003/ce94f58f6af930a419da4c9e9d29b620.js"></script>

##### 1.5.4.2 Multiple Pointers (DocumentReference) Returned: ##### 

- HTTP 200-Request was successfully executed
- Bundle resource of type searchset containing a total value '2' DocumentReference resources that conform to the `nrls-documentReference-1` profile


<script src="https://gist.github.com/swk003/3ab926e15f1dc424a9890cbc1687f1d0.js"></script>

<!--
A JSON example of multiple pointers returned is as follows:

<script src="https://gist.github.com/swk003/6397f3d7b5ba7355629221e49754151b.js"></script>
-->
##### 1.5.4.3 No Record (pointer) Matched: ##### 

- HTTP 200-Request was successfully executed
- Empty bundle resource of type searchset containing a '0' (zero) total value indicating no record was matched

<script src="https://gist.github.com/swk003/f0d1049f7cf557e21ebe86052866a5bb.js"></script>

##### 1.5.4.4 Error Response (OperationOutcome) Returned: ##### 

- HTTP 400-Bad Request. Invalid Parameter. 
- OperationOutcome resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the search cannot be executed (not that there is no match)

<script src="https://gist.github.com/swk003/a418511924364b9407940ce2f573c4be.js"></script>

See Consumer Search section for all [HTTP Error response codes](api_consumer_documentreference.html#24-search-response) supported by Consumer Search API.