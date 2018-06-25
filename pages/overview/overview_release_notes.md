---
title: Release Notes
keywords: development, versioning
tags: [development]
sidebar: overview_sidebar
permalink: overview_release_notes.html
summary: Summary release notes of the versions released in NRLS API Implementation Guide
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}

## 1.1.0-beta ##

*Changes to re-align the NRLS API 1.1.0-beta Specification with the DDC March and May 2018 NRLS Service Development Iterations:*

- Provider and Consumer API Read interaction removed.
- Provider and Consumer API Search interaction changes:
  - `_count` Search parameter removed
  - `_id` Search parameter added
  - `type` Search parameter added
  - `patient` search parameter reverted to `subject`
  - Bundle type `searchset` does not support:
    - Encoded client search parameters in returned bundle using the `self link`.
    - The identity of resources in the entry using the `fullUrl` element.
    - Resources matched in a successful search using the `search.mode` element
 - Provider API Update interaction removed.
 - Provider API Delete interaction changes:
   - Now supports conditional delete interaction. Allows a provider to delete an existing pointer based on the search parameter `_id` which refers to the logical id of the pointer.
 - Spine response codes changes:
   - Amended for all Provider and Consumer API interactions
   - Successful Provider Create and Delete interactions now support positive response code values conveyed in the response body [Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) payload:
     - RESOURCE_CREATED
     - RESOURCE_ DELETED
   - Error Handling section updated to reflect API re-alignment with DDC NRLS Service implementation.
   - Exceptions raised by the Spine Core common requesthandler and not the NRLS Service will be supported by the default Spine OperationOutcome [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to the default Spine valueSet [spine-response-code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0). Codes include:
     - UNSUPPORTED_MEDIA_TYPE
- Pagination removed from Provider and Consumer search API.
- CapabilityStatement conformance functionality removed from this release.
- For this release the NRLS Service returns data as the default format of `XML`. 
- [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile upversioned to 1.1.0. Changes as follows:
  - [ValueSet-NRLS-RecordType-1](https://fhir.nhs.uk/STU3/ValueSet/NRLS-RecordType-1) replaces ValueSet/CarePlanType-1
  - ValueSet-NRLS-RecordType-1 supports a single SNOMED concept:  `736253002 - Mental health crisis plan (record artifact)`.
  - All NRLS-DocumentReference-1 API examples updated to support record type: `Mental health crisis plan (record artifact)`. 
- [Solution Interactions](overview_interactions.html) diagrams updated.
- NRLS access token (JWT) enhancements:
  - The NRLS access token conforms to the Spine [JWT](https://nhsconnect.github.io/FHIR-SpineCore/security_jwt.html) definition.
  - New section [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) added which replaces the Cross Organisation Audit & Provenance section.
 - [Assurance Process](assure.html) overview added to specification.



*Sprint 6 Summary:*

- Concept of direct and indirect pointers removed from API. Changes to the [Data Model](overview_data_model.html#data-model) and the [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile as follows: 
  - RecordRetrievalMode CodeableConcept functionality removed from the [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile. 
  - The following dependent FHIR assets have been removed from NHS FHIR Server and implementation guide:
    - Extension-NRLS-RecordRetrievalMode-1
    - ValueSet-NRLS-RecordRetrievalMode-1
    - CodeSystem-NRLS-RecordRetrievalMode-1

<!--`custodian` search parameter dropped from Consumer API. In turn the combined `patient and custodian` search parameter has also been dropped from Consumer API. See the [Error Handling section](development_general_api_guidance.html#consumer-search-should-return-422-with-error-code-of-invalid_parameter-under-the-following-circumstances) for further guidance.
- Additional Consumer and Provider API guidance added to [Parameters - INVALID_PARAMETER](development_general_api_guidance.html#parameters---invalid_parameter) Error Handling section.-->
- Consumer Provider API XML/ JSON examples added
- HTTP request headers amendments: 
  - Ssp-TraceID, Ssp-InteractionID, Ssp-Version - dropped from specification
  - Ssp-From and Ssp-To - Header name change to `fromASID` and `toASID`
  - Error Handling section reflects these changes
- Consumer and Provider API `INVALID_PARAMETER` error response code aligned to `400` *BAD REQUEST* HTTP response code.



## 1.0.0-beta ##

Sprint 5 summary:

- [Error Handling](development_general_api_guidance.html#error-handling) section added to 'General API Guidance' page.
- Consumer and Provider API error response examples refined.
- Provider API Create and Update responses amended.
- VersionId guidance added.
- CapabilityStatement page updated.
- [Auditing](overview_behaviours.html#auditing) section added to 'Solution Behaviour' page.
- Audit Trail section added to 'Cross Organization Audit & Provenance' page.
- JWT Claims updated: 
  - 'device' claim added - this is the Identifier (ASID) of the system where the request originates. 
  - 'sub' claim specification/ example has been updated.
- [Authentication and Autherisation](integration_authentication_authorisation.html) page added - NRLS strategic approach to align with 'Care Access Service' which will become NHS Digital’s national Authentication and Authorisation service. 
- JSON and XML examples added to [Reference](explore_reference.html#7-examples) section.

## 1.0.0-alpha ##

Sprint 4 summary:

- Consumer and Provider APIs 'Success' Search Response amended to support an empty bundle if search returns no matches.
- Consumer API Search examples added.
- Development Guidance section now supports 'General API Guidance' page. This includes implementation guide 'notational conventions' and RESTful API 'content types' sections.
- The 'Accept' HTTP request header conformance amended to 'MAY'.

Sprint 3 summary:

- Consumer and Provider APIs now support the 'patient' Search parameter. This replaces the 'subject' parameter.
- Consumer and Provider APIs Search operations will not mandate the '_count' parameter. It is expected that the NRLS Server will support paging as a default to break up result-sets that exceed a pre-determined limit.
- NRLS API Conformance updated.

Sprint 3 early release summary:

- Record retrieval via the SSP will not be mandated.

Sprint 2 summary:

- Read Operation added to Consumer API.
- Provider and Consumer API search capabilities aligned.
- Pagination added to Provider and Consumer search API.
- If-Match header (containing ETag) dropped from Provider API update and delete operations.
- Security Guidance updated: TLSv1.2 must be supported for all new Spine interfaces and new cyphers added. 
- Implementation Guide semver use updated. No longer using pre-release numeric identifiers.

Sprint 1 'internal' review feedback amendments include:

- References to SDS removed
- Solution principles changed to reflect that the Provider controls the Record retrieval mechanism strategy 
- NRLS will not be fronted by SSP i.e. requests to read/write Pointers will not go through the SSP in order to reach NRLS

First release of NRLS FHIR API (STU3) via https://nhsconnect.github.io/. 

- Project follows the Gov.UK agile delivery phases.   

## 1.0.0-experimental ##

First draft of NRLS DMS (Version 1.0 Draft A) created to support development of the Spine 2 POC National Record Locator Service interface.

Published on [NHS Developer Network](https://data.developer.nhs.uk/fhir/nrls-v1-draft-a/Chapter.1.About/index.html).
