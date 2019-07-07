---
title: Retrieval Consumer Guidance
keywords: structured, rest, documentreference
tags: [rest,fhir,api]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_consumer_guidance.html
summary: Consumer requirements and guidance for record and document retrieval. 
---

{% include custom/search.warnbanner.html %}


## HTTP Request ##

Retrieval of documents/records is achieved through a HTTP GET request. See the [Retrieval Read Interaction](retrieval_interaction_read.html) page for details of the requirements for creating and sending a HTTP GET request for retrieval.

## Requests via the SSP ##

Where a document/record is to be retrieved via the SSP the Consumer MUST pre-fix the `content.attachment.url` property, taken from an NRL pointer, with the SSP server URL. For further details, see the [Retrieval Read](retrieval_interaction_read.html#retrieval-via-the-ssp) interaction page.

## Interaction ID ##

Consumers MUST include an interaction ID in the HTTP Headers when performing a retrieval request via the SSP.

The interaction ID for retrieving a record referenced in an NRL pointer is specific to the NRL service and is as follows:

`urn:nhs:names:services:nrls:SSPExternalClinical.read`

## Provider ASID ##

Consumers MUST include the provider ASID in the SSP-To HTTP Header when performing a retrieval request via the SSP.

The provider ASID can be obtained through performing a [Spine Directory Services (SDS)](https://developer.nhs.uk/apis/spine-core-1-0/build_directory.html) look-up. 
This can be done using the record author ODS code, which is included in the pointer meta-data, and the spine interaction ID. 

A worked example of the endpoint look-up process can be found on the [Spine Core specification](https://developer.nhs.uk/apis/spine-core-1-0/build_endpoints_example_spine_fhir.html).

## Handling Multiple Formats ##

Where a Pointer contains reference to multiple formats for a single record/document Consuming systems need to take action in order to understand which is the most appropriate format to display within their system. 

For example, a record may be available as a PDF document but also as a FHIR resource. In this situation Consumers may find it preferable to display the FHIR resource if the Consuming system can understand and process this type of FHIR resource.
