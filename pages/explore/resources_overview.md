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

## 1. NRL API Overview ##

<!--This section provides NRL implementers with an overview of the NRL API.-->

The NRL API supports the following operations as detailed in the [Solution Interactions](overview_interactions.html) section of this implementation guide:


|Actor|Read|Search|Create|Update|Delete|
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
|Consumer|![Tick](images/tick.png)|![Tick](images/tick.png)|![Cross](images/cross.png)|![Cross](images/cross.png)|![Cross](images/cross.png)|
|Provider|![Tick](images/tick.png)|![Tick](images/tick.png)|![Tick](images/tick.png)|![Tick](images/tick.png)|![Tick](images/tick.png)|


<!--
- Consumer discovery of patient records on the NRLI National Record Locator Index
- Consumer retrieval of patient records from the NRL National Record Locator
- Provider creation, updates and deletions of patient record pointers on the NRLI National Record Locator Index
-->


## 2. Pre-Requisites for NRL API ##

### 2.1 NRL Server API Conformance ###

- SHALL support HL7 FHIR STU3 version 3.0.1.

<!--- SHALL support the CareConnect Patient resource profile.
- SHALL support at least one additional resource profile from the list of CareConnect Profiles-->

- SHALL Implement REST behavior according to the [FHIR specification](http://www.hl7.org/fhir/STU3/http.html)

- SHALL support XML **or** JSON formats for all API interactions.

<!-- SHALL expose a valid NRL FHIR [CapabilityStatement](https://www.hl7.org/fhir/STU3/capabilitystatement.html) identifying the list of profiles, operations and search parameters supported. See [NRL API FHIR Capability Statement profile](api_foundation_conformance.html).-->

<!--- - SHALL support the NRLS-DocumentReference-1 resource profile.

- SHOULD identify the resource profiles supported as part of the FHIR meta.profile attribute for each instance.-->

### 2.2 NRL Client API Conformance ###

- SHALL support HL7 FHIR STU3 version 3.0.1.

<!--- SHALL support the CareConnect Patient resource profile.
- SHALL support at least one additional resource profile from the list of CareConnect Profiles-->

- SHALL support **either** XML **or** JSON formats for all API interactions.


- SHOULD support the NRL Service RESTful interactions and search parameters.

<!-- SHOULD support the RESTful interactions and search parameters as declared in the NRL FHIR Server CapabilityStatement.-->


### 2.3 Spine Services ###

The NRL API is accessed through the NHS Spine. As such, providers and consumers of the NRL API are required to integrate with the following Spine services as a pre-requisite to making API calls to the NRL API:


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
	- And pass this user information in a JSON web token - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details.

<!--
{% include warning.html content="It is not yet clear, whether or not national identity is needed to be established for a client to interact with the NRL. Further elaboration of NRL consumer and provider authentication scenarios is expected." %}
-->
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

Only verified NHS Number SHALL be used with FHIR API profiles. This can be achieved using a full PDS Spine compliant system, a [Spine Mini Services Provider (HL7v3)](https://nhsconnect.github.io/spine-smsp/) or a [Demographics Batch Service (DBS)](https://developer.nhs.uk/library/systems/demographic-batch-service-dbs/) batch-traced record (CSV) to verify the NHS number. 

The option of using a DBS service is for Provider systems only. Consumers performing a search operation must use either a full PDS Spine compliant system or a Spine Mini Services Provider. 

{% include note.html content="A verified NHS Number exists on PDS, is still in use and the demographic data supplied results in the correct degree of demographic matching as per PDS matching rules.<br/><br/>The NHS NUMBER is 10 numeric digits in length. The tenth digit is a check digit used to confirm its validity. The check digit is validated using the Modulus 11 algorithm and the use of this algorithm is mandatory. " %}


## 3. Explore the NRL ##

You can explore and test the NRL GET, POST and DELETE commands and responses using Swagger in our [Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).


