---
title: Release Notes
keywords: development, versioning
tags: [development]
sidebar: overview_sidebar
permalink: overview_release_notes.html
summary: Summary release notes of the versions released in NRLS API Implementation Guide
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}

## 2.2.1-alpha ##

Sprint 3 early release summary:

- Record retrieval via the SSP will not be mandated.

## 2.2.0-alpha ##

Sprint 2 summary:

- Read Operation added to Consumer API.
- Provider and Consumer API search capabilities aligned.
- Pagination added to Provider and Consumer search API.
- If-Match header (containing ETag) dropped from Provider API update and delete operations.
- Security Guidance updated: TLSv1.2 must be supported for all new Spine interfaces and new cyphers added. 
- Implementation Guide semver use updated. No longer using pre-release numeric identifiers.

## 2.1.0-alpha.1 ##

Sprint 1 'internal' review feedback amendments include:

- References to SDS removed
- Solution principles changed to reflect that the Provider controls the Record retrieval mechanism strategy 
- NRLS will not be fronted by SSP i.e. requests to read/write Pointers will not go through the SSP in order to reach NRLS

## 2.0.0-alpha.1 ##

First release of NRLS FHIR API (STU3) via https://nhsconnect.github.io/. 

Project follows the Gov.UK agile delivery phases.   

## 1.0 : DRAFT A ##

First draft of NRLS DMS (Version 1.0 Draft A) created to support development of the Spine 2 POC National Record Locator Service interface.

Published on [NHS Developer Network](https://data.developer.nhs.uk/fhir/nrls-v1-draft-a/Chapter.1.About/index.html).
