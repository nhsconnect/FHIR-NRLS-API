---
title: SSP Retrieval
keywords: structured rest documentreference
tags: [for_consumers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_ssp.html
summary: Requirements and guidance for information retrieval Interactions via SSP. 
---

The SSP is a content agnostic forward proxy, which is used to control and protect access to health systems. It provides a single security point for both authentication and authorisation for systems. See the [SSP specification]( https://developer.nhs.uk/apis/spine-core/ssp_overview.html) for more details.

Information retrieval is an interaction between the a consumer and a provider, but sending the request via the SSP means that the consumer and provider do not need to have knowledge of each others authentication and authorisation mechanisms, as this is done by the SSP for both the consumer and the provider.


## End-to-End Retrieval Process

The following diagram describes how information retrieval is facilitated through the SSP using the URL included in the pointer.

[
    ![Retrieval solution end-to-end](images/retrieval/retrieval_concept_diagram.png)
](images/retrieval/retrieval_concept_diagram.png){:target="_blank"}

The diagram above depicts the step-by-step, end-to-end, process for retrieving information, as follows: 
1. Consumer system queries the NRL to see if any pointers exist for the patient.
2. Consumer system finds a pointer that references information which could be of value for the provision of care.
3. Consumer system takes the URL property value from that pointer and uses this value to create a request to the provider system that holds the information.
4. Consumer system sends the request to the provider system via the SSP.
5. The SSP performs security checks against the consumer and provider.
6. Request is sent onto the provider system.
7. Provider system receives and validates the request.
8. Provider system returns the requested information back to the consumer via the SSP.
9. Consumer system receives the information and processes it ready to display to the end user.


## Requesting information via the SSP

Endpoints which allow retrieval of information via the SSP MUST do so with the [HTTPS GET](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3) request, to the URL contained within the NRL pointer.

The provider endpoint **MUST NOT** require any additional parameters to be passed with the request.

For a consumer to retrieve information via the SSP, the consumer MUST percent encode the `content.attachment.url` property from the NRL pointer and prefix it with the SSP server URL as follows:

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

The consumer and the provider's endpoint MUST support the following HTTP request headers:

| Headers | Value |
| --- | --- |
| `Authorization` | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the Spine - see [Development Overview](development_overview.html) page for details. |
|`Ssp-TraceID`|Consumer's TraceID (i.e. GUID/UUID), a unique identifier provided by the consumer. |
|`Ssp-From`|Consumer's ASID, a unique identifier for the consuming system.<br/><br/>The consumer will be given an ASID by NHS Digital when connecting to the Spine. |
|`Ssp-To`|Provider's ASID<br/><br/>Consumers MUST include the provider ASID in the `SSP-To` HTTP Header when performing a retrieval request via the SSP.<br/><br/>The provider ASID can be obtained through performing a [Spine Directory Services (SDS)](https://developer.nhs.uk/apis/spine-core-1-0/build_directory.html) lookup. This can be done using the record author ODS code, which is included in the pointer metadata, and the interaction ID `urn:nhs:names:services:nrl:DocumentReference.content`.<br/><br/>A worked example of the endpoint look-up process can be found in the [Spine Core specification](https://developer.nhs.uk/apis/spine-core-1-0/build_endpoints_example_spine_fhir.html).<br/><br/>If multiple ASIDs are found for the ODS code and interaction ID, the associated FQDN can be matched to the record URL FQDN to obtain the correct ASID.|
|`Ssp-InteractionID`|Spine's Interaction ID.<br><br>The interaction ID for retrieving a record referenced in an NRL pointer is specific to the NRL service and is as follows:<br><br>`urn:nhs:names:services:nrl:DocumentReference.content.read`|

For more information on the SSP required headers, please refer to the [Spine Secure Proxy Implementation Guide](https://developer.nhs.uk/apis/spine-core-1-0/ssp_overview.html) for full technical details.

The provider endpoint **MUST NOT** require any additional custom headers.


### Response

Success:

- MUST return a `200` **SUCCESS** HTTP status code on successful execution of the interaction.
- MUST return a response body containing the requested information in the format described in the format metadata attributes on the pointer. See [Supported Formats](retrieval_overview.html) for more details.

Failure: 
- MUST return an error type HTTP status code
- SHOULD return a response body with diagnostic details.


## Authentication and Authorisation

Systems that interact with the SSP MUST meet the secure connection requirements of the SSP.

Consumer systems MUST ensure that users are authenticated and authorised, using an appropriate access control mechanism, before retrieving information. HTTPS requests to the SSP for retrieving records and documents will include an access token (JWT), which can be used in Provider systems for auditing purposes. Providers are not required to perform any further authentication or authorisation.

More details can be found on the [NRL Security Guidance](security_guidance.html) page.
