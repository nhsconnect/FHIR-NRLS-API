---
title: Release Notes
keywords: development, versioning
tags: [development]
sidebar: overview_sidebar
permalink: overview_release_notes.html
summary: Summary release notes of the versions released in NRLS API Implementation Guide
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}

## 1.0.0-beta ##

Sprint 5 summary:

- [Error Handling](development_general_api_guidance.html#error-handling) section added to 'General API Guidance' page.
- Consumer and Provider API error response examples refined.
- Provider API Create and Update responses amended.
- VersionId guidance added.
- [CapabilityStatement](api_foundation_conformance.html) page updated.
- [Auditing](overview_behaviours.html#auditing) section added to 'Solution Behaviour' page.
- [Audit Trail](integration_cross_organisation_audit_and_provenance.html#audit-trail) section added to 'Cross Organization Audit & Provenance' page.
- [JWT Claims](integration_cross_organisation_audit_and_provenance.html#json-web-tokens-jwt) updated: 
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
