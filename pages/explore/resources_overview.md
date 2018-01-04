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

<!--This section provides NRLS implementers with an overview of the NRLS API.-->

The NRLS API supports the following operations as detailed in the [Solution Interactions](overview/overview_interactions.html) section of this implementation guide:


|Actor|Read|Search|Create|Update|Delete|
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
|Consumer|![Tick](images/cross.png)|![Tick](images/tick.png)|![Cross](images/cross.png)|![Cross](images/cross.png)|![Cross](images/cross.png)|
|Provider|![Tick](images/tick.png)|![Tick](images/tick.png)|![Tick](images/tick.png)|![Tick](images/tick.png)|![Tick](images/tick.png)|


<!--
- Consumer discovery of patient records on the NRLI National Record Locator Index
- Consumer retrieval of patient records from the NRLS National Record Locator Service
- Provider creation, updates and deletions of patient record pointers on the NRLI National Record Locator Index
-->


## 2. Pre-Requisites for NRLS API ##

### 2.1 API Requirements ###

- SHALL support HL7 FHIR STU3 version 3.0.1.

<!--- SHALL support the CareConnect Patient resource profile.
- SHALL support at least one additional resource profile from the list of CareConnect Profiles-->

- SHALL Implement REST behavior according to the [FHIR specification](http://www.hl7.org/fhir/STU3/http.html)

- Resources SHALL identify the profile supported as part of the [FHIR Base Resource](https://www.hl7.org/fhir/resource-definitions.html#Resource.meta)

- SHALL support XML **or** JSON formats for all API interactions.


### 2.2 FHIR Conformance ###

SHALL declare a Conformance identifying the list of profiles, operations and search parameters supported.

In order to be a compliant FHIR server, the NRLS FHIR Server will expose a valid FHIR [CapabilityStatement](https://www.hl7.org/fhir/STU3/capabilitystatement.html) profile. See also [NRLS API FHIR conformance profile](api_foundation_conformance.html).

### 2.3 Spine Services ###

The NRLS API is accessed through the NHS Spine. As such, providers and consumers of the NRLS API are required to integrate with the following Spine services as a pre-requisite to making API calls to the NRLS API:


|National Service|Description|
| ------------- | ------------- |
|Personal Demographics Service (PDS)|National database of NHS patients containing details such as name, address, date of birth and NHS Number (known as demographic information).|

<!--
|Spine Security Proxy (SSP)|Spine server that acts as an intermediary for requests from clients seeking resources from other servers [TBC]|
-->

Detailed Spine services pre-requisites:

To use this API, provider/ consumer systems:

- SHALL have gone through accreditation and received an endpoint certificate and associated ASID (Accredited System ID) for the client system.
- SHALL have either:
	- Authenticated the user using national smartcard authentication, and obtained a the UUID from the user's smartcard (and associated RBAC role from CIS), or
	- Authenticated the user using an assured local mechanism, and obtained a local user ID and role
	- And pass this user information in a JSON web token - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details.

{% include warning.html content="It is not yet clear, whether or not national identity is needed to be established for a client to interact with the NRLS. Further elaboration of NRLS consumer and provider authentication scenarios is expected." %}

- SHALL have previously traced the patient's NHS Number using PDS or an equivalent service.



<!--
- Provider/ consumer systems SHALL have gone through accreditation and received an endpoint certificate and associated ASID for the client system.
- Provider/ consumer systems SHALL be capable of PDS tracing (or equivalent service e.g. SMSP) of patients
- Provider/ consumer systems SHALL have obtained a local user ID and role and passed this user information in a JSON web token.
-->
<!--- Provider/ consumer systems Shall have either authenticated the user using national smartcard authentication, and obtained a UUID from the user’s smartcard (and associated RBAC role from CIS) or authenticated the user using an assured local mechanism, and obtained a local user ID and role and passed this user information in a JSON web token.
- Spine Security Proxy (SSP) [TBC]
-->

### 2.4 NHS Number ###

Only verified NHS Number SHALL be used with FHIR API profiles. This can be achieved using a spine accredited system, a [Demographics Batch Service (DBS)](https://developer.nhs.uk/library/systems/demographic-batch-service-dbs/) batch-traced record (CSV), or using a [Spine Mini Services Provider (HL7v3)](https://nhsconnect.github.io/spine-smsp/) to verify the NHS Number.

<!--
{% include custom/contribute.html content="Get in touch with interoperabilityteam@nhs.net to improve the Prerequisites." %}
-->
<!--
## 3. API Structure ##

The API implementation guide has been split into Consumer and Provider API sections. 

Providers are systems external to the NRLS that expose records for retrieval via metadata or so-called Pointers that are stored in the NRLS. A Provider can be thought of as a system that has write access to the NRLS with some limited read-access that is designed to support Pointer maintenance. 

A Consumer can be thought of as a system that has read-access to the NRLS. The read access that a Consumer has is designed to facilitate the retrieval of Pointers that are of interest to the Consuming system. The way that Consumers retrieve Pointers from the system is different from the read-access that a Provider has.

The Consumer and Provider API sections have been structured to support:

- References - provides links to NHS Digital FHIR profiles, HL7 FHIR STU3 core resources and user stories
- Read interaction - accesses the current contents of a resource.
- Search Parameters - list of search parameters for the profile being described, including any tips for searching. This section shows examples of how to search using the provided search parameters
- Create interaction - create a new resource with a server assigned id
- Update interaction - update an existing resource by its id (or create it if it is new)
- Delete interaction - delete a resource
- Examples - Description of the Request & Response headers, example of how to search on a server and the expected response body as an example
-->

