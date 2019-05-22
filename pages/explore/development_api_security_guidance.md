---
title: Security guidance
keywords: development
tags: [development]
sidebar: overview_sidebar
permalink: development_api_security_guidance.html
summary: "Details of the API security model and supported protocols"
---

## Secure Socket Layer (SSL), and Transport Layer Security (TLS) Protocols ##

After consultation with the Infrastructure Security, Operational Security and Spine DDC teams the following SSL protocols SHALL be supported.

- `TLSv1.2`

{% include note.html content="Protocol versions SSLv2, SSLv3, TLSv1.0, and TLSv1.1 are not supported and SHALL NOT be used. All consumer and provider systems SHALL be configured to implement the protocol version TLSv1.2." %}

## Supported Ciphers ##

After consultation with the Infrastructure Security, Operational Security and Spine DDC teams the following ciphers SHALL be supported.

{% include important.html content="The list of supported ciphers is ordered in order of preference (i.e. the first item being the most preferred)." %}

- `ECDHE-RSA-AES256-GCM-SHA384`
- `ECDHE-RSA-AES128-GCM-SHA256`
- `DHE-RSA-AES256-GCM-SHA384`
- `DHE-RSA-AES128-GCM-SHA256`
- `ECDHE-RSA-AES256-SHA384`
- `DHE-RSA-AES256-SHA256`
- `DHE-RSA-AES256-SHA`
- `ECDHE-RSA-AES256-SHA`

{% include note.html content="GCM (Galois Counter Mode) suites are prefered as these are resistant to timing attacks<sup>1</sup>." %}

{% include important.html content="A Java 8 (or above) Runtime Environment and/or an upto date version of OpenSSL is required to support the GCM cipher suites." %}

<sup>1</sup>[Digitcert - SSL Support Enabling Perfect Forward Secrecy](https://www.digicert.com/ssl-support/ssl-enabling-perfect-forward-secrecy.htm)


## Client Certificates (TLSMA) ##

Provider and consumer systems SHALL only accept client certificates issued by the NHS Digital Deployment Issue and Resolution (DIR) team.

Provider and consumer systems SHALL only accept client certificates with a valid Spine ‘chain of trust’ (that is, linked to the Spine SubCA and RootCA).

Provider and consumer systems SHALL only accept client certificates which have not expired or been revoked.

Provider and consumer systems SHALL check the `FQDN` presented in the client certificate is that of the [Spine Security Proxy](https://developer.nhs.uk/apis/spine-core-1-0/ssp_implementation_guide.html) (SSP).

## External Documents / Policy Documents ##

| Name | Author | Version | Updated |
| [Approved Cryptographic Algorithms Good Practice Guidelines](https://developer.nhs.uk/apis/gpconnect-1-2-2/development_api_security_guidance.html#external-policy-documents) | NHS Digital | v4.0 | 13/07/2016 |
| [Warranted Environment Specification (WES)](https://digital.nhs.uk/services/spine/spine-technical-information-warranted-environment-specification-wes) | NHS Digital | v1.0 | June 2015 |