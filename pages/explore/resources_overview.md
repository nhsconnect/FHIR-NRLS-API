---
title: Development Overview
keywords: getcarerecord, structured, rest, resource
tags: [rest,fhir,api]
sidebar: foundations_sidebar
permalink: explore.html
summary: "Overview of the Development section"
---

## 1. NRL API Overview ##

The NRL API supports the following operations as detailed in the [Solution Interactions](overview_interactions.html) section of this implementation guide:

|Interaction|HTTP Verb|Actor|Description|
| ------------- | ------------- | ------------- | ------------- | ------------- | 
|Read|GET|Consumer|Retrieve a single pointer by Logical ID|
|Search|GET|Consumer|Parameterised search for pointers on the NRL|
|Create|POST|Provider|Create a pointer on NRL|
|Create (Supersede)|POST|Provider|Replace an NRL pointer, changing the status of the replaced pointer to "superseded"|
|Update|PATCH|Provider|Update an NRL pointer to change the status to "entered-in-error"|
|Delete|DELETE|Provider|Delete an NRL pointer|

A system can be assured to perform both Consumer and Provider interactions, provided that all relevant pre-requisites and requirements are met. 

## 2. Pre-Requisites for NRL API ##

### 2.1 NRL Server API Conformance ###

- SHALL support HL7 FHIR STU3 version 3.0.1.

- SHALL Implement REST behavior according to the [FHIR specification](http://www.hl7.org/fhir/STU3/http.html)

- SHALL support XML **or** JSON formats for all API interactions.

### 2.2 NRL Client API Conformance ###

- SHALL support HL7 FHIR STU3 version 3.0.1.

- SHALL support **either** XML **or** JSON formats for all API interactions.

- SHOULD support the NRL Service RESTful interactions and search parameters.


### 2.3 Spine Services ###

The NRL API is accessed through the NHS Spine. As such, providers and consumers of the NRL API are required to integrate with the following Spine services as a pre-requisite to making API calls to the NRL API:


|National Service|Description|
| ------------- | ------------- |
|Personal Demographics Service (PDS)|National database of NHS patients containing details such as name, address, date of birth and NHS Number (known as demographic information).|

Detailed Spine services pre-requisites:

To use this API, Provider/Consumer systems:

- SHALL have gone through accreditation and received an endpoint certificate and associated ASID (Accredited System ID) for the client system.
- SHALL pass the system/organisation's information in a JSON web token - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details
- SHALL have previously traced the patient's NHS Number using PDS or an equivalent service.

In addition, Consumer systems:
- SHALL have authenticated the user using NHS Identity or national smartcard authentication, and obtained a the user's UUID and associated RBAC role
- SHALL pass the user's information in the JSON web token

### 2.4 NHS Number ###

Only verified NHS Number SHALL be used with FHIR API profiles. This can be achieved using a full PDS Spine compliant system (HL7v3), a [Spine Mini Services Provider (HL7v3)](https://nhsconnect.github.io/spine-smsp/) or a [Demographics Batch Service (DBS)](https://developer.nhs.uk/library/systems/demographic-batch-service-dbs/) batch-traced record (CSV) to verify the NHS number. 

The option of using a DBS service is for Provider systems only. Consumers performing a search operation must use either a full PDS Spine compliant system or a Spine Mini Services Provider. 

{% include note.html content="A verified NHS Number exists on PDS, is still in use and the demographic data supplied results in the correct degree of demographic matching as per PDS matching rules.<br/><br/>The NHS NUMBER is 10 numeric digits in length. The tenth digit is a check digit used to confirm its validity. The check digit is validated using the Modulus 11 algorithm and the use of this algorithm is mandatory. " %}


## 3. Explore the NRL ##

You can explore and test the NRL GET, POST and DELETE commands and responses using Swagger in our [Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).


