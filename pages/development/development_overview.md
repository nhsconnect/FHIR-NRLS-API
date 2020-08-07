---
title: Development Overview
keywords: getcarerecord structured rest resource
tags: [development,for_providers,for_consumers]
sidebar: foundations_sidebar
permalink: development_overview.html
summary: "Overview of the Development section"
---

The "Development Guidance" pages are intended to give developers detailed requirements and guidance needed to interact with the NRL for the creation, management and retrieval of pointers. The following page outlines the information available and some pre-requisites for using the NRL service.

In the requirement pages, the following keywords ‘**MUST**’, ‘**MUST NOT**’, ‘**REQUIRED**’, ‘**SHALL**’, ‘**SHALL NOT**’, ‘**SHOULD**’, ‘**SHOULD NOT**’, ‘**RECOMMENDED**’, ‘**MAY**’, and ‘**OPTIONAL**’ are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt), in order to create an NRL compliant system.


# NRL Interactions

The NRL supports the following interactions as detailed in the [Architectural Overview](architectural_overview.html) page:

|Interaction|HTTP Verb|Actor|Description|
| ------------- | ------------- | ------------- | ------------- | ------------- | 
|[Read](api_interaction_read.html)|GET|Consumer|Retrieve a single pointer by Logical ID|
|[Search](api_interaction_search.html)|GET|Consumer|Parameterised search for pointers on the NRL|
|[Create](api_interaction_create.html)|POST|Provider|Create a pointer on NRL|
|[Create (Supersede)](api_interaction_supersede.html)|POST|Provider|Replace an NRL pointer, changing the status of the replaced pointer to "superseded"|
|[Update](api_interaction_update.html)|PATCH|Provider|Update an NRL pointer to change the status to "entered-in-error"|
|[Delete](api_interaction_delete.html)|DELETE|Provider|Delete an NRL pointer|


### Explore NRL Interactions

You can explore and test the NRL GET, POST, and DELETE commands and responses using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).


# Generic Requirements

## Endpoint Registration

For an organisation to be able to use the NRL:
- the system they are using **MUST** have been accredited through the [assurance process](assure.html)
- the organisation **MUST** have been given an endpoint [certificate](security_guidance.html) and associated ASID for the environment (INT, DEP, LIVE) they wish to connect to
- the organisation's endpoint **MUST** have been configured with the required interaction Ids and service permissions


## NHS Number

NHS Numbers used within any interaction with the NRL, **MUST** be traced and verified.

Verified of an NHS Number can be done using:
- a fully PDS Spine-compliant system (HL7v3)
- a [Spine Mini Services Provider (HL7v3)](https://nhsconnect.github.io/spine-smsp/)
- a [Demographics Batch Service (DBS)](https://developer.nhs.uk/library/systems/demographic-batch-service-dbs/) batch-traced record (CSV)

The option of using a DBS service is for Provider systems only. Consumers performing a search operation **MUST** use either a full PDS Spine compliant system or a Spine Mini Services Provider.


## JSON Web Token

The JSON Web Token (JWT) is required for all interaction with NRL and the SSP. All requirements for population of the JWT can be found on the [JSON Web Token Guidance](jwt_guidance.html) page.


## Interaction Content Types

The NRL Supports the following MIME-types for NRL interactions:

**XML**
- `application/fhir+xml`
- `application/xml+fhir`
- `application/xml`

**JSON**
- `application/fhir+json`
- `application/json+fhir`  
- `application/json`
- `text/json`
  
### Response Format

The NRL supports the following methods to allow the client to specify the response format by its MIME type:
- the http `Accept` header 
- the optional `_format` parameter

If both are present in the request, the `_format` parameter overrides the `Accept` header value in the request. If neither the `Accept` header nor the `_format` parameter are supplied by the client system, the NRL Server will return data in the default format of `application/fhir+xml`.


## Security

Generic requirements for security, authentication and authorisation are included in the specification on the [Security Guidance](security_guidance.html) page.


## Retrieval

Requirements on information retrieval formats and retrieval mechanisms are outline in the [Information Retrieval](retrieval_overview.html) section of this specification.
