---
title: NRL Security Guidance
keywords: fhir development
tags: [fhir,development,for_providers,for_consumers]
sidebar: overview_sidebar
permalink: security_guidance.html
summary: "Implementation guidance for developers - focusing on general API implementation guidance"
---

# Security

Providers and Consumers are required to maintain a secure connection to the NRL and SSP.

The technical requirements that support this are detailed below.

## Secure Socket Layer (SSL) and Transport Layer Security (TLS) Protocols

Following consultation with the Infrastructure Security, Operational Security, and Spine DDC teams, the following SSL protocols MUST be supported.

- TLSv1.2

   {% include note.html content="Protocol versions SSLv2, SSLv3, TLSv1.0, and TLSv1.1 are not supported and MUST NOT be used. All consumer and provider systems MUST be configured to implement the protocol version TLSv1.2." %}

## Supported Ciphers

Following consultation with the Infrastructure Security, Operational Security, and Spine DDC teams, the following ciphers MUST be supported.

{% include important.html content="The supported ciphers are listed in order of preference, from most to least preferred." %}

- `ECDHE-RSA-AES256-GCM-SHA384`
- `ECDHE-RSA-AES128-GCM-SHA256`
- `DHE-RSA-AES256-GCM-SHA384`
- `DHE-RSA-AES128-GCM-SHA256`
- `ECDHE-RSA-AES256-SHA384`
- `DHE-RSA-AES256-SHA256`
- `DHE-RSA-AES256-SHA`
- `ECDHE-RSA-AES256-SHA`

{% include note.html content="GCM (Galois Counter Mode) suites are prefered, as these [are resistant to timing attacks](https://www.digicert.com/ssl-support/ssl-enabling-perfect-forward-secrecy.htm){:target='_blank'}." %}

{% include important.html content="A Java 8 (or above) Runtime Environment and/or an up-to-date version of OpenSSL is required to support the GCM cipher suites." %}

## Client Certificates (TLSMA)

Provider and consumer systems MUST only accept client certificates issued by the NHS Digital Deployment Issue and Resolution (DIR) team.

Provider and consumer systems MUST only accept client certificates with a valid Spine ‘chain of trust’ (that is, linked to the Spine SubCA and RootCA).

Provider and consumer systems MUST only accept client certificates that have not expired or been revoked.

Provider and consumer systems MUST verify that the `FQDN` presented in the client certificate is that of the [Spine Secure Proxy](https://developer.nhs.uk/apis/spine-core-1-0/ssp_implementation_guide.html) (SSP).

{% include note.html content="For Providers and Consumers that have been issued with an FQDN and an X.509 certificate for NRL Pointer Search and/or Maintenance, these same assets may be re-used for the purpose of record retrieval.<br><br>The NHS Digital Deployment Issue and Resolution (DIR) team will be able to confirm this at the point at which EndPoint registration is required." %}

## External Documents/Policy Documents

| Name | Author | Version | Updated |
| [Approved Cryptographic Algorithms Good Practice Guidelines](http://webarchive.nationalarchives.gov.uk/20161021125701/http:/systems.digital.nhs.uk/infogov/security/infrasec/gpg/acs.pdf) | NHS Digital | v4.0 | <time datetime="2016-07-13">13 July 2016</time> |
| [Warranted Environment Specification (WES)](https://digital.nhs.uk/services/spine/spine-technical-information-warranted-environment-specification-wes) | NHS Digital | v1.0 | <time datetime="2015-06">June 2015</time> |


## Access Tokens (JWT)

Clients MUST send an access token ({% include gloss.html term="JWT" %}) with each request to the NRL or the SSP using the standard HTTP Authorization request header. The JWT MUST conform to the [Spine JWT](https://developer.nhs.uk/apis/spine-core/security_jwt.html) definition.

The claims of the JWT are the same as those defined in the Spine Core JWT. However, the rules that govern the validation of those claims are different. From an NRL perspective, the rules defined here override rules defined for the Spine Core.

Where a Spine Core rule is not explicitly replaced here, the Spine Core rule stands.

### Claims

In the Spine JWT definition, the `requesting_organisation` claim is marked as optional. However, this claim MUST be supplied for all NRL and SSP requests.

### Validation

Depending upon the client’s role (Provider or Consumer) the validation that is applied to the JWT varies. The following section is broken down into three parts:

1. Common – validation that is common across Providers and Consumers
2. Provider – validation rules that only apply where the client is a Provider
3. Consumer – validation rules that only apply where the client is a Consumer

#### Common Validation

Where there has been a validation failure, the following response will be returned to the client. In all instances, the response will be the same. However, the diagnostics text will vary depending upon the nature of the error.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|structure|MISSING_OR_INVALID_HEADER|There is a required header that is missing or invalid| **Note:** See [MISSING_OR_INVALID_HEADER Exception Scenarios](integration_access_tokens_JWT.html#missing_or_invalid_header-exception-scenarios)|

#### MISSING_OR_INVALID_HEADER Exception Scenarios:

Example 1: JWT missing – the Authorization header has not been supplied. The following response MUST be returned to the client.

_Diagnostics - The Authorisation header must be supplied_


Example 2: JWT structure invalid – the Authorization header is present. However, the value is not a structurally valid JWT. In other words, one or more of the required elements of header, payload, and signature is missing.

_Diagnostics - The JWT associated with the Authorisation header must have all 3 sections_

Example 3: Mandatory claim missing – the Authorization header is present and the JWT is structurally valid. However, one or more of the mandatory claims is missing from the JWT.

_Diagnostics - The mandatory claim [claim] from the JWT associated with the Authorisation header is missing_


Example 4: Claim’s value is invalid — the Authorization header is present, the JWT is structurally valid, and a mandatory claim is present in the JWT, but its value is not valid. The following table shows the various checking that is applied to each claim in the JWT and the associated diagnostics message:

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

#### Provider Validation

No specific validation rules apply.

#### Consumer Validation

In the context of a Consumer request, the `requesting_user` claim is mandatory for all NRL and SSP requests.
