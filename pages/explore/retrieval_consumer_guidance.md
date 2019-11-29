---
title: Retrieval Consumer Guidance
keywords: structured rest documentreference
tags: [for_consumers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_consumer_guidance.html
summary: Consumer requirements and guidance for record and document retrieval. 
---

## HTTP Request

Retrieval of documents/records is achieved through an HTTP GET request. See the [Retrieval Read Interaction](retrieval_interaction_read.html) page for details of the requirements for creating and sending an HTTP GET request for retrieval.

## Requests via the SSP

Where a document/record is to be retrieved via the SSP, the Consumer MUST percent encode the `content.attachment.url` property, taken from an NRL pointer, and prefix it with the SSP server URL. For more details, see the [Retrieval Read](retrieval_interaction_read.html#retrieval-via-the-ssp) interaction page.

## Provider ASID

Consumers MUST include the provider ASID in the SSP-To HTTP Header when performing a retrieval request via the SSP.

The provider ASID can be obtained through performing a [Spine Directory Services (SDS)](https://developer.nhs.uk/apis/spine-core-1-0/build_directory.html) lookup. This can be done using the record author ODS code, which is included in the pointer metadata, and the interaction ID `urn:nhs:names:services:nrl:DocumentReference.content`.

A worked example of the endpoint look-up process can be found in the [Spine Core specification](https://developer.nhs.uk/apis/spine-core-1-0/build_endpoints_example_spine_fhir.html).

If multiple ASIDs are found for the ODS code and interaction ID, the associated FQDN can be matched to the record URL FQDN to obtain the correct ASID.

## Handling Multiple Formats

Where a Pointer contains reference to multiple formats for a single record, Consuming systems can decide which is the most appropriate format to display within their system.

For example, a record may be available as a PDF document but also as a FHIR resource. In this situation, Consumers may find it preferable to display the FHIR resource if the Consuming system can understand and process this format.
