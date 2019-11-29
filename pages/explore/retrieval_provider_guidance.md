---
title: Retrieval Provider Guidance
keywords: structured rest documentreference
tags: [for_providers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_provider_guidance.html
summary: Provider requirements and guidance for record and document retrieval. 
---

## HTTP Request

Retrieval of documents/records is achieved through an HTTP GET request. See the [Retrieval Read Interaction](retrieval_interaction_read.html) page for details of the requirements for responding to an HTTP GET request for retrieval.

## Provider endpoint and interaction ID registration

Endpoints for retrieval must be registered on the Spine Directory Service (SDS). For the Beta phase, this will be done by the NHS Digital Deployment Issue and Resolution (DIR) team following completion of assurance.

The requirements for registering endpoints on SDS are as follows:

1. Every system MUST have a unique ASID for each organisation using it. For example, the same system deployed into three organisations would be represented by three unique ASIDs.
2. All interactions with the SSP MUST be over port 443.
3. Endpoints MUST NOT include explicit port declarations (e.g. `:443`).
4. Endpoints MUST have be registered with the interaction ID `urn:nhs:names:services:nrl:DocumentReference.content`.

See the [Spine Core specification](https://developer.nhs.uk/apis/spine-core/ssp_providers.html) for further detail on registering provider endpoints.

Providers MUST ensure that the record author ODS code on the pointer metadata matches the ODS code for the endpoint registered in SDS. This is required to enable Consumers to perform an SDS lookup to obtain the Provider system ASID and populate the Ssp-To header in the retrieval request. 

## Fully-qualified doman name (FQDN)

Following completion of assurance, Providers will be supplied with an [X.509 Certificate](https://tools.ietf.org/html/rfc5280){:target='_blank'} and an FQDN. The FQDN will form the base of Provider Endpoints as detailed above. For more details, see the [Security page](development_api_security_guidance.html).
