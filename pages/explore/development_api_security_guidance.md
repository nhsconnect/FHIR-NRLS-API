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

{% include note.html content="SSLv2 and SSLv3 are deprecated and SHALL NOT be used. All consumer and provider systems SHALL be configured to implement TLSv1.2." %}

## Supported Ciphers ##

After consultation with the Infrastructure Security, Operational Security and Spine DDC teams the following SSL protocols SHALL be supported.

{% include important.html content="The list of supported ciphers is ordered in order of preference (i.e. the first item being the most preferred)." %}

- `AESGCM+EECDH`
- `AESGCM+EDH`
- `AES256+EECDH`
- `AES256+EDH`

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
| Approved Cryptographic Algorithms Good Practice Guidelines | NHS Digital | v4.0 | 13/07/2016 |
| Warranted Environment Specification (WES) | NHS Digital | v1.0 | June 2015 |