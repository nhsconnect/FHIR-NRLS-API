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




## 1. Provider Read ##

Provider API to support read access to NRLI pointers.

### 1.1 Provider Read Request Headers ###


All Consumer API read requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:

| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:read:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64 encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |

- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.


### 1.1.2 Provider Read Operation ###

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference/[id]</div>

{% include custom/read.response.html resource="DocumentReference" content="" %}




## 2. Provider Create ##

Provider API to support creation of NRLI pointers.

### 2.1 Provider Create Request Headers ###


All Consumer API create requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:

| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:create:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64 encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |

- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.

### 2.1.1. Provider Create Operation ###

<div markdown="span" class="alert alert-success" role="alert">
POST [baseUrl]/DocumentReference</div>

{% include custom/create.response.html resource="DocumentReference" content="" %}



## 3. Provider Update ##

Provider API to support NRLI pointer updates.

All provider documentReference update requests should contain a version id to avoid lost updates. See [FAQ](support_faq.html)

### 3.1 Provider Update Request Headers ###


All Consumer API create requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:

| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:update:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64 encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |

- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.

### 3.1.2 Provider Update Operation ###

<div markdown="span" class="alert alert-success" role="alert">
PUT [baseUrl]/DocumentReference/[id]</div>

{% include custom/update.response.html resource="DocumentReference" content="" %}


## 4. Provider Delete ##

Provider API to support deletion of NRLI pointers.

### 4.1 Provider Delete Request Headers ###


All Consumer API create requests should include the below additional HTTP request headers to support audit and security requirements on the Spine:

| Header               | Value |
|----------------------|-------|
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. |
| `Ssp-From`           | Client System ASID |
| `Ssp-To`             | The Spine ASID |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:delete:documentreference`|
| `Ssp-Version`  | `1` |
| `Authorization`      | This will carry the base64 encoded JSON web token required for audit - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. |

- Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.

### 4.1.2 Provider Delete Operation ###

<div markdown="span" class="alert alert-success" role="alert">
DELETE [baseUrl]/DocumentReference/[id]</div>

{% include custom/delete.response.html resource="DocumentReference" content="" %}



