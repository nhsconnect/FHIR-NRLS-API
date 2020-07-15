---
title: NRL Security Guidance
keywords: fhir development
tags: [fhir,development,for_providers,for_consumers]
sidebar: overview_sidebar
permalink: security_guidance.html
summary: "Implementation guidance for developers - focusing on general API implementation guidance"
---

# Security

- MUST have authenticated the user using NHS Identity or national smartcard authentication and obtained a the user's UUID and associated RBAC role.

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

