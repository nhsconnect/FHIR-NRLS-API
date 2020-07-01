---
title: Release Notes
keywords: development versioning
tags: [overview]
sidebar: overview_sidebar
permalink: overview_release_notes.html
summary: Summary release notes of the versions released in NRL API Implementation Guide
---

## 2.3.0-beta

- Add clarification about use of `versionId` to [Supersede interaction page](api_interaction_supersede.html)
- Update ODS code and endpoint requirements guidance
- Remove SSP prefix from example `DocumentReference`s
- Update guidance on constructing SSP URLs and percent-encoding for document retrieval 
- Add clarification about cardinality in JSON
- Add notes about `CodeableConcept` data type
- Updated glossary of terms
- Update tags and enable filtering by tag name
- Remove obsolete pages
- Miscellaneous copy-edits and minor restructuring

## 2.2.0-beta
 - Renamed metadata 'Record class' to 'Record category'
 - Updated guidance on request headers for the retrieval read interaction
 - Updated guidance on use of CareConnect GET Binary API for unstructured retrieval
 - Added guidance on pointer model versioning
 - Updated guidance on Consumer and Provider interactions on:
    - Solution behaviour page
    - Solution interactions page
    - Development guidance overview page
 - Updated solution principles
 - Added detail on access control and RBAC codes
 - Changed the interaction ID that must be used:
    - for registering Provider document/record retrieval endpoints on SDS
    - for when Consumers perform a look-up of a Provider ASID on SDS
 - Added clarification on using absolute URLs in the Record URL metadata attribute

## 2.1.1-beta
 - Updated guidance on usage of SNOMED CT concepts in FHIR value sets
 - API interaction examples updated

## 2.1.0-beta
*Changes to record/document retrieval requirements and updated guidance*
 - *API Breaking Change*{:.label.label-danger} The custodian search parameter format has been updated
 - *API Breaking Change*{:.label.label-danger} The supported formats for retrieval have been updated
 - *API Breaking Change*{:.label.label-danger} The inclusion of the `meta.profile` element on the create and supersede interactions are now enforced
 - Consumer guidance on assembling SSP request updated
 - Updated JWT requirements for document/record retrieval via the SSP
 - Change to interaction ID for record retrieval via the SSP
 - Restructuring of record retrieval read interaction guidance
 - Added definition of FHIR `meta` attributes to the data model
 - Added clarity to the rules on the use of PATCH
 - Added clarity to the use of reference type metadata attributes
 - Added clarity on the use of NHS Number with subject/patient
 - API interaction examples updated
 - Guidance on prerequisites added to API interactions
 - Audit requirements elaborated
 - Phase 1 and Phase 2 overview updated

