---
title: Retrieval Read Interaction
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_interaction_read.html
summary: Requirements and guidance for record and document retrieval Read Interaction. 
---

{% include custom/search.warnbanner.html %}


## Read Request ##

Retrieval of a referenced record is done through an [HTTP(S) GET](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3) request to the record URL contained on the pointer.

Retrieval requests should be made through the Spine Secure Proxy (SSP). An exception is made for retrieving publicly accessible contact details (format "Contact Details (HTTP Unsecured)"), for which requests should be made directly.

Consumer and Provider retrieval HTTP requests support the following HTTP request headers:

| Header(s)               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be the mime-type as described in the pointer metadata (`DocumentReference.content.attachment.contentType`). | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details. |  MUST |
| SSP Headers          | See below for details |  |

Requests SHOULD NOT require any additional custom headers.

Requests SHOULD NOT require any additional parameters to be passed in the URL.

## Read Response ##

Success:

- SHALL return a `200` **SUCCESS** HTTP status code on successful execution of the interaction.
- SHALL return a response body containing the requested record/document in the format described in the format metadata attributes on the pointer. See [Retrieval Formats](retrieval_formats.html) for further detail.

Failure: 
- SHALL return an error type HTTP status code
- SHOULD return a response body with diagnostic details.

## Retrieval via the SSP ##

The role of the SSP in retrieval of documents/records is to be a single common authentication and authorisation gateway for all Consumers and Providers.

Retrieval requests via proxy are secured and audited by the SSP. For full technical details, see the [SSP specification](https://developer.nhs.uk/apis/spine-core-1-0/ssp_overview.html).

### SSP URL ###
  
Where a document/record is to be retrieved via the SSP then Consumers MUST pre-fix the `content.attachment.url` property with the SSP server URL as follows:

<div markdown="span" class="alert alert-success" role="alert">
GET https://[proxy_server]/[record_url]</div>

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">GET https://[proxy_server]/https%3A%2F%2Fp1.nhs.uk%2FMentalHealthCrisisPlans%2Fda2b6e8a-3c8f-11e8-baae-6c3be5a609f5
</span></code>
Read a Mental Health Crisis Plan with the logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5' from a Provider system located at 'https://p1.nhs.uk' via the Spine Secure Proxy.</pre>
</div>

Providers MUST not pre-fix the Pointer URL property with the SSP server URL on creation of the pointer.

### SSP Headers ###
The HTTP GET request MUST include a number of Spine specific HTTP headers:

|Header|Value|
|------------------|---------------------------|
|`Ssp-TraceID`|Consumer's TraceID (i.e. GUID/UUID)|
|`Ssp-From`|Consumer's ASID|
|`Ssp-To`|Provider's ASID|
|`Ssp-InteractionID`|Spine's InteractionID. <br> <br> The interaction ID for retrieving a record referenced in an NRL pointer is specific to the NRL service and is as follows: <br> `urn:nhs:names:services:nrls:SSPExternalClinical.read`|


Please refer to the [Spine Secure Proxy Implementation Guide](https://developer.nhs.uk/apis/spine-core-1-0/ssp_overview.html) for full technical details. 

Guidance on obtaining the provider ASID can be found on the [Consumer Guidance](retrieval_consumer_guidance.html#interaction-id) page.

## Authentication and Authorisation ##

Systems that interaction with the SSP MUST meet the secure connection requirements of the SSP.

Consumer systems SHALL ensure that users are authenticated and authorised, using an appropriate access control mechanism, before retrieving records and documents. HTTP(S) requests to the SSP for retrieving records and documents will include an access token (JWT) which can be used in Provider systems for auditing purposes. Providers are not required to perform any further authentication or authorisation. 

Further detail can be found on the [Authentication &amp; Authorisation](integration_authentication_authorisation.html) page.