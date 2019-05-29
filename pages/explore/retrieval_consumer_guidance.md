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

Retrieval of a referenced record is done through an [HTTP(S) GET request](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3) to the record URL contained on the pointer. 

The format metadata attributes on the pointer describe how to render the record. For example, whether the referenced content is a publicly accessible web page, an unstructured PDF document or specific FHIR profile. See [Retrieval Formats](retrieval_formats.html) for further detail. 

Where the format code indicates that the record is secured via proxy, retrieval requests should be made through the SSP. See the section below for details on assembling the HTTP(S) request to the SSP.  

## Retrieval via the SSP ##

### SSP URL ###

The record format code indicates whether the record should be retrieved directly (for publicly accessible URLs) or is secured via the SSP. 
Where a record is to be secured via the SSP, the NRL will pre-fix the Pointer URL property with the proxy server URL as follows: 

<div markdown="span" class="alert alert-success" role="alert">
GET https://[proxy_server]/[record_url]</div>

For pointers returned in a response to a search or read interaction, the record URL metadata attribute will contain the URL for retrieving the record via the SSP, therefore there is no requirement for Consumers to construct the URL for the HTTP request to the proxy. 

### SSP Headers ###

The HTTP GET request must include a number of Spine specific HTTP headers:

|Header|Value|
|-----------|----------------|
|`Ssp-TraceID`|Consumer’s TraceID (i.e. GUID/UUID)|
|`Ssp-From`|Consumer’s ASID|
|`Ssp-To`|Provider's ASID|
|`Ssp-InteractionID`|Spine's InteractionID|

Please refer to the [Spine Secure Proxy Implementation Guide](https://developer.nhs.uk/apis/spine-core-1-0/ssp_implementation_guide.html) for full technical details. Guidance on obtaining the interaction ID and provider ASID can be found below. 

### Interaction ID ###
The interaction ID for retrieving a record is specific to the record format code, which is included in the pointer meta-data. See [Retrieval Formats](retrieval_formats.html) for the mapping between format code and interaction ID. 

### Provider ASID ###
The provider ASID can be obtained through performing a [Spine Directory Services (SDS)](https://developer.nhs.uk/apis/spine-core-1-0/build_directory.html) look-up. 
This can be done using the record author ODS code, which is included in the pointer meta-data, and the spine interaction ID. 

A worked example of the endpoint look-up process can be found on the [Spine Core specification](https://developer.nhs.uk/apis/spine-core-1-0/build_endpoints_example_spine_fhir.html).

## Authentication and Authorisation ##
Consumer systems must ensure that users are authenticated and authorised, using an appropriate access control mechanism, for retrieving records and documents. HTTP(S) requests to the SSP for retrieving records and documents must include an access token (JWT). Further detail can be found on the [Auth & Auth page](integration_authentication_authorisation.html).

## Handling Multiple Formats ##
Where a Pointer contains reference to multiple formats for a single record/document Consuming systems need to take action in order to understand which is the most appropriate format to display within their system. 
For example, a record may be available as a PDF document but also as a FHIR resource. In this situation Consumers may find it preferable to display the FHIR resource if the Consuming system can understand and process this type of FHIR resource.
