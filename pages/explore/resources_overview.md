---
title: Development Overview
keywords: getcarerecord, structured, rest, resource
tags: [rest,fhir,api]
sidebar: foundations_sidebar
permalink: explore.html
summary: "Overview of the Development section"
---

<!--
{% include custom/search.warnbanner.html %}

{% include custom/api_overview.svg %}
-->

## 1. NRLS API Overview ##

This section provides NRLS implementers with an overview of the NRLS API.

The NRLS API supports the following functionality:

- Consumer search patient record/s on the NRLI National Record Locator Index
- Consumer retrieve patient record/s from the NRLS National Record Locator Service
- Provider create patient record pointer/s on the NRLI National Record Locator Index
- Provider update patient record pointer/s on the NRLI National Record Locator Index
- Provider delete patient record pointer/s on the NRLI National Record Locator Index

The NRLS API is based on the HL7 FHIR STU3 3.0.1 Messaging Implementation (April 2017).

## 2. Pre-Requisites for NRLS API ##

### 2.1 API Requirements ###

- SHALL support HL7 FHIR STU3 version 3.0.1.

<!--- SHALL support the CareConnect Patient resource profile.
- SHALL support at least one additional resource profile from the list of CareConnect Profiles-->

- SHALL Implement REST behavior according to the [FHIR specification](http://http://www.hl7.org/fhir/http.html)

- Resources SHALL identify the profile supported as part of the [FHIR Base Resource](https://hl7.org/fhir/resource-definitions.html#Resource.meta)

- SHALL support XML **or** JSON formats for all API interactions and SHOULD support both formats.


### 2.2 FHIR Conformance ###

SHALL declare a Conformance identifying the list of profiles, operations and search parameters supported.

In order to be a compliant FHIR server, the NRLS FHIR Server will expose a valid FHIR [CapabilityStatement](https://www.http://hl7.org/fhir/STU3/capabilitystatement.html) profile. See also [NRLS API FHIR conformance profile](api_foundation_conformance.html).

### 2.3 Spine Services ###

The NRLS API is accessed through the NHS Spine. As such, providers and consumers of the NRLS API are required to integrate with the following Spine services as a pre-requisite to making API calls to the NRLS API:

- Personal Demographics Service (PDS)
- Spine Directory Service (SDS)
- Spine Security Proxy (SSP)

Detailed Spine services pre-requisites:

- Provider/ consumer systems SHALL have gone through accreditation and received an endpoint certificate and associated ASID for the client system.
- Provider/ consumer systems SHALL be capable of PDS tracing (or equivalent service e.g. SMSP) of patients
- Provider/ consumer systems Shall have either authenticated the user using national smartcard authentication, and obtained a UUID from the user’s smartcard (and associated RBAC role from CIS) or authenticated the user using an assured local mechanism, and obtained a local user ID and role and passed this user information in a JSON web token.
- Spine Security Proxy (SSP) TBC

### 2.4 NHS Number ###

Only verified NHS Number SHALL be used with FHIR API profiles. This can be achieved using a spine accredited system, a [Demographics Batch Service (DBS)](https://developer.nhs.uk/library/systems/demographic-batch-service-dbs/) batch-traced record (CSV), or using a [Spine Mini Services Provider (HL7v3)](https://nhsconnect.github.io/spine-smsp/) to verify the NHS Number.

<!--
{% include custom/contribute.html content="Get in touch with interoperabilityteam@nhs.net to improve the Prerequisites." %}
-->
## 3. API Structure ##

The API implementation guide has been split into Consumer and Provider API sections.

The FHIR profile API's described in the Consumer section have been structured in the following way:

- `0.` References
<!--- `1.` Read -->
- `1.` Search Parameters - List of search parameters for the profile being described, including any tips for searching. This section shows examples of how to search using the provided search parameters
- `2.` Example - Description of of the Request & Response headers, example of how to search on a server and the expected response body as an example

The FHIR profile API's described in the Provider section have been structured in the following way:

- `0.` References
- `1.` Create - Create a new DocumentReference resource with a server assigned id
- `2.` Update - Update an existing DocumentReference resource by its id (or create it if it is new)
- `3.` Delete - Delete a DocumentReference resource
- `4.` Example - Description of of the Request & Response headers, example of interactions and the expected response body as an example

<!--
### 1.1 Resource API Structure Details ###

<table style="min-width:100%;width:100%">
<tr id="clinical">
<th style="width:20%;">General</th>
<th style="width:80%;">Description </th>
</tr>
<tr>
<td>0. References</td>
<td>Links to other parts of the implementation guide which might help with context and understanding the API's described</td>
</tr>
<!--
<tr>

<td>1. Read</td>
<td>A description of how to get the API</td>
</tr>
-->
<!--
<tr>
<td>2. Search Parameters</td>
<td>List of search parameters for the profile being described, including any tips for searching. This section shows examples of how to search using the provided search parameters</td>
</tr>
<tr>
<td>3. Example</td>
<td>Description of of the Request & Response headers, example of how to search on a server and the expected response body as an example</td>
</tr>
</table>
-->

## 3. NRLS FHIR Resources ##
This section looks at the NRLS profile API's covered within this implementation guide.

<!--
<table style="min-width:100%;width:100%">
<tr id="clinical">
<th style="width:33%;">Clinical</th>
<th style="width:33%;">&nbsp;</th>
<th style="width:33%;">&nbsp;</th>
</tr>
<tr id="clinicald">
<th>Summary</th>
<th>Diagnostics</th>
<th>Medications</th>
</tr>
<tr>
<td><a href="api_clinical_allergyintolerance.html">AllergyIntolerance</a></td>
<td><a href="api_diagnostics_observation.html">Observation</a></td>
<td><a href="api_medication_medication.html">Medication</a></td>
</tr>
<tr>
<td><a href="api_clinical_condition.html">Condition</a> (Problem)</td>
<td>&nbsp;</td>
<td><a href="api_medication_medicationorder.html">MedicationOrder</a></td>
</tr>
<tr>
<td><a href="api_clinical_procedure.html">Procedure</a></td>
<td>&nbsp;</td>
<td><a href="api_medication_medicationstatement.html">MedicationStatement</a></td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td><a href="api_medication_immunization.html">Immunization</a></td>
</tr>
</table>
-->
<!--
<table style="min-width:100%;width:100%">
<tr id="base">
<th style="width:33%;">Base</th>
<th style="width:33%;">&nbsp;</th>
<th style="width:33%;">&nbsp;</th>
</tr>
<tr id="based">
<th>Individuals</th>
<th>Entities</th>
<th>&nbsp;</th>
</tr>
<tr>
<td><a href="api_entity_patient.html">Patient</a></td>
<td><a href="api_entity_organisation.html">Organization</a></td>
<td>&nbsp;</td>
</tr>
<tr>
<td><a href="api_entity_practitioner.html">Practitioner</a> (Problem)</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
</table>
-->

<table style="min-width:100%;width:100%">
<tr id="conformance">
<th style="width:33%;">Foundation</th>
<th style="width:33%;"></th>
</tr>
<tr id="conformanced">
<th>Conformance</th>
<!--<th>&nbsp;</th>-->
<th>Documents</th>
</tr>
<tr>
<td><a href="api_foundation_conformance.html">Conformance</a></td>
<!--<td><a href="api_foundation_valueset.html">ValueSet</a></td>-->
<!--<td>&nbsp;</td>-->
<td><a href="api_foundation_documentreference.html">DocumentReference</a></td>
</tr>
</table>
