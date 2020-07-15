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

When interacting with the NRL, all requests **MUST** include the system/organisation's information in a JSON web token (JWT), using the standard HTTP Authorization request header.

Where the interaction is a consumer retrieving pointers, the request **MUST** also include the user's information within the JSON web token.

The JWT **MUST** conform to the [Spine JWT](https://developer.nhs.uk/apis/spine-core/security_jwt.html) definition, but the validation of the claims is extended by the rules defined on this page. Where there is a difference between the validation specified in the Spine Core specification and on this page, the validation on this page override the rules defined for the Spine Core specification.

### JWT Claims

In the Spine JWT definition, the `requesting_organisation` claim is marked as optional. However, this claim **MUST** be supplied for all NRL and SSP requests.

In the context of a Consumer request, the `requesting_user` claim is mandatory for all NRL requests.


### JWT Validation

Depending upon the client’s role (Provider or Consumer) the validation that is applied to the JWT varies. The following table shows the various checking that are applied to each claim in the JWT and the associated diagnostics message if an error is detected:

| Claim being validated | Error scenario | Diagnostics | 
|-------|----------|-------------|
| `sub` | No `requesting_user` has been supplied and the sub claims’ value does not match the value of the `requesting_system` claim.| `requesting_system` and `sub` claim’s values must match.| 
| `sub` | `requesting_user` has been supplied and the sub claims’ value does not match the value of the `requesting_user` claim. | `requesting_user` and `sub` claim’s values must match.|
| `reason_for_request` | Reason for request does not have the value “directcare”.  | `reason_for_request` must be “directcare”. |
| `scope` | For requests to the NRL: scope is not one of `patient/DocumentReference.read` or `patient/DocumentReference.write`. | `scope` must match either `patient/DocumentReference.read` or `patient/DocumentReference.write`. |
| `scope` | For requests to the SSP: scope is not `patient/*.read`. | `scope` must match `patient/*.read`. |
| `requesting_system` | Requesting system is not of the form `https://fhir.nhs.uk/Id/accredited-system/[ASID]`. | `requesting_system` must be of the form `https://fhir.nhs.uk/Id/accredited-system/[ASID]`. | 
| `requesting_system` | `requesting_system` is not an ASID that is known to Spine. | The ASID must be known to Spine. | 
| `requesting_organisation`  | `requesting_organisation` is not of the form `https://fhir.nhs.uk/Id/ods-organization-code/[ODSCode]`. | `requesting_organisation` must be of the form `https://fhir.nhs.uk/Id/ods-organization-code/[ODSCode]`. |
| `requesting_organisation`  | The ODS code of the `requesting_organisation` is not known to Spine. | The ODS code of the `requesting_organisation` must be known to Spine. |
| `requesting_organisation`  | `requesting_organisation` is not associated with the ASID from the `requesting_system` claim. | The `requesting_system` ASID must be associated with the `requesting_organisation` ODS code. |

**Precedence of `requesting_user` over `requesting_system`**

If both the `requesting_system` and `requesting_user` claims have been provided, then the `sub` claim MUST match the `requesting_user` claim.


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