## 2.0.0-beta
*Changes to record/document retrieval requirements, new API interactions, NRL DocumentReference model changes, and updated guidance.*
  - The service name has changed from NRLS (National Record Locator Service) to NRL (National Record Locator)
  - *API Breaking Change*{:.label.label-danger} The FHIR Resource NRLS-DocumentReference-1 uplifted to NRL-DocumentReference-1
    - Data model changes are detailed below
  - *API Breaking Change*{:.label.label-danger} Data model changes 
    - `Class`: now mandatory and persisted by NRL
    - `Type`: ValueSet URL changed from NRLS-RecordType-1 to NRL-RecordType-1
    - `Context`: now mandatory
    - `Context.PracticeSetting`: now mandatory and persisted by NRL
    - `Context.Period`: now persisted by NRL
    - `Content.Format`: now mandatory and persisted by NRL
    - `Content`: has new mandatory extension of ContentStability (NRL-ContentStability-1)
    - `RelatesTo`: now limited to max of 1
    - `RelatesTo.Code`: now limited to single code of 'replaces'
  - FHIR Resource examples (JSON/XML)
    -	Source of FHIR Resource examples has been changed
    -	FHIR Resource examples are now contained in a shorter scrollable code block
  -	Assurance page
    -	References to TOM have been changed to SCAL 
    -	Links to the on-boarding guide have been added
  -	Developer Guidance 
      -	Overview page 
          -	NHS number verification guidance updated 
          -	Actor to interaction mapping table updated 
      - FHIR Resource page 
          - Renamed
          - Additional data model properties detailed
          - Additional valuesets, extensions, and codesystems added
          -	Master Identifier added to identifiers section
          -	The term 'Record Status' has changed to 'Pointer Status'
      -	General API Guidance 
          -	Error handling updates: 
              -	Invalid resource section re-structured
              -	Added detail for the 'update interaction' errors
              -	Added Patient mismatch errors
              -	Added masterIdentifier errors
              -	Inactive DocumentReference guidance added
              -	New data model error handling details added
      -	*New API Feature*{:.label.label-info} Retrieval of Records/Documents Guidance now documented in a new section under Developer Guidance, which includes:
          - An overview of retrieval
          - Read interaction requirements
          - Provider guidance
          - Consumer guidance
          - Pointer format code guidance
  -	API Interactions
    - Update interaction page has been renamed to 'Create (Supersede)'
        -	*New API Feature*{:.label.label-info} 'Supersede' now supports supersede by logical id
        -	Now details additional error responses
        -	*API Breaking Change*{:.label.label-danger} A 'supersede' with multiple `relatesTo` properties will now be rejected
        -	*API Breaking Change*{:.label.label-danger} A 'supersede' with a `relatesTo` property containing a code other than 'replaces' will be rejected
        -	New 'Update interaction' page created, see below
    -	*New API Feature*{:.label.label-info} RESTful 'read' by logical id now supported which returns a single DocumentReference resource
    -	*New API Feature*{:.label.label-info} RESTful 'update' now supported - using the HTTP PATCH verb
        -	HTTP PATCH supports update by logical id and master identifier
    -	Create interaction 
        - Page details additional error responses
        - *API Breaking Change*{:.label.label-danger} Format of Location response header has been changed to [baseUrl]/DocumentReference/[id]
    -	Delete interaction  
        -	*New API Feature*{:.label.label-info} Now supports RESTful delete by logical id i.e. DELETE [baseUrl]/DocumentReference/[id]
        -	Requirements have been moved into a single section
    -	Search interaction  
        -	Now only returns DocumentReference's that have a 'status' of current
        -	DocumentReference's with a format code that indicates the referenced content is to be retrieved via the SSP will have its url property modified to reflect this.
        -	These changes also apply to Read Interaction
        -	Bundle response now includes additional attributes:
            -	`Self link` added
            -	`Search.mode` added
            -	`Resource.fullUrl` added
  -	Integrate with spine
    -	Security page 
        -	This page has been moved from Developer guidance to the Integrate with spine section
        -	Overview section added
        -	Further clarity on which protocols can be used
        -	Updated the allowed cipher suite list
        -	Guidance added for those that already have a NHS Digital supplied X.509 certificate
        -	Guidance document links have been fixed
    -	Access Token and Audit page renamed to Access Token (Audit has moved to its own page)
    -	New audit page added
    -	PDS Guidance updated
    -	Authentication guidance and requirements updated to reflect content retrieval and related service name changes
  - Pointer Guidance
    -	More clarity on handling errors
    -	More clarity on use of the master identifier property
  -	Pointer Lifecycle
    -	Removed reference to transition from "entered-in-error" to current
    -	More clarity on meaning of each status
    -	More guidance on deleting pointers
  -	Pointer Maintenance
    -	More clarity on what deleting pointers does
    -	More clarity on handling lineages
    -	Detailed the new 'update' and 'supersede' interactions
  -	Solution
    -	Data model updated to reflect DocumentReference changes detailed above
    -	Clarity around caching data added

{% include important.html content="The service name has changed from NRLS (National Record Locator Service) to NRL (National Record Locator)" %}

- Changes to record/document retrieval requirements
- new API interactions
- NRL DocumentReference model changes
