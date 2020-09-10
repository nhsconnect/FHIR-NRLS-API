---
title: Security Guidance
keywords: fhir development
tags: [fhir,development,for_providers,for_consumers]
sidebar: overview_sidebar
permalink: security_guidance.html
summary: Security implementation guidance for developers.
---

## Interaction Security

Each interaction that can be performed against the NRL and SSP is given an unique interaction identifier (ID). Each system that connects to the NRL will be given a unique Accredited System Identifier (ASID), by NHS Digital, and this unique ASID will be associated with one or more interactions.

The interactions associated with a system's ASID will relate to the interactions for which the system has been approved and assured to use.

As part of sending a request to the NRL, the requesting system will supply its ASID and the interaction ID which relates to the action it is trying to perform. If the interaction ID is not associated with the system's ASID, the request will be blocked.

When a provider uses the `Supersede`, `Update` and `Delete` interactions to maintain existing pointers, the NRL will only allow the provider to make changes to their own pointers. To do this the NRL will validate that the ASID of the system attempting to manage the pointer is associated with the ODS code found in the pointer. If the ASID is not associated with the ODS code within the pointer the NRL will block the attempt.

## Technical Security Constraints

### Secure Socket Layer (SSL) and Transport Layer Security (TLS) Protocols

Following consultation with the Infrastructure Security, Operational Security, and Spine DDC teams, only the following SSL protocols are supported:

- TLSv1.2

   {% include note.html content="Protocol versions SSLv2, SSLv3, TLSv1.0, and TLSv1.1 are not supported and MUST NOT be used. All consumer and provider systems MUST be configured to implement the protocol version TLSv1.2." %}

### Ciphers

Following consultation with the Infrastructure Security, Operational Security, and Spine DDC teams, only the following ciphers are supported:

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

### Client Certificates (TLSMA)

Provider and consumer systems **MUST**:

- only accept client certificates issued by the NHS Digital Deployment Issue and Resolution (DIR) team.
- only accept client certificates with a valid Spine ‘chain of trust’ (that is, linked to the Spine SubCA and RootCA).
- only accept client certificates that have not expired or been revoked.
- verify that the FQDN presented in the client certificate is that of the [Spine Secure Proxy](https://developer.nhs.uk/apis/spine-core-1-0/ssp_implementation_guide.html) (SSP).

{% include note.html content="For providers and consumers that have been issued with an FQDN and an X.509 certificate for NRL pointer search and/or saintenance, these same assets may be re-used for the purpose of record retrieval.<br /><br />The NHS Digital Deployment Issue and Resolution (DIR) team will be able to confirm this at the point at which [endpoint registration](https://digital.nhs.uk/forms/combined-endpoint-and-service-registration-request) is required." %}

## External Documents/Policy Documents

|Name|Author|Version|Updated|
|----|------|-------|-------|
|[Approved Cryptographic Algorithms Good Practice Guideline](http://webarchive.nationalarchives.gov.uk/20161021125701/http:/systems.digital.nhs.uk/infogov/security/infrasec/gpg/acs.pdf)|NHS Digital|v4.0|<time datetime="2016-07-13">13 July 2016</time>|
|[Warranted Environment Specification (WES)](https://digital.nhs.uk/services/spine/spine-technical-information-warranted-environment-specification-wes)|NHS Digital|v3.2020|<time datetime="2020-07-22">22 July 2020</time>|
