---
title: NRL Interaction Overview
keywords: getcarerecord structured rest resource
tags: [development,for_providers,for_consumers]
sidebar: foundations_sidebar
permalink: nrl_interaction_overview.html
summary: Pointer creation, management and retrieval overview.
---

This section intends to give developers detailed requirements and guidance to interact with the NRL for the creation, management and retrieval of pointers.

# NRL Interactions

The NRL supports interactions for both providers and consumers.

You can explore and test the NRL interactions using Swagger ([NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html)).

### Provider Interactions

|Interaction|HTTP Verb|Description|
|-----------|---------|-----------|
|[Create](api_interaction_create.html)|POST| The `Create` interaction is used by a provider to create a pointer on the NRL. <br /><br />This interaction is usually triggered as a result of an event occurring within the provider system, such as some information being recorded in a patient's record, a document being stored or a patient registering with the healthcare service. The created pointer will have a `current` status. |
|[Create (Supersede)](api_interaction_supersede.html)|POST| The `Create (Supersede)` interaction allows a provider to create a new pointer which supersedes (replaces) one of their existing pointers.<br /><br />The status of the previous (superseded) pointer is changed to `superseded`, making it unavailable to consumers. This interaction should be used where information on an existing pointer needs changing, for example when the retrieval URL changes or an additional retrieval format is supported. |
|[Update](api_interaction_update.html)|PATCH| The `Update` interaction allows a provider to change the status of an existing pointer to hide it from consumers.<br /><br />The pointer status will be changed to `entered-in-error` which indicates an error was identified with either the pointer or the information it referenced. As only pointers with a `current` status are available to consumers, the updated pointer will no longer be available to consumers. |
|[Delete](api_interaction_delete.html)|DELETE| The `Delete` interaction allows a provider to remove one of their existing pointers from the NRL. |

### Consumer Interactions

|Interaction|HTTP Verb|Description|
|-----------|---------|-----------|
|[Read](api_interaction_read.html)|GET| The `Read` interaction allows a single pointer to be retrieved using its logical identifier.<br /><br />Only pointers with the status of `current` can be retrieved using the `Read` interaction. |
|[Search](api_interaction_search.html)|GET| The `Search` interaction allows a consumer to perform a parameterised search for pointers held on the NRL for a single patient.<br /><br />Only pointers with the status of `current` can be retrieved using the `Search` interaction. |

# General Requirements

## Endpoint Registration

For an organisation to be able to use the NRL:
- the system they are using **MUST** have been accredited through the [assurance process](assurance.html).
- the organisation **MUST** have been given an endpoint [certificate and associated ASID](guidance_security.html) for the environment (INT, DEP, LIVE) they wish to connect to.
- the organisation's endpoint **MUST** have been configured with the required interaction ids and service permissions.

## NHS Number

NHS Numbers submitted with any NRL interaction **MUST** be traced and verified prior to submission.

Verification of an NHS Number can be achieved using:
- a fully PDS Spine-compliant system (HL7v3).
- a [Spine Mini Services Provider (HL7v3)](https://nhsconnect.github.io/spine-smsp/).

Providers have an additional verification service available to utilise:
- a [Demographics Batch Service (DBS)](https://digital.nhs.uk/services/national-back-office-for-the-personal-demographics-service/demographics-batch-service-bureau) batch-traced record (CSV).

## JSON Web Token

A JSON Web Token (JWT) is required for all interaction with the NRL (and SSP). All requirements for JWT population can be found on the [JSON Web Token Guidance](guidance_jwt.html) page.

## Interaction Content Types

The NRL supports the following MIME types for NRL interactions:

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

The NRL supports the following methods for the client to specify the desired response format:
- the HTTP `Accept` header.
- the optional `_format` parameter.

If both are present in the request, the `_format` parameter overrides the `Accept` header value in the request. If neither the `Accept` header nor the `_format` parameter are supplied by the client system, the NRL server will return data in the default format of `application/fhir+xml`.

## Security

General requirements for security, authentication and authorisation are included in the specification on the [Security](guidance_security.html) page.
