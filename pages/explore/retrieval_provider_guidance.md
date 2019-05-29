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

Consumers must be able to retrieve a referenced record through a [HTTP(S) GET request](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3) to the record URL contained on a pointer. 

The HTTP request should not require custom headers (excluding those required for requests via the SSP) or any additional parameters to be passed in the URL. 

## Formats ##

The format metadata attributes on the pointer must describe how to render the record. For example, whether the referenced content is a publicly accessible web page, an unstructured PDF document or specific FHIR profile. See [Retrieval Formats](retrieval_formats.html) for further detail and the list of currently supported formats. 

Multiple formats of a record or document can be made available through a single pointer on the NRL. For example a pointer can contain a reference to retrieve a record in PDF format and as a structured FHIR resource. Each format must be detailed in a separate content element on the DocumentReference (pointer). 

Providers SHOULD support PDF format as a minimum. 

### Multiple Format Example ###

The example below shows a pointer for a Mental Health Crisis Plan that can be retrieved over the phone (using the contact details listed on the referenced HTML web page) and directly as a PDF document. 

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/retrieval_multiple_formats.xml %}
{% endhighlight %}
</div>

## Retrieval via the SSP ##

The format code must also indicate whether the retrieval request should be direct or via proxy (SSP). 

Retrieval requests via proxy are secured and audited by the SSP. For full technical details, see the [SSP specification](https://developer.nhs.uk/apis/spine-core-1-0/ssp_overview.html). 

### SSP Headers ###

Retrieval HTTP GET requests through the SSP include a number of Spine specific HTTP headers:

|Header|Value|
|------------------|---------------------------|
|`Ssp-TraceID`|Consumer's TraceID (i.e. GUID/UUID)|
|`Ssp-From`|Consumer's ASID|
|`Ssp-To`|Provider's ASID|
|`Ssp-InteractionID`|Spine's InteractionID|

Please refer to the [Spine Secure Proxy Implementation Guide](https://developer.nhs.uk/apis/spine-core/ssp_implementation_guide.html) for full technical details. 

The headers must be returned in the response to the SSP for auditing purposes. 

## Provider Endpoint and Interaction ID registration ##

Endpoints for retrieval must be registered on the Spine Directory Service (SDS). For the Beta phase this will be done by the NHS Digital Deployment Issue and Resolution (DIR) team following completion of assurance. See the [Spine Core specification](https://developer.nhs.uk/apis/spine-core/ssp_providers.html) for further detail on registering provider endpoints. 

Providers must ensure that the record author ODS code on the pointer metadata matches the ODS code for the endpoint registered in SDS.

Providers must ensure that endpoints for retrieval are registered with the correct interaction ID. The interaction ID for retrieving a record is specific to the record format code, which is included in the pointer meta-data. See [Retrieval Formats](retrieval_formats.html) for the mapping between format code and interaction ID. 

## Fully Qualified Doman Name (FQDN) ##

Following completion of assurance, Providers will be supplied with an x509 Certificate and an FQDN. The FQDN will form the base of Provider Endpoints as detailed above. For further detail, see the [Security page](development_api_security_guidance.html).

## Authentication ##

Consumer systems will ensure that users are authenticated and authorised, using an appropriate access control mechanism, before retrieving records and documents. HTTP(S) requests to the SSP for retrieving records and documents will include an access token (JWT) which can be used in Provider systems for auditing purposes. Providers are not required to perform any further authentication or authorisation. Further detail can be found on the [Authentication &amp; Authorisation page](integration_authentication_authorisation.html).