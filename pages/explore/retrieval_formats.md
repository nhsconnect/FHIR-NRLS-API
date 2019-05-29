---
title: Retrieval Formats
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_formats.html
summary: Support formats for record and document retrieval
---

{% include custom/search.warnbanner.html %}


## Retrieval Formats ##


The NRL supports retrieval of records and documents  in a range of formats, including both unstructured documents and structured data. 

The format of the referenced record is detailed in two meta-data fields:
 - Record format
 - Record mime type 

See [FHIR Resources & References](explore_reference.html) for further detail on the data model. 

The combination of these two meta-data fields describes to a Consumer system the type and structure of the content that will be returned. This gives the Consumer system the information it needs to know to render the referenced record.  

## Supported Formats ##

The table below describes the formats that are currently supported:

| Format | Description |
|-----------|----------------|
|HTML Web Page (Publicly accessible)|A publicly accessible HTML web page detailing contact details for retrieving a record.|
|PDF (Publicly accessible)|A publicly accessible PDF detailing contact details for retrieving a record.|
|PDF|A PDF document. For guidance see the [CareConnect GET Binary specification](https://nhsconnect.github.io/CareConnectAPI/api_documents_binary.html).|

Please see the [format code value set](https://fhir.nhs.uk/STU3/ValueSet/NRLS-Format-1) for the list of codes to use. 

Note that the NRL supports referencing multiple formats of a record document on a single pointer. 

## Direct vs Proxy ##
The record format code also  indicates whether the record should be retrieved directly (for publicly accessible URLs) or is secured via the SSP. 
Where a record is to be secured via the SSP, the NRL will pre-fix the Pointer URL property with the proxy server URL as follows: 

<div markdown="span" class="alert alert-success" role="alert">
GET https://[proxy_server]/[record_url]</div>

For pointers returned in a response to a search or read interaction, the record URL metadata attribute will contain the URL for retrieving the record via the SSP, therefore there is no requirement for Consumers to construct the URL for the HTTP request to the proxy. 

## Interaction ID ##

The SSP requires an interaction ID for retrieval of records, which providers include in the SSP-InteractionID HTTP header as part of the HTTP request.  

The interaction ID is specific to the format of the record. The association between format codes and interaction IDs are detailed in the table below:

| Format code | Interaction ID |
|-----------|----------------|
|direct:https://www.w3.org/TR/html/|Not applicable (direct retrieval)|
|direct:https://www.iso.org/standard/63534.html|Not applicable (direct retrieval)|
|proxy:https://www.iso.org/standard/63534.html|urn:nhs:names:services:nrls:binary.read|

Endpoints for retrieval will need to be registered under the associated interaction ID on Spine Directory Services (SDS). For further details on registering endpoints, see [Provider Retrieval Guidance](retrieval_provider_guidance.html).  