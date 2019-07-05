---
title: Retrieval Read Interaction
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_interaction_read.html
summary: Requirements and guidance for record and document retrieval Read Interaction. 
---

{% include custom/search.warnbanner.html %}


## HTTP Request ##

Retrieval of a referenced record is done through an [HTTP(S) GET](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3) request to the record URL contained on the pointer.

The format metadata attributes on the pointer describe how to render the record. For example, whether the referenced content is a publicly accessible web page, an unstructured PDF document or specific FHIR profile. See [Retrieval Formats](retrieval_formats.html) for further detail.

Where the format code indicates that the record is secured via proxy, retrieval requests should be made through the SSP. See the section below for details on assembling the HTTP(S) request to the SSP.

HTTP requests SHOULD NOT require custom headers (excluding those required for requests via the SSP) or any additional parameters to be passed in the URL. Custom headers and additional parameters MAY be supported but SHOULD be optional.

## Retrieval via the SSP ##

The Spine Secure Proxy (SSP) role in retrieval of documents/records is to be a single common authentication and authorisation gateway for all Consumers and Providers.

The act of sending a request via the SSP is not an automatically adopted mechanism and Providers MUST indicate whether their documents/records should be retrieved via the SSP. See [SSP URL](#ssp-url) below for details.

Retrieval requests via proxy are secured and audited by the SSP. For full technical details, see the [SSP specification](https://developer.nhs.uk/apis/spine-core-1-0/ssp_overview.html).

### SSP URL ###
The format code value on the Pointer model also indicates whether the retrieval request should be via proxy (SSP) or not. See [Retrieval Formats](retrieval_formats.html) for further detail.

Where a record is to be secured via the SSP, the NRL will pre-fix the Pointer URL property with the proxy server URL as follows:

<div markdown="span" class="alert alert-success" role="alert">
GET https://[proxy_server]/[record_url]</div>

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">GET https://[proxy_server]/https%3A%2F%2Fp1.nhs.uk%2FMentalHealthCrisisPlans%2Fda2b6e8a-3c8f-11e8-baae-6c3be5a609f5
</span></code>
Read a Mental Health Crisis Plan with the logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5' from a Provider system located at 'https://p1.nhs.uk' via the Spine Secure Proxy.</pre>
</div>

For pointers returned in a response to a search or read interaction, the record URL metadata attribute will contain the URL for retrieving the record via the SSP.

Consumers and Providers MUST not pre-fix the Pointer URL property with the SSP server URL.

### SSP Headers ###
The HTTP GET request must include a number of Spine specific HTTP headers:

|Header|Value|
|------------------|---------------------------|
|`Ssp-TraceID`|Consumer's TraceID (i.e. GUID/UUID)|
|`Ssp-From`|Consumer's ASID|
|`Ssp-To`|Provider's ASID|
|`Ssp-InteractionID`|Spine's InteractionID|

Please refer to the [Spine Secure Proxy Implementation Guide](https://developer.nhs.uk/apis/spine-core-1-0/ssp_overview.html) for full technical details. 

Guidance on obtaining the interaction ID and provider ASID can be found on the [Consumer Guidance](retrieval_consumer_guidance.html#interaction-id) page.

The headers must be returned in the response to the SSP for auditing purposes.

## Authentication and Authorisation ##

Systems that interaction with the SSP MUST meet the secure connection requirements of the SSP.

Consumer systems will ensure that users are authenticated and authorised, using an appropriate access control mechanism, before retrieving records and documents. HTTP(S) requests to the SSP for retrieving records and documents will include an access token (JWT) which can be used in Provider systems for auditing purposes. Providers are not required to perform any further authentication or authorisation. 

Further detail can be found on the [Authentication &amp; Authorisation](integration_authentication_authorisation.html) page.