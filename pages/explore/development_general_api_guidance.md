---
title: General API guidance
keywords: fhir development
tags: [fhir,development]
sidebar: overview_sidebar
permalink: development_general_api_guidance.html
summary: "Implementation guidance for developers - focusing on general API implementation guidance"
---

## Purpose ##

This implementation guide is intended for use by software developers looking to build a conformant NRL API interface using the FHIR&reg; standard with a focus on general API implementation guidance.

### Notational conventions ###

The keywords ‘**MUST**’, ‘**MUST NOT**’, ‘**REQUIRED**’, ‘**SHALL**’, ‘**SHALL NOT**’, ‘**SHOULD**’, ‘**SHOULD NOT**’, ‘**RECOMMENDED**’, ‘**MAY**’, and ‘**OPTIONAL**’ in this implementation guide are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## RESTful API ##

### Content types ###

- The NRL Server SHALL support both formal [MIME-types](https://www.hl7.org/fhir/STU3/http.html#mime-type) for FHIR resources:
  - XML: `application/fhir+xml`
  - JSON: `application/fhir+json`
  
- The NRL Server SHALL also support DSTU2 [MIME-types](https://www.hl7.org/fhir/DSTU2/http.html#mime-type) for backwards compatibility:
  - XML: `application/xml+fhir`
  - JSON: `application/json+fhir`
  
- The NRL Server SHALL also gracefully handle generic XML and JSON MIME types:
  - XML: `application/xml`
  - JSON: `application/json`
  - JSON: `text/json`
  
- The NRL Server SHALL support the optional `_format` parameter in order to allow the client to specify the response format by its MIME-type. If both are present, the `_format` parameter overrides the `Accept` header value in the request.

- If neither the `Accept` header nor the `_format` parameter are supplied by the client system the NRL Server SHALL return data in the default format of `application/fhir+xml`.

## Error handling ##

The NRL API defines numerous categories of error, each of which encapsulates a specific part of the request that is sent to the NRL. Each type of error will be discussed in its own section below with the relevant Spine response code:
- [Resource Not found](development_general_api_guidance.html#resource-not-found) - Spine supports this behaviour when:
  - a request references a resource that cannot be resolved be it a DocumentReference, Patient.
  - a request supports an NHS Number where no Spine Clinicals record exists for that NHS Number.
- [Headers](development_general_api_guidance.html#headers) - There are a number of HTTP headers that must be supplied with any request. In addition that values associated with those headers have their own validation rules. 
- [Parameters](development_general_api_guidance.html#parameters) – Certain actions against the NRL allow a client to specify HTTP parameters. This class of error covers problems with the way that those parameters may have been presented
- [Payload business rules](development_general_api_guidance.html#payload-business-rules) - Errors of this nature will arise when the request payload (DocumentReference) does not conform to the business rules associated with its use as an NRL Pointer
- [Payload syntax](development_general_api_guidance.html#payload-syntax) - Used to inform the client that the syntax of the request payload (DocumentReference) is invalid. For example, if using JSON to carry the DocumentReference then the structure of the payload may not conform to JSON notation.
- [Organisation not found](development_general_api_guidance.html#organisation-not-found) - Used to inform the client that the URL being used to reference a given Organisation is invalid.
- [Invalid NHS Number](development_general_api_guidance.html#invalid-nhs-number) - Used to inform a client that the the NHS Number used in a provider pointer create or consumer search interaction is invalid.
- [Unsupported Media Type](development_general_api_guidance.html#unsupported-media-type) - Used to inform the client that requested content types are not supported by NRL Service.
- [Access Denied](development_general_api_guidance.html#access-denied) - Used to inform the client that access has been denied to perform the interaction.
- [Internal Error](development_general_api_guidance.html#internal-error) - Used to inform the client if there is a failure during the change of the DocumentReference status.

The error codes (including other Spine error codes that are outside the scope of this API) are defined in the [Spine Error or Warning Code ValueSet](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1).


### <u>Resource not found</u> ###

There are two situations when Spine supports this behaviour:

- When a request references a resource that cannot be resolved. For example This error should be expected when a request references the [unique id](explore_reference.html#2-nrls-pointer-fhir-profile) of a DocumentReference however the id is not known to the NRL. There are two scenarios when the NRL Service supports this exception:
  - provider client retrieval of a DocumentReference by logical id
  - provider client request to delete a DocumentReference by logical id

- When a request supports an NHS Number where no Clinicals record exists in the Spine Clinicals data store for that NHS Number. The NRL Service supports this exception scenario in the consumer and Provider Search API interface.

The below table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for these exception scenarios.


| HTTP Code | issue-severity | issue-type |  Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|404|error|not-found |NO_RECORD_FOUND|No record found|No record found for supplied DocumentReference identifier - [id]|
|404|error|not-found|NO_RECORD_FOUND|No record found|The given NHS number could not be found [nhsNumber]|


### <u>Headers</u> ###

This error will be thrown in relation to the mandatory HTTP request headers. The scenarios when this error might be thrown:
- The  mandatory `fromASID` HTTP Header is missing in the request
  - The table details the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this scenario.

Note that the header name is case-sensitive.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid| MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|fromASID HTTP Header is missing|


- The mandatory `toASID` HTTP Header is missing in the request
  - The table details the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this scenario.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid| MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|toASID HTTP Header is missing|


- The mandatory `Authorization` HTTP Header is missing in the request
  - The table details the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this scenario.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid| MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|Authorization HTTP Header is missing|


### <u>Parameters</u> ###

This error will be raised in relation to request parameters that the client may have specified. As such this error can be raised in a variety of circumstances:

The below table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |
|-----------|----------------|------------|--------------|-----------------|
|400|error|invlid| INVALID_PARAMETER|Invalid parameter|


#### Subject parameter ####
When using the MANDATORY `subject` parameter the client is referring to a Patient FHIR resource by reference. Two pieces of information are needed: 
- the URL of the FHIR server that hosts the Patient resource.  If the URL of the server is not `https://demographics.spineservices.nhs.uk/STU3/Patient/` then this error will be thrown.

- an identifier for the Patient resource being referenced. The identifier must be known to the server. In addition where NHS Digital own the business identifier scheme for a given type of FHIR resource then the logical and business identifiers will be the same. In this case the NHS number of a Patient resource is both a logical and business identifier meaning that it can be specified without the need to supply the identifier scheme. If the NHS number is missing from the patient parameter then this error will be thrown.

#### Custodian parameter ####
When using the OPTIONAL `custodian` parameter the client is referring to an Organisation by a business identifier, specifically its ODS code. Two pieces of information are needed:
 - The business identifier scheme. In this case it must be `https://fhir.nhs.uk/Id/ods-organization-code`
 - The business identifier. The identifier must meet the following requirements:
   - It must be a valid ODS code. 
   - The ODS code must be an organisation that is known to the NRL.
   - The ODS code must be in the Provider role.

#### `_format` request parameter ####
This parameter must specify one of the [mime types](development_general_api_guidance.html#restful-api) recognised by the NRL.

#### Invalid Reference URL in Pointer Create Request ####
This error is raised during a provider create interaction. There are two exception scenarios:
- The DocumentReference in the request body specifies an incorrect URL of the FHIR server that hosts the Patient resource. 
- The DocumentReference in the request body specifies an incorrect URL of the author and custodian Organization resource. 


#### Type parameter ####
When using the MANDATORY `type` parameter the client is referring to a pointer by record type. Two pieces of information are needed: 
- the Identity of the [SNOMED URI](http://snomed.info/sct) terminology system
- the pointer record type SNOMED concept e.g. 736253002

If the search request specifies unsupported parameter values in the request, this error will be thrown. 

#### masterIdentifier parameter ####
Where masterIdentifier is a search term both the system and value parameters must be supplied.

#### _summary parameter ####
The _summary parameter must have a value of “count”. If it is anything else then an error should be returned to the client.

If the _summary parameter is provided then the only other param that it can be used with is the optional _format param. If any other parameters are provided then an error should be returned to the client.


### <u>Payload business rules</u> ###


### Invalid Resource ###
This error code may surface when creating or deleting a DocumentReference. There are a number of properties that make up the DocumentReference which have business rules associated with them. 
If there are problems with one or more of these properties then this error may be thrown.

The below table summarises the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.


| HTTP Code | issue-severity | issue-type | Details.Code | 
|-----------|----------------|------------|--------------|
|400|error|invalid| INVALID_RESOURCE|

#### mandatory fields ####
If one or more mandatory fields are missing then this error will be thrown. See [DocumentReference](explore_reference.html#2-nrls-pointer-fhir-profile) profile.

#### mandatory field values ####
If one or more mandatory fields are missing values then this error will be thrown. 

#### custodian ODS code ####

If the DocumentReference in the request body contains an ODS code on the custodian element that is not tied to the ASID supplied in the HTTP request header fromASID then this error will result. 


#### Attachment.creation ####
This is an optional field but if supplied:
- must be a valid FHIR [dateTime](https://www.hl7.org/fhir/STU3/datatypes.html#dateTime) 


#### DocumentReference.Status ####

If the DocumentReference in the request body specifies a status code that is not supported by the required HL7 FHIR [document-reference-status](http://hl7.org/fhir/ValueSet/document-reference-status) valueset then this error will be thrown. 


#### DocumentReference.Type ####
If the DocumentReference in the request body specifies a type that is not part of the valueset defined in the [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile this error will be thrown. 

#### DocumentReference.Indexed ####
If the DocumentReference in the request body specifies an indexed element that is not a valid [instant](http://hl7.org/fhir/STU3/datatypes.html#instant) as per the FHIR specification this error will be thrown. 

#### DocumentReference.Class ####
If the DocumentReference in the request body specifies a class that is not part of the valueset defined in the [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile this error will be thrown.

#### DocumentReference.Content.Format ####
If the DocumentReference in the request body specifies a format that is not part of the valueset defined in the [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile this error will be thrown.

#### DocumentReference.Content.Extension:RetrievalMode ####
If the DocumentReference in the request body specifies a retrievalMode that is not part of the valueset defined in the [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile this error will be thrown.

#### DocumentReference.Context.PracticeSetting ####
If the DocumentReference in the request body specifies a practiceSetting that is not part of the valueset defined in the [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile this error will be thrown.

#### DocumentReference.Context.Period ####
If the DocumentReference in the request body specifies a period then:
- At least the start date must be populated and must be a valid FHIR [dateTime](https://www.hl7.org/fhir/STU3/datatypes.html#dateTime) 
- If the end date is populated it must be a valid FHIR [dateTime](https://www.hl7.org/fhir/STU3/datatypes.html#dateTime)

#### relatesTo ####
If multiple relatesTo elements are included in a create request then an error will be returned. 

#### relatesTo.code ####
If the code is not set to the "replaces" then an error will be returned.

#### Incorrect permissions to modify ####

When the NRL resolves a DocumentReference through the relatesTo property before modifying its status the NRL should check that 
the ODS code associated with the fromASID HTTP header is associated with the ODS code specified on the custodian property of the 
DocumentReference. If not then the NRL should roll back all changes and an error returned.

#### Update or Delete Request - Provider ODS Code does not match Custodian ODS Code ####
This error is raised during a provider update or delete interaction. There are two exception scenarios:
- A provider update pointer request contains a URL that resolves to a single DocumentReference however the custodian property does not match the ODS code in the fromASID header.
- A provider delete pointer request contains a URL that resolves to a single DocumentReference however the custodian property does not match the ODS code in the fromASID header.

#### DocumentReference does not exist ####

When the NRL fails to resolve a DocumentReference through the relatesTo property then the NRL should roll back all changes and an error returned.

### Duplicate Resource ###

When the NRL persists a DocumentReference with a masterIdentifier it should ensure that no other DocumentReference exists 
for that patient with the same masterIdentifier.

The below table summarises the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|duplicate| DUPLICATE_REJECTED|Duplicate DocumentReference|Duplicate masterIdentifier <br/> value: [masterIdentifier.value] system: [masterIdentifier.system]|

### <u>Payload syntax</u> ###

### Invalid request message ###

This kind of error will be created in response to problems with the request payload. However the kind of errors that trigger this error are distinct from those that cause the INVALID_RESOURCE error which is intended to convey a problem that relates to the business rules associated with an NRL DocumentReference. The INVALID_REQUEST_MESSAGE error is triggered when there is a problem with the format of the DocumentReference Resource in terms of the XML or JSON syntax that has been used.

The below table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|value| INVALID_REQUEST_MESSAGE|Invalid Request Message|Invalid Request Message|


### Organisation not found ###
These two Organisations are referenced in a DocumentReference. Therefore the references must point to a resolvable FHIR Organisation resource. If the URL being used to reference a given Organisation is invalid then this error will result. The URL must conform to the following rules:
- Must be `https://directory.spineservices.nhs.uk/STU3/Organization`
- Must supply a logical identifier which will be the organisation's ODS code:
  - It must be a valid ODS code. 
  - The ODS code must be an organisation that is known to the NRL 
  - The ODS code associated with the custodian property must be in the Provider role.

If there is an exception then it should be displayed following the rules, along with the values
to expect in the `OperationOutcome` shown in the table below.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|not-found| ORGANISATION_NOT_FOUND|Organisation record not found|The ODS code in the custodian and/or author element is not resolvable – [ods code].|


### Invalid NHS Number ###
Used to inform a client that the the NHS Number used in a provider pointer create or consumer search interaction is invalid.

The below table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid| INVALID_NHS_NUMBER|Invalid NHS number|The NHS number does not conform to the NHS Number format: [nhs number].|


### Unsupported Media Type ###
There are three scenarios when an Unsupported Media Type business response code SHALL be returned to a client:
- Request contains an unsupported `Accept` header and an unsupported `_format` parameter.
- Request contains a supported `Accept` header and an unsupported `_format` parameter.
- Retrieval search query request parameters are valid however the URL contains an unsupported `_format` parameter value. 

These exceptions are raised by the Spine Core common requesthandler and not the NRL Service so are supported by the default Spine OperationOutcome [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to the default Spine valueSet [spine-response-code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0). The below table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for these exception scenarios.


| HTTP Code | issue-severity | issue-type | Details.System | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|415|error|invalid|http://fhir.nhs.net/ValueSet/spine-response-code-1-0 | UNSUPPORTED_MEDIA_TYPE|Unsupported Media Type|Unsupported Media Type|

### <u>Internal Error</u> ###

Where the request cannot be processed but the fault is with the NRL service and not the client then the NRL service will return a 500 HTTP response code along with a descriptive message in the response body e.g:

`<html><title>500: Internal Server Error</title><body>500: Internal Server Error</body></html>`


