---
title: API Create Interaction
keywords: structured, rest, documentreference
tags: [rest,fhir,documents,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_create.html
summary: To support the creation of NRLS pointers
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Provider Create ##

Provider API to support creation of NRLS pointers.

## Provider Create Request Headers ##

Provider API create requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |


## Provider Create Operation ##

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

### XML Example of a new DocumentReference resource (pointer) ###

<script src="https://gist.github.com/swk003/ddd53998c6021c357cdccd3bce839a7a.js"></script>

## Create Response ##

Success:

- SHALL return a `201` **CREATED** HTTP status code on successful execution of the interaction and the entry has been successfully created in the NRLS.
- SHALL return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Operation Outcome'](http://hl7.org/fhir/STU3/operationoutcome.html) core FHIR resource. See table below.
- SHALL return an HTTP `Location` response header containing the full resolvable URL to the newly created 'single' DocumentReference. 
  - The URL will contain the 'server' assigned `logical Id` of the new DocumentReference resource.
  - The URL format MUST be: `https://[host]/[path]?_id=[id]`. 
  - An example `Location` response header: 
    - `https://psis-sync.national.ncrs.nhs.uk/DocumentReference?_id=297c3492-3b78-11e8-b333-6c3be5a609f5`
- When a resource has been created it will have a `versionId` of 1. The `versionId` will not be incremented. <!-- Following an update the `versionId` will be incremented by 1.-->

 


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



- The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)
- See the 'General API Guidance' section for full on details NRLS [Error Handling](development_general_api_guidance.html#error-handling)
