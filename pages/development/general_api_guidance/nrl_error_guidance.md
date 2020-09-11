---
title: NRL Error Guidance
keywords: fhir development
tags: [fhir,development,for_providers,for_consumers]
sidebar: overview_sidebar
permalink: nrl_error_guidance.html
summary: Error guidance.
---

# FHIR Resources

The following table outlines the profiled FHIR resources used to inform a client of an error.

|Profile|Description|
|-------|-----------|
|[Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1)|The `OperationOutcome` resource is the data model used to share error, warning or information messages that result from an NRL Service interaction.|
|[Spine-OperationOutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0)|This version of the `OperationOutcome` resource is the default Spine `OperationOutcome` profiled resource that supports exceptions thrown by the Spine common requesthandler and not the NRL Service.|

### ValueSets

Error codes used within the `OperationOutcome` FHIR resources (including other Spine error codes that are outside the scope of this API) are defined in the following  ValueSets:

|ValueSet|Description|
|--------|-----------|
|[Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)|ValueSet of Spine error or warning codes in response to a request.|
|[Spine-Response-Code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0)|ValueSet of Spine 2 error codes in response to a patient record details request. Exceptions thrown by the Spine common requesthandler and not the NRL Service will be returned using the Spine default [Spine-OperationOutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to this default ValueSet.|

### CodeSystems

The following CodeSystems are used within the profiled FHIR resources above.

|CodeSystem|Description|
|----------|-----------|
|[Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1)|Spine error codes and descriptions.|

# Error Types

The NRL API defines many categories of errors, each of which encapsulates a problem with a specific part of a request sent to the NRL. Each type of error is discussed in its own section below with examples:

|Error Type|HTTP Status code|Description|
|----------|----------------|-----------|
|[Resource not found](nrl_error_guidance.html#resource-not-found)|404|Spine returns this error when a request references a resource, such as a `DocumentReference` or patient, that cannot be resolved **or** a request supports an NHS Number where no Spine Clinicals record exists for that NHS Number.|
|[Headers](nrl_error_guidance.html#headers)|400|There are a number of HTTP headers that must be supplied with any request, each with their own validation rules.|
|[Parameters](nrl_error_guidance.html#parameters)|400|Certain actions against the NRL allow a client to specify HTTP parameters. This class of error covers problems with the way those parameters are presented.|
|[Payload business rules](nrl_error_guidance.html#payload-business-rules)|400|Errors of this nature arise when the request payload (`DocumentReference`) does not conform to the business rules associated with its use as an NRL pointer.|
|[Payload syntax](nrl_error_guidance.html#payload-syntax)|400|Used when the syntax of the request payload (`DocumentReference`) is invalid. For example, if using JSON and the structure of the payload doesn't conform to JSON notation.|
|[Organisation not found](nrl_error_guidance.html#organisation-not-found)|400|Used to inform the client that the URL being used to reference a given Organisation is invalid.|
|[Invalid NHS Number](nrl_error_guidance.html#invalid-nhs-number)|400|Used to inform the client that the NHS Number used in a `Create` or `Search` interaction is invalid.|
|[Unsupported Media Type](nrl_error_guidance.html#unsupported-media-type)|415|Used to inform the client that a requested content type is not supported.|
|[Access denied](nrl_error_guidance.html#access-denied)|TBC|Used to inform the client that access to perform the interaction has been denied.|
|[Internal error](nrl_error_guidance.html#internal-error)|500|Used to inform the client of a failure during the change of `DocumentReference` status.|

## Resource Not Found

There are two situations when Spine will return this error:

- When a search request specifies an NHS Number for which no corresponding Clinicals record exists in the Spine Clinicals data store.
- When a request references a resource that cannot be resolved. For example, when a request references the [unique ID](explore_reference.html#identifiers) of a `DocumentReference`, but the ID is not known to the NRL. There are three scenarios in which this can occur:
  - Retrieval of a `DocumentReference` by logical identifier.
  - Request to delete a `DocumentReference` by logical identifier or master identifier.
  - Request to update a `DocumentReference` by logical identifier or master identifier.

The following table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for these exception scenarios.

|HTTP Code|issue-severity|issue-type|Details.Code|Details.Display|Diagnostics|
|---------|--------------|----------|------------|---------------|-----------|
|404|error|not-found|NO_RECORD_FOUND|No record found|No record found for supplied DocumentReference identifier - [id]|
|404|error|not-found|NO_RECORD_FOUND|No record found|The given NHS number could not be found [nhsNumber]|

## Headers

This error will be thrown in relation to the mandatory HTTP request headers. Scenarios where this error might be thrown:
- The mandatory `fromASID` HTTP header is missing in the request.

    The table details the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this scenario. Note that the header name is case-sensitive.

    |HTTP Code|issue-severity|issue-type|Details.Code|Details.Display|Diagnostics|
    |---------|--------------|----------|------------|---------------|-----------|
    |400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|fromASID HTTP Header is missing|

- The mandatory `toASID` HTTP header is missing in the request.

    The table details the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this scenario.

    |HTTP Code|issue-severity|issue-type|Details.Code|Details.Display|Diagnostics|
    |---------|--------------|----------|------------|---------------|-----------|
    |400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|toASID HTTP Header is missing|

- The mandatory `Authorization` HTTP header is missing in the request.

    The table details the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this scenario.

    |HTTP Code|issue-severity|issue-type|Details.Code|Details.Display|Diagnostics|
    |---------|--------------|----------|------------|---------------|-----------|
    |400|error|invalid|MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|Authorization HTTP Header is missing|

## Parameters

This error will be thrown in relation to request parameters that the client may have specified. This error can be thrown in a variety of circumstances.

The following table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.

|HTTP Code|issue-severity|issue-type|Details.Code|Details.Display|
|---------|--------------|----------|------------|---------------|
|400|error|invlid|INVALID_PARAMETER|Invalid parameter|

### Subject Parameter

When sending the mandatory `subject` parameter, referring to a `Patient` FHIR resource by reference, two pieces of information are needed:
- The URL of the FHIR server that hosts the `Patient` resource in the form `https://demographics.spineservices.nhs.uk/STU3/Patient/[nhsNumber]`.
- An identifier for the `Patient` resource being referenced. The identifier must be known to the server. In addition, where NHS Digital owns the business identifier scheme for a given type of FHIR resource, the logical and business identifiers will be the same. In this case, the NHS Number of a `Patient` resource is both a logical and business identifier, meaning it can be specified without the need to supply the identifier scheme. If the NHS Number is missing from the patient parameter, this error will be thrown.

### Custodian Parameter

When sending the optional `custodian` parameter, referring to an `Organisation` FHIR resource by business identifier, specifically its ODS code, two pieces of information are needed:
 - The business identifier scheme in the form `https://fhir.nhs.uk/Id/ods-organization-code`.
 - The business identifier, meeting the following requirements:
   - It must be a valid ODS code.
   - The ODS code must be an organisation that is known to the NRL.
   - The ODS code must be in the provider role.

### `_format` Parameter

This parameter must specify one of the [MIME types](development_overview.html#interaction-content-types) recognised by the NRL.

### Invalid Reference URL (Create Request)

This error can be thrown on a `Create` interaction. There are two exception scenarios:
- The `DocumentReference` in the request body specifies an incorrect URL for the FHIR server that hosts the `Patient` resource.
- The `DocumentReference` in the request body specifies an incorrect URL for the author/custodian `Organization` resource.

### `type` Parameter

When sending the mandatory `type` parameter, referring to a pointer by record type, two pieces of information are needed: 
- The identity of the [SNOMED URI](http://snomed.info/sct) terminology system.
- The pointer record type SNOMED concept, such as 736253002.

If the search request specifies unsupported parameter values in the request, this error will be thrown.

### `masterIdentifier` Parameter

Where `masterIdentifier` is a search term, both the `system` and `value` parameters must be supplied.

### `_summary` Parameter

The `_summary` parameter must have a value of `count`. If it's anything else, an error will be returned.

If the `_summary` parameter is provided, the only other parameter it can be used with is the optional `_format` parameter. If any other parameters are provided, an error will be returned.

## Payload Business Rules

### Invalid Resource

This error code may surface when creating or deleting a `DocumentReference`. There are a number of properties that make up the `DocumentReference` which have business rules associated with them. If there are problems with one or more of these properties, this error may be thrown.

This error code may also surface when updating a `DocumentReference` using the `Parameters` resource and `Update` interaction. This error may be thrown if the resource does not include the specified parameters or does not conform to the associated business rules.

The following table summarises the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.

|HTTP Code|issue-severity|issue-type|Details.Code|
|---------|--------------|----------|------------|
|400|error|invalid|INVALID_RESOURCE|

{% include note.html content="Although not stated in the table above, the OperationOutcome that the NRL returns in these scenarios will include `Details.display` and `Diagnostics` detail, which will aid in identifying which property this issue relates to." %}

#### Invalid Resource [Create/Supersede]

The following scenarios relate to the `Create` and `Supersede` interactions (HTTP POST):

* **Mandatory fields**

  If one or more mandatory fields are missing, this error will be thrown. See [`DocumentReference`](explore_reference.html) profile.

* **Mandatory field values**

  If one or more mandatory fields are missing a value, this error will be thrown.

* **Cardinality**

  If the wrong element cardinality is supplied, this error will be thrown.

* **DocumentReference fields**

  If any of the following field conditions are not met, this error will be thrown:

    |Element|Condition|
    |-------|---------|
    |`status`|Must be a [document-reference-status](http://hl7.org/fhir/STU3/valueset-document-reference-status.html) ValueSet value.|
    |`type`|Must be a [NRL-RecordType-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordType-1) ValueSet value.|
    |`class`|Must be a [NRL-RecordClass-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordClass-1) ValueSet value.|
    |`indexed`|Must be a valid FHIR [instant](http://hl7.org/fhir/stu3/datatypes.html#instant).|
    |`custodian`|The ODS code must be tied to the ASID supplied in the `fromASID` HTTP request header.|
    |`relatesTo.code`|If `relatesTo` is populated, must have value `replaces`.|
    |`content.attachment.creation`|If supplied, must be a valid FHIR [dateTime](https://www.hl7.org/fhir/STU3/datatypes.html#dateTime).|
    |`content.format`|Must be a [NRL-FormatCode-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-FormatCode-1) ValueSet value.|
    |`context.period.start`|If `context.period` is populated, must be a valid FHIR [dateTime](https://www.hl7.org/fhir/STU3/datatypes.html#dateTime).|
    |`context.period.end`|If populated, must be a valid FHIR [dateTime](https://www.hl7.org/fhir/STU3/datatypes.html#dateTime).|
    |`context.practiceSetting`|Must be a [NRL-PracticeSetting-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-PracticeSetting-1) ValueSet value.|

* **DocumentReference.Content.Extension:RetrievalMode**

  If the `DocumentReference` in the request body specifies a retrievalMode that is not part of the ValueSet defined in the [NRL-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1) FHIR profile, this error will be thrown.

* **Incorrect permissions to modify**

  When the NRL resolves a `DocumentReference` through the `relatesTo` property before modifying its status, the NRL should check that the ODS code associated with the `fromASID` HTTP header is associated with the ODS code specified on the `custodian` property of the `DocumentReference`. If it's not, the NRL will roll back all changes and return an error.

* **Patient mismatch**

  When the NRL resolves a `DocumentReference` through the `relatesTo` property, the `subject` property reference value **MUST** match the `subject` property reference on the new `DocumentReference` being created. If it doesn't, the NRL will roll back all changes and return an error.

* **MasterIdentifier mismatch**

  When the NRL resolves a `DocumentReference` through the `relatesTo` property and both the `relatesTo.target.identifier` and `relatesTo.target.reference` properties are populated, the `relatesTo.target.identifier` value must match the `masterIdentifier` property on the resolved `DocumentReference`. If it doesn't, the NRL will roll back all changes and return an error.

* **DocumentReference does not exist**

  If the NRL fails to resolve a `DocumentReference` through the `relatesTo` property, the NRL will roll back all changes and return an error.

#### Invalid Resource [Update]

The following scenarios relate to the [Update](api_interaction_update.html) interaction (HTTP PATCH):

* **Parameters: Type**

  When updating a `DocumentReference`, if the `type` parameter in the `Parameters` resource in the request body does not have the value `replace`, an error will be returned.

* **Parameters: Path**

  When updating a `DocumentReference`, if the `path` parameter in the `Parameters` resource in the request body does not have the value `DocumentReference.status`, an error will be returned.

* **Parameters: Value**

  When updating a `DocumentReference`, if the `value` parameter in the `Parameters` resource in the request body does not have the value `entered-in-error`, an error will be returned.

* **Provider ODS Code does not match Custodian ODS Code**

  If an update request contains a URL that resolves to a single `DocumentReference`, but the `custodian` property does not match the ODS code associated to the ASID value in the `fromASID` header, an error will be returned.

#### Invalid Resource [Delete]

The following scenarios relate to the [Delete](api_interaction_delete.html) interaction (HTTP DELETE):

* **Provider ODS Code does not match Custodian ODS Code**

  If a delete request contains a URL that resolves to a single `DocumentReference`, but the `custodian` property does not match the ODS code associated to the ASID value in the `fromASID` header, an error will be returned.

### Duplicate Resource

When the NRL persists a `DocumentReference` with a masterIdentifier, it should ensure that no other `DocumentReference` exists for that patient with the same masterIdentifier.

The following table summarises the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.

|HTTP Code|issue-severity|issue-type|Details.Code|Details.Display|Diagnostics|
|---------|--------------|----------|------------|---------------|-----------|
|400|error|duplicate|DUPLICATE_REJECTED|Duplicate DocumentReference|Duplicate masterIdentifier value: [masterIdentifier.value]<br />system: [masterIdentifier.system]|

### Inactive DocumentReference

This error is thrown when the status of the `DocumentReference` to be retrieved or modified is not `current`.

The following table summarises the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.

|HTTP Code|issue-severity|issue-type|Details.Code|Details.Display|Diagnostics|
|---------|--------------|----------|------------|---------------|-----------|
|400|warning|invalid|BAD_REQUEST|Bad Request|DocumentReference status is not current.|

## Payload Syntax

### Invalid Request Message

The INVALID_REQUEST_MESSAGE error is triggered when there is an XML or JSON syntax error in the `DocumentReference` resource in the request payload.

It is distinct from the INVALID_RESOURCE error, which conveys problems relating to the business rules associated with an NRL `DocumentReference`.

The following table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.

|HTTP Code|issue-severity|issue-type|Details.Code|Details.Display|Diagnostics|
|---------|--------------|----------|------------|---------------|-----------|
|400|error|value|INVALID_REQUEST_MESSAGE|Invalid Request Message|Invalid Request Message|

## Organisation Not Found

Organisations referenced in a `DocumentReference` must point to a resolvable `Organisation` FHIR resource. If the URL being used to reference a given Organisation is invalid, this error will result.

The URL must have the format `https://directory.spineservices.nhs.uk/STU3/Organization/[odsCode]`, where `[odsCode]`:
- Is a valid ODS code.
- Refers to an organisation known to the NRL.
- Refers to an organisation associated with the custodian property having a provider role.

<details>
  <summary>OperationOutcome details</summary>
  |Element|Content|
  |-------|-------|
  | `id` | A UUID for this `OperationOutcome`. |
  | `meta.profile` | Fixed value: `https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1` |
  | `issue.severity` | Fixed value: `error` |
  | `issue.code` | Fixed value: `not-found` |
  | `issue.details.coding.system` | Fixed value: `https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1` |
  | `issue.details.coding.code` | Fixed value: `ORGANISATION_NOT_FOUND` |
  | `issue.details.coding.display` | Fixed value: `Organisation not found` |
  | `issue.diagnostics` | Dynamic value: `The ODS code in the custodian and/or author element is not resolvable - [odsCode]` |
</details>

## Invalid NHS Number
Thrown when an NHS Number used in a `Create` or `Search` interaction is invalid.

<details>
  <summary>OperationOutcome details</summary>
  |Element|Content|
  |-------|-------|
  | `id` | A UUID for this `OperationOutcome`. |
  | `meta.profile` | Fixed value: `https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1` |
  | `issue.severity` | Fixed value: `error` |
  | `issue.code` | Fixed value: `invalid` |
  | `issue.details.coding.system` | Fixed value: `https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1` |
  | `issue.details.coding.code` | Fixed value: `INVALID_NHS_NUMBER` |
  | `issue.details.coding.display` | Fixed value: `Invalid NHS number` |
  | `issue.diagnostics` | Dynamic value: `The NHS number does not conform to the NHS Number format: [nhsNumber]` |
</details>

## Unsupported Media Type

There are various scenarios when an Unsupported Media Type business response code will be returned to a client:
- Request contains an unsupported `Accept` (no `_format` parameter).
- Request contains an unsupported `Accept` header and an unsupported `_format` parameter.
- Request contains a supported `Accept` header and an unsupported `_format` parameter.
- A `Search` interaction request with valid parameters, but the URL contains an unsupported `_format` parameter.

These exceptions are thrown by the Spine Core common requesthandler and not the NRL Service. They are supported by the default Spine [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile, which binds to the default Spine [spine-response-code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0) ValueSet. The following table summarises the HTTP response codes, along with the values to expect in the response `OperationOutcome`.

|HTTP Code|issue-severity|issue-type|Details.System|Details.Code|Details.Display|Diagnostics|
|---------|--------------|----------|--------------|------------|---------------|-----------|
|415|error|invalid|http://fhir.nhs.net/ValueSet/spine-response-code-1-0|UNSUPPORTED_MEDIA_TYPE|Unsupported Media Type|Unsupported Media Type|

## Internal Error

Where a request cannot be processed due to a fault within the NRL Service (not the client), a `500` **Internal Server Error** HTTP response code will be returned, along with a descriptive message in the response body, such as:

`<html><title>500: Internal Server Error</title><body>500: Internal Server Error</body></html>`
