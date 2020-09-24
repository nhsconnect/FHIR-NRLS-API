---
title: SSP Retrieval
keywords: structured rest documentreference
tags: [for_consumers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_ssp.html
summary: Requirements and guidance for information retrieval interactions via SSP.
---

The SSP is a content agnostic forward proxy, which is used to control and protect access to health systems. It provides a single security point for both authentication and authorisation for systems. See the [SSP specification](https://developer.nhs.uk/apis/spine-core/ssp_overview.html) for more details.

NRL information retrieval is an interaction between a consumer and a provider; routing and receiving requests via the SSP allows both parties to be ignorant of each other's authentication and authorisation mechanisms, as the SSP handles the other side of the transaction.

## End-to-End Retrieval Process

The following diagram describes how information retrieval is facilitated through the SSP using a URL included in a pointer.

[
    ![Retrieval solution end-to-end](images/retrieval/retrieval_concept_diagram.png)
](images/retrieval/retrieval_concept_diagram.png){:target="_blank"}

The diagram above depicts the step-by-step, end-to-end, process for retrieving information, as follows:
1. Consumer system queries the NRL to see if any pointers exist for the patient.
2. The NRL responds with a collection of pointers containing information about the patient.
3. Consumer system identifies a pointer that references information which could be of value for the provision of care.
4. Consumer system takes the URL property value from that pointer and uses this value to create a request to the provider system that holds the information.
5. Consumer system sends the request to the provider system via the SSP.
6. The SSP performs security checks against the consumer and then provider.
7. The request is forwarded onto the provider system.
8. Provider system receives and validates the request.
9. Provider system responds back to the SSP with the requested information, which is returned to the consumer.
10. Consumer system receives the information and processes it ready to display to the end user.

## Requesting Information via the SSP

Endpoints which allow retrieval of information via the SSP **MUST** do so with a [HTTPS GET](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3) request, to the URL contained within the NRL pointer.

The provider endpoint **MUST NOT** require any custom parameters to be passed with the request, unless explicitly stated in the relevant format specification.

For a consumer to retrieve information via the SSP, the consumer **MUST** percent encode the `content.attachment.url` property from the NRL pointer and prefix it with the SSP server URL as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET https://[proxy_server]/[percent_encoded_provider_endpoint_url]`
</div>

For example:

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">GET https://[proxy_server]/https%3A%2F%2Fp1.nhs.uk%2FMentalHealthCrisisPlans%2Fda2b6e8a-3c8f-11e8-baae-6c3be5a609f5
</span></code></pre>
</div>

{% include note.html content="When creating pointers, providers MUST NOT prefix the pointer URL property with the SSP server URL and MUST NOT percent encode it. In other words, consumers are fully responsible for constructing the Spine proxy URL from the pointer URL." %}

### HTTP Headers

The consumer and the provider's endpoint **MUST** support the following HTTP request headers:

|Headers|Value|
|-------|-----|
|`Authorization`|The `Authorization` header will carry the base64url encoded JSON web token required for audit on the Spine - see [JSON Web Token](guidance_jwt.html) page for details.|
|`Ssp-TraceID`|Consumer's TraceID - a unique identifier provided by the consumer (i.e. GUID/UUID).|
|`Ssp-From`|Consumer's ASID - a unique identifier for the consuming system.<br /><br />The consumer will be given an ASID by NHS Digital when connecting to the Spine.|
|`Ssp-To`|Provider's ASID.<br /><br />Consumers **MUST** include the provider ASID in the `Ssp-To` HTTP header when performing a retrieval request via the SSP.<br /><br />The provider ASID can be obtained through performing a [Spine Directory Services (SDS)](https://developer.nhs.uk/apis/spine-core-1-0/build_directory.html) lookup. This can be done using the [Information Owner ODS code](fhir_resource_mapping.html#information-owner), which is included in the pointer metadata, and the interaction ID `urn:nhs:names:services:nrl:DocumentReference.content`.<br/><br/>A worked example of the endpoint look-up process can be found in the [Spine Core specification](https://developer.nhs.uk/apis/spine-core-1-0/build_endpoints_example_spine_fhir.html).<br/><br/>If multiple ASIDs are found for the ODS code and interaction ID, the associated FQDN can be matched to the record URL FQDN to obtain the correct ASID.|
|`Ssp-InteractionID`|Spine's Interaction ID.<br /><br />The interaction ID for retrieving a record referenced in an NRL pointer is a fixed value, specific to the NRL service:<br /><br />`urn:nhs:names:services:nrl:DocumentReference.content.read`|

For more information on the SSP required headers or full technical details, please refer to the [Spine Secure Proxy Implementation Guide](https://developer.nhs.uk/apis/spine-core-1-0/ssp_implementation_guide.html).

The provider endpoint **MUST NOT** require any custom headers to be passed with the request, unless explicitly stated in the relevant format specification.

### Response

#### Success

A successful request **MUST**:
- return a `200` **OK** HTTP status code.
- return a response body containing the requested information in the format described in the format metadata attribute on the pointer. See [Supported Formats](retrieval_overview.html) for more details.

#### Failure

A failed request:
- **MUST** return an error type HTTP status code (i.e. 4xx or 5xx).
- SHOULD return a response body with diagnostic details.

## Authentication and Authorisation

Systems that interact with the SSP **MUST** meet the secure connection requirements of the SSP. Following completion of [assurance](assurance.html), providers will be supplied with an [X.509 Certificate](https://tools.ietf.org/html/rfc5280){:target='_blank'}.

Consumer systems **MUST** ensure users are authenticated and authorised, using an appropriate access control mechanism, before retrieving information. HTTPS requests to the SSP for retrieving records and documents will include a [JSON Web Token (JWT)](guidance_jwt.html), which can be used in provider systems for auditing purposes. Providers are not required to perform any further authentication or authorisation.

More details can be found on the [NRL Security Guidance](guidance_security.html) page.

### Citizen vs Health Care Professional Request

A provider may wish to return different data when the request for information is from a health care professional to when the request is from a citizen facing application.

An example of this might be:
- a provider might share some practitioner contact details with other healthcare professionals but may not wish to share those details with a citizen.
- a provider might wish to hold back information from a citizen about a sensitive result until the information has been shared with the patient by a practitioner, but that same information may be very useful to other healthcare professionals and could result in significantly improved care/life saving for the patient if they were to attend a service such as A&E before the provider has had chance to share that information with the patient.

To enable the provider to return appropriate information, all consumers wishing to retrieve data via the SSP **MUST** send the request with an appropriate JSON Web Token (JWT) identifying the intended audience. The requirements for the JWT are on the [JSON Web Token Guidance](guidance_jwt.html) page.

## Provider Retrieval Endpoints

Endpoints exposed by a provider for retrieval via the SSP must be registered on the Spine Directory Service (SDS). The requirements for registering endpoints on SDS are as follows:

1. The FQDN **MUST** be of the form `nrl-[ODS_code].[supplier].thirdparty.nhs.uk`, where the ODS code can be for the supplier or information owner organisation, depending on the deployment. Following completion of [assurance](assurance.html), providers will be supplied with an FQDN.
2. Every system **MUST** have a unique ASID for each organisation. For example, the same system deployed into three organisations would be represented by three unique ASIDs. See below for further details.
3. All interactions with the SSP **MUST** be over port `443`.
4. Endpoints **MUST NOT** include explicit port declarations (e.g. `:443`).
5. Endpoints **MUST** have been registered with the SSP retrieval interaction ID `urn:nhs:names:services:nrl:DocumentReference.content`.

See the [Spine Core specification](https://developer.nhs.uk/apis/spine-core/ssp_providers.html) for further detail on registering provider endpoints.

Providers **MUST** ensure that the [Information Owner ODS code](fhir_resource_mapping.html#information-owner) on the pointer metadata matches the ODS code for the endpoint registered in SDS. This is required to enable consumers to perform an SDS lookup to obtain the provider ASID and populate the `Ssp-To` header in the retrieval request. Each information owner requires an individual endpoint to be registered, therefore where multiple information owners expose records via a single deployment, it is recommended that the format of the endpoint is as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET https://[supplier_base_url]/[information_owner_ODS_code]/[path_to_record]`
</div>

For example:

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">GET https://nrl-ODS1.supplier.thirdparty.nhs.uk/ODS2/Binary/e73277f9-89e5-4d8c-8457-107e30fcb5a7
</span></code></pre>
</div>
