---
title: Release Notes
keywords: development, versioning
tags: [development]
sidebar: overview_sidebar
permalink: overview_release_notes.html
summary: Summary release notes of the versions released in NRL API Implementation Guide
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRL API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}

{% include note.html content="Starting from release 2.0.0-beta, all list items and their sub-lists are considered &quot;general changes&quot; unless otherwise stated. " %}

## 2.0.0-beta ##
*Changes to &quot;document&quot; record/document retrieval requirements, new API interactions, NRL DocumentReference model changes, and updated guidance.*
  - *Breaking Change*{:.label.label-danger} The service name has changed from NRLS (National Record Locator Service) to NRL (National Record Locator)
  - *Breaking Change*{:.label.label-danger} The FHIR Resource NRLS-DocumentReference-1 uplifted to NRL-DocumentReference-1
    - Data model changes are detailed below
  - *Breaking Change*{:.label.label-danger} Data model changes 
    - `Class`: now mandatory and persisted by NRL
    - `Type`: ValueSet URL changed from NRLS-RecordType-1 to NRL-RecordType-1
    - `Context`: now mandatory
    - `Context.PracticeSetting`: now mandatory and persisted by NRL
    - `Context.Period`: now persisted by NRL
    - `Content.Format`: now mandatory and persisted by NRL
    - `Content`: has new mandatory extenion of ContentStability (NRL-ContentStability-1)
    - `RelatesTo`: now limited to max of 1
    - `RelatesTo.Code`: now limited to single code of 'replaces'
  - *Change*{:.label.label-warning} FHIR Resource examples (JSON/XML)
    -	Source of FHIR Resource examples has been changed
    -	FHIR Resource examples are now contained in a shorter scrollable code block
  -	*Change*{:.label.label-warning} Assurance page
    -	References to TOM have been changed to SCAL 
    -	Links to the on-boarding guide have been added
  -	*Change*{:.label.label-warning} Developer Guidance 
      -	Overview page 
          -	NHS number verification guidance updated 
          -	Actor to interation mapping table updated 
      - FHIR Resource page 
          - *Breaking Change*{:.label.label-danger} Renamed
          - *Breaking Change*{:.label.label-danger} Additional data model properties detailed
          - *Breaking Change*{:.label.label-danger} Additional valuesets, extensions, and codesystems added
          -	Master Identifier added to identifiers section
          -	The term 'Record Status' has changed to 'Pointer Status'
      -	General API Guidance 
          -	Error handling updates: 
              -	Invalid resource section re-structured
              -	Added detail for the 'update iteration' errors
              -	Added Patient mismatch errors added
              -	Added masterIdentifier errors added
              -	Inactive DocumentReference guidance added
              -	New data model error handling details added
      -	*New Feature*{:.label.label-info} Retrieval of Records/Documents Guidance now documented in a new section under Developer Guidance, which includes:
          - An overview of retrieval
          - Read interaction requirements
          - Provider guidance
          - Consumer guidance
          - Pointer format code guidance
  -	*Change*{:.label.label-warning} API Interactions
    -	*Breaking Change*{:.label.label-danger} Update interaction page has been renamed to 'Create (Supersede)'
        -	*New Feature*{:.label.label-info} 'Supersede' now supports supersede by logical id
        -	Now details additional error responses
        -	*Breaking Change*{:.label.label-danger} A 'supersede' with multiple `relatesTo` properties will now be rejected
        -	*Breaking Change*{:.label.label-danger} A 'supersede' with a `relatesTo` property containing a code other than 'replaces' will be rejected
        -	*New Feature*{:.label.label-info} New 'Update interaction' page created, see below
    -	*New Feature*{:.label.label-info} RESTful 'read' by logical id now supported which returns a single DocumentReference resource
    -	*New Feature*{:.label.label-info} RESTful 'update' now supported - using the HTTP PATCH verb
        -	HTTP PATCH supports update by logical id and master identifier
    -	Create interaction page details additional error responses
    -	Delete interaction  
        -	*New Feature*{:.label.label-info} Now supports RESTful delete by logical id i.e. DELETE [baseUrl]/DocumentReference/[id]
        -	Requirements have been moved into a single section
    -	Search interaction  
        -	*Breaking Change*{:.label.label-danger} Now only returns DocumentReference's that have a 'status' of current
        -	*Breaking Change*{:.label.label-danger} DocumentReference's with a format code that indicates the referenced content is to be retrieved via the SSP will have its url property modified to reflect this.
        -	These changes also apply to Read Interaction
        -	Bundle response now includes additional attributes:
            -	Self link added
            -	Search.mode added
            -	Resource.fullUrl added
  -	*Change*{:.label.label-warning} Integrate with spine
    -	Security page 
        -	This page has been moved from Developer guidance to the Integrate with spine section
        -	Overview section added
        -	Further clarity on which protocols can be used
        -	Updated the allowed cipher suite list
        -	Guidance added for those that already have a NHS Digital supplied x509 certificate
        -	Guidance document links have been fixed
    -	Access Token and Audit page renamed to Access Token (Audit has moved to it's own page)
    -	*New Feature*{:.label.label-info} New audit page added
    -	PDS Guidance updated
    -	Authentication guidance and requirements updated to reflect content retrieval and related service name changes
  -	*Change*{:.label.label-warning} Pointer Guidance
    -	More clarity on handling errors
    -	More clarity on use of the master identifier property
  -	*Change*{:.label.label-warning} Pointer Lifecycle
    -	*Breaking Change*{:.label.label-danger} Removed reference to transition from "entered-in-error" to current
    -	More clarity on meaning of each status
    -	More guidance on deleting pointers
  -	*Change*{:.label.label-warning} Pointer Maintenance
    -	More clarity on what deleting pointers does
    -	More clarity on handling lineages
    -	Detailed the new 'update' and 'supersede' interactions
  -	*Change*{:.label.label-warning} Solution
    -	*Breaking Change*{:.label.label-danger} Data model updated to reflect DocumentReference changes detailed above
    -	Clarity around caching data added


## 1.2.3-beta ##
*Changes to restructure the Implementation Guide*.
- `versionId` will be incremeted during a supersede transaction - Create API interaction updated to align with implementation.
- 500 Internal server error HTTP response guidance modified to match Spine Core output - Spine does not return an operation outcome.
- NRLS-DocumentReference-1 FHIR profile element guidance explicitly supports `relatesTo.target` element.

## 1.2.2-beta ##
*Changes to restructure the Implementation Guide*.
- Introduction of C# example code.
- Warnings about encoding query parameters.
- Additional guidance regarding JWT added.

## 1.2.1-beta ##
*Changes to restructure the Implementation Guide*.
- Wording change for Internal errors.
- Clearer guidance for pointer transitions (*Current to Superseded*).
- Explanation added for the Superseded status.
- Addition of example for deleting a pointer using masterIdentifier.
- Pointer error handling and pointer lineage guidance added. 


## 1.2.0-beta ##
*Changes to restructure the Implementation Guide*.
- Additional guidance added to the Data model page.
 - Cardinality corrected for *Related Documents*
 - Added *Status* to the model.
 - Description updated for the elements.
- Addition of new *API Interaction* section to describe the RESTful functionalities (Create, Delete, Search and Update).
- API Guidance > Search page
 - Format guidance added for Custodian.
 - Inclusion of the `_summary=count` functionality. 
- New Pointer-related pages added a new *Development Guidance* menu.
- General API Guidance
 - Error guidance has been restructured to be more informative to the reader.
 - Addition of INTERNAL_SERVER_ERROR and the response format.
- Exception tables moved from the API Interaction page to the General API Guidance page.
- Deploy menu option removed
- Assure menu option removed


## 1.1.0-beta ##

*Changes to re-align the NRL API 1.1.0-beta Specification with the DDC March and May 2018 NRL Service Development Iterations:*

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
   - Error Handling section updated to reflect API re-alignment with DDC NRL Service implementation.
   - Exceptions raised by the Spine Core common requesthandler and not the NRL Service will be supported by the default Spine OperationOutcome [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to the default Spine valueSet [spine-response-code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0). Codes include:
     - UNSUPPORTED_MEDIA_TYPE
- Pagination removed from Provider and Consumer search API.
- CapabilityStatement conformance functionality removed from this release.
- For this release the NRL Service returns data as the default format of `XML`. 
- [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile upversioned to 1.1.0. Changes as follows:
  - [ValueSet-NRLS-RecordType-1](https://fhir.nhs.uk/STU3/ValueSet/NRLS-RecordType-1) replaces ValueSet/CarePlanType-1
  - ValueSet-NRLS-RecordType-1 supports a single SNOMED concept:  `736253002 - Mental health crisis plan (record artifact)`.
  - All NRLS-DocumentReference-1 API examples updated to support record type: `Mental health crisis plan (record artifact)`. 
- [Solution Interactions](overview_interactions.html) diagrams updated.
- NRL access token (JWT) enhancements:
  - The NRL access token conforms to the Spine [JWT](https://nhsconnect.github.io/FHIR-SpineCore/security_jwt.html) definition.
  - New section [Access Tokens and Audit (JWT)](integration_access_tokens_JWT.html) added which replaces the Cross Organisation Audit & Provenance section.
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
- [Authentication and Autherisation](integration_authentication_authorisation.html) page added - NRL strategic approach to align with 'Care Access Service' which will become NHS Digital’s national Authentication and Authorisation service. 
- JSON and XML examples added to [Reference](explore_reference.html#7-examples) section.

## 1.0.0-alpha ##

Sprint 4 summary:

- Consumer and Provider APIs 'Success' Search Response amended to support an empty bundle if search returns no matches.
- Consumer API Search examples added.
- Development Guidance section now supports 'General API Guidance' page. This includes implementation guide 'notational conventions' and RESTful API 'content types' sections.
- The 'Accept' HTTP request header conformance amended to 'MAY'.

Sprint 3 summary:

- Consumer and Provider APIs now support the 'patient' Search parameter. This replaces the 'subject' parameter.
- Consumer and Provider APIs Search operations will not mandate the '_count' parameter. It is expected that the NRL Server will support paging as a default to break up result-sets that exceed a pre-determined limit.
- NRL API Conformance updated.

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
- NRL will not be fronted by SSP i.e. requests to read/write Pointers will not go through the SSP in order to reach NRL

First release of NRL FHIR API (STU3) via https://nhsconnect.github.io/. 

- Project follows the Gov.UK agile delivery phases.   

## 1.0.0-experimental ##

First draft of NRL DMS (Version 1.0 Draft A) created to support development of the Spine 2 POC National Record Locator interface.

Published on [NHS Developer Network](https://data.developer.nhs.uk/fhir/nrls-v1-draft-a/Chapter.1.About/index.html).
