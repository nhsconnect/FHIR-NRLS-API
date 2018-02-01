---
title: Cross Organisation Audit & Provenance
keywords: spine, ssp, integration, audit, provenance
tags: [integration]
sidebar: overview_sidebar
permalink: integration_cross_organisation_audit_and_provenance.html
summary: "Overview of how audit and provenance data transported over NRLS FHIR interfaces."
---

## Cross Organisation Audit & Provenance ##

Consumer systems SHALL provided audit and provenance details in the HTTP authorization header as an oAuth bearer token (as outlined in [RFC 6749](https://tools.ietf.org/html/rfc6749){:target="_blank"}) in the form of a JSON Web Token (JWT) as defined in [RFC 7519](https://tools.ietf.org/html/rfc7519){:target="_blank"}.

An example such an HTTP header is given below:

```
     Authorization: Bearer jwt_token_string
```


In future, national authentication and authorisation services will be made available which will issue a bearer token which can be used directly for accessing this API. In the interrim however, the client will need to construct the JWT themselves.

It is highly recommended that standard libraries are used for creating the JWT as constructing and encoding the token manually may lead to issues with parsing the token in Spine. A good source of information about JWT and libraries to use can be found on the [JWT.io site](https://jwt.io/)

### JSON Web Tokens (JWT) ###

Consumer system SHALL generate a new JWT for each API request. The Payload section of the JWT (see "JWT Generation" below for futher details) shall be populated as follows:

| Claim | Priority | Description | Fixed Value | Dynamic Value | Specification / Example |
|-------|----------|-------------|-------------|---------------|-------------------------|
| iss | R | Client systems issuer URI | No | Yes | |
| sub | O | Identifier of individual making the request.| No | Yes | This field is conditionally mandatory. It must be supplied if the client is just a Consumer. However if the client is a Provider this field is optional. Note that if available the Provider should populate this field however in cases where no user is in scope then the sub can be left unpopulated. Where the sub is supplied it could be local system identifier for that user or if national Smartcard capability has been used then this will be the user’s UUID. |
| device | R | Identifier (ASID) of system where request originates | No | Yes | |
| aud | R | Requested resource URI | No | Yes | |
| exp | R | Expiration time integer after which this authorization MUST be considered invalid. | No | (now + 5 minutes) UTC time in seconds | |
| iat | R | The UTC time the JWT was created by the requesting system | `No| now UTC time in seconds | |

<!--
{% include important.html content="In topologies where consumer applications are provisioned via a portal or middleware hosted by another organisation (e.g. a 'mini service' provider) it is important for audit purposes that the practitioner and organisation populated in the JWT reflect the originating organisation rather than the hosting organisation." %}
-->

#### JWT Generation ####
Consumer systems SHALL generate the JSON Web Token (JWT) consisting of three parts seperated by dots (.), which are:

- Header
- Payload
- Signature

The Spine does not currently validate the signature in the JWT that is sent, so the Consumer systems MAY generate an Unsecured JSON Web Token (JWT) using the "none" algorithm parameter in the header to indicate that no digital signature or MAC has been performed (please refer to section 6 of [RFC 7519](https://tools.ietf.org/html/rfc7519){:target="_blank"} for details).

```json
{
  "alg": "none",
  "typ": "JWT"
}
```

If using unsigned tokens, the consumer systems SHALL generate an empty signature.

The final output is three base64url encoded strings separated by dots (note - there is some canonicalisation done to the JSON before it is base64url encoded, which the JWT code libraries will do for you).

For example:

```shell
eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwOi8vZWMyLTU0LTE5NC0xMDktMTg0LmV1LXdlc3QtMS5jb21wdXRlLmFtYXpvbmF3cy5jb20vIy9zZWFyY2giLCJzdWIiOiIxIiwiYXVkIjoiaHR0cHM6Ly9hdXRob3JpemUuZmhpci5uaHMubmV0L3Rva2VuIiwiZXhwIjoxNDgxMjUyMjc1LCJpYXQiOjE0ODA5NTIyNzUsInJlYXNvbl9mb3JfcmVxdWVzdCI6ImRpcmVjdGNhcmUiLCJyZXF1ZXN0ZWRfcmVjb3JkIjp7InJlc291cmNlVHlwZSI6IlBhdGllbnQiLCJpZGVudGlmaWVyIjpbeyJzeXN0ZW0iOiJodHRwOi8vZmhpci5uaHMubmV0L0lkL25ocy1udW1iZXIiLCJ2YWx1ZSI6IjkwMDAwMDAwMzMifV19LCJyZXF1ZXN0ZWRfc2NvcGUiOiJwYXRpZW50LyoucmVhZCIsInJlcXVlc3RpbmdfZGV2aWNlIjp7InJlc291cmNlVHlwZSI6IkRldmljZSIsImlkIjoiMSIsImlkZW50aWZpZXIiOlt7InN5c3RlbSI6IldlYiBJbnRlcmZhY2UiLCJ2YWx1ZSI6IkdQIENvbm5lY3QgRGVtb25zdHJhdG9yIn1dLCJtb2RlbCI6IkRlbW9uc3RyYXRvciIsInZlcnNpb24iOiIxLjAifSwicmVxdWVzdGluZ19vcmdhbml6YXRpb24iOnsicmVzb3VyY2VUeXBlIjoiT3JnYW5pemF0aW9uIiwiaWQiOiIxIiwiaWRlbnRpZmllciI6W3sic3lzdGVtIjoiaHR0cDovL2ZoaXIubmhzLm5ldC9JZC9vZHMtb3JnYW5pemF0aW9uLWNvZGUiLCJ2YWx1ZSI6IltPRFNDb2RlXSJ9XSwibmFtZSI6IkdQIENvbm5lY3QgRGVtb25zdHJhdG9yIn0sInJlcXVlc3RpbmdfcHJhY3RpdGlvbmVyIjp7InJlc291cmNlVHlwZSI6IlByYWN0aXRpb25lciIsImlkIjoiMSIsImlkZW50aWZpZXIiOlt7InN5c3RlbSI6Imh0dHA6Ly9maGlyLm5ocy5uZXQvc2RzLXVzZXItaWQiLCJ2YWx1ZSI6IkcxMzU3OTEzNSJ9LHsic3lzdGVtIjoibG9jYWxTeXN0ZW0iLCJ2YWx1ZSI6IjEifV0sIm5hbWUiOnsiZmFtaWx5IjpbIkRlbW9uc3RyYXRvciJdLCJnaXZlbiI6WyJHUENvbm5lY3QiXSwicHJlZml4IjpbIk1yIl19fX0.
```

NOTE: As this is an unsigned token, the final section (the signature) is empty, so the JWT will end with a trailing . - this must not be omitted as it will then not be a valid token.

{% include tip.html content="The [JWT.io](https://jwt.io/) website includes a number of rich resources to aid in developing JWT enabled applications." %}

## Audit Trail ##

The various parts of an audit trail will be assembled from different parts of the request and in some cases will be calculated properties

### Request audit trail ###
_"This [local user on this] (1) system (2) from this organisation (3) with this legitimate relationship (4) has sent this request (5) at this time (6)..."_

1.  local user - taken from the sub claim on the JWT which is sent under the mandatory Authorization HTTP header. Note that the sub claim may or may not be provided (see [JWT](integration_cross_organisation_audit_and_provenance.html#json-web-tokens-jwt) table above)
2.  system - the ASID of the client system. Taken from the device claim on the [JWT](integration_cross_organisation_audit_and_provenance.html#json-web-tokens-jwt) which is sent under the mandatory Authorization HTTP header.
3.  organisation - calculated by looking up the ODS code of the Organisation that is associated with the ASID (Ssp-From)
4.  legitimate relationship - currently expected to be a fixed value of "directcare". No validation will be performed as to whether the given system and or organisation
are valid in their use of direct care as the kind of relationship
5.  request- the request URL, HTTP verb and the body of the request (in the case of a Provider's create and update actions)
6.  time - the datetime that the request landed on the NRLS web server

### Response audit trail ###
_"...which resulted in this response (1) at this time (2)"_

1.  response - HTTP response code, response body (if present), Location header (for create and update)
2.  time - the datetime that the NRLS web server posted its response to the client

For more detail on the Audit capabilities of the NRLS see [Auditing](overview_behaviours.html#auditing)
