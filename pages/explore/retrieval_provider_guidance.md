---
title: Retrieval Provider Guidance
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_provider_guidance.html
summary: Provider requirements and guidance for record and document retrieval. 
---

{% include custom/search.warnbanner.html %}

## HTTP Request ##

Retrieval of documents/records is achieved through an HTTP GET request. See the [Retrieval Read Interaction](retrieval_interaction_read.html) page for details of the requirements for responding to an HTTP GET request for retrieval. 

## Provider Endpoint and Interaction ID registration ##

Endpoints for retrieval must be registered on the Spine Directory Service (SDS). For the Beta phase this will be done by the NHS Digital Deployment Issue and Resolution (DIR) team following completion of assurance. See the [Spine Core specification](https://developer.nhs.uk/apis/spine-core/ssp_providers.html) for further detail on registering provider endpoints. 

Providers MUST ensure that the record author ODS code on the pointer metadata matches the ODS code for the endpoint registered in SDS.

Providers MUST ensure that endpoints for retrieval are registered on SDS with the interaction ID `urn:nhs:names:services:nrl:DocumentReference.content`. 

## Fully Qualified Doman Name (FQDN) ##

Following completion of assurance, Providers will be supplied with an x509 Certificate and an FQDN. The FQDN will form the base of Provider Endpoints as detailed above. For further detail, see the [Security page](development_api_security_guidance.html).
