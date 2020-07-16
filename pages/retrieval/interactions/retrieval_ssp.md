---
title: SSP Retrieval Interactions
keywords: structured rest documentreference
tags: [for_consumers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_ssp.html
summary: Requirements and guidance for record and document retrieval Interactions via SSP. 
---

The SSP is a content agnostic forward proxy, which is used to control and protect access to health systems. It provides a single security point for both authentication and authorisation for systems. See the [SSP specification]( https://developer.nhs.uk/apis/spine-core/ssp_overview.html) for more details.

Documents and records can be retrieved directly from the Providers that hold the documents/records. This is achieved by using the location information (record URL/endpoint) stored on a pointer (obtained from a pointer search) and sending a request to this location over HTTP(S) via the Spine Secure Proxy (SSP).


## Requests via the SSP

Where a document/record is to be retrieved via the SSP, the Consumer MUST percent encode the `content.attachment.url` property, taken from an NRL pointer, and prefix it with the SSP server URL. For more details, see the [Retrieval Read](retrieval_interaction_read.html#retrieval-via-the-ssp) interaction page.

## Provider ASID

Consumers MUST include the provider ASID in the SSP-To HTTP Header when performing a retrieval request via the SSP.

The provider ASID can be obtained through performing a [Spine Directory Services (SDS)](https://developer.nhs.uk/apis/spine-core-1-0/build_directory.html) lookup. This can be done using the record author ODS code, which is included in the pointer metadata, and the interaction ID `urn:nhs:names:services:nrl:DocumentReference.content`.

A worked example of the endpoint look-up process can be found in the [Spine Core specification](https://developer.nhs.uk/apis/spine-core-1-0/build_endpoints_example_spine_fhir.html).

If multiple ASIDs are found for the ODS code and interaction ID, the associated FQDN can be matched to the record URL FQDN to obtain the correct ASID.



## End-to-End Retrieval Process

The following diagram describes how information retrieval is facilitated through the SSP using the Record URL stored on the pointer.

[
    ![Retrieval solution end-to-end](images/retrieval/retrieval_concept_diagram.png)<br><br>
    Click to view the diagram at full size.
](images/retrieval/retrieval_concept_diagram.png){:target="_blank"}

As the diagram depicts, the step-by-step process end-to-end for retrieving a record or document is as follows: 
1. Consumer system queries the NRL to see if any Pointers exist for the patient under their care.
2. Consumer system finds a Pointer that references a record which could be of value for the provision of care.
3. Consumer system takes the URL property value (see [Pointer Data Model](overview_data_model.html) for details) from the Pointer that was found and uses this value to create a request to the Provider system that holds the record.

   The URL property is prefixed with the URL to the SSP, which will ensure that the request goes via the SSP and that all necessary security checks are performed on the request. The SSP base url prefix is added by the Consumer system. For more details, see the [Retrieval Read](retrieval_interaction_read.html#retrieval-via-the-ssp) interaction page.

   {% include note.html content="The URL property should be fully [percent encoded per RFC 3986](https://tools.ietf.org/html/rfc3986#section-2.1) to prevent any possibility of parsing errors." %}

   An example SSP-prefixed URL:

   ```
   https://testspineproxy.nhs.uk/https%3A%2F%2Fprovider.thirdparty.nhs.uk%2FAB1%2FStatic%2Fc1cd026e-e06b-4121-bb08-a3cb8f53c58b
   ```

4. Consumer [system] sends the request to the Provider system.
5. Request sent by the Consumer goes through the SSP, where security checks are performed.
6. Request is then sent onto the Provider system that holds the record once security checks are passed.
7. Provider system receives and validates the request.
8. Provider system sends the requested record back to the Consumer, via the SSP.
9. Consumer [system] receives the record and processes it ready to display to the end user.

## Read Request

Retrieval of a referenced record is done through an [HTTP(S) GET](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3) request to the record URL contained on the pointer.

Retrieval requests should be made through the Spine Secure Proxy (SSP). An exception is made for retrieving publicly accessible contact details (format "Contact Details (HTTP Unsecured)"), for which requests should be made directly.

Consumer and Provider retrieval HTTP requests support the following HTTP request headers:

| Header(s)               | Value |Conformance |
|----------------------|-------|-------|
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the Spine - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details. | REQUIRED |
| SSP Headers          | See below for details |  |

Requests SHOULD NOT require any additional custom headers.

Requests SHOULD NOT require any additional parameters to be passed in the URL.

## Read Response

Success:

- MUST return a `200` **SUCCESS** HTTP status code on successful execution of the interaction.
- MUST return a response body containing the requested record/document in the format described in the format metadata attributes on the pointer. See [Retrieval Formats](retrieval_formats.html) for more details.

Failure: 
- MUST return an error type HTTP status code
- SHOULD return a response body with diagnostic details.

## Retrieval via the SSP

The role of the SSP in retrieval of documents/records is to be a single common authentication and authorisation gateway for all Consumers and Providers.

Retrieval requests via proxy are secured and audited by the SSP. For full technical details, see the [SSP specification](https://developer.nhs.uk/apis/spine-core-1-0/ssp_overview.html).

### SSP URL

Where a document/record is to be retrieved via the SSP then Consumers MUST percent encode the `content.attachment.url` property and prefix it with the SSP server URL as follows:

<div markdown="span" class="alert alert-success" role="alert">
`GET https://[proxy_server]/[percent_encoded_record_url]`
</div>

For example:

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">GET https://[proxy_server]/https%3A%2F%2Fp1.nhs.uk%2FMentalHealthCrisisPlans%2Fda2b6e8a-3c8f-11e8-baae-6c3be5a609f5
</span></code></pre>
</div>

This request would fetch a Mental Health Crisis Plan with the logical id of `da2b6e8a-3c8f-11e8-baae-6c3be5a609f5` from a Provider system located at `https://p1.nhs.uk` via the Spine Secure Proxy.

{% include note.html content="When creating Pointers, Providers MUST NOT prefix the Pointer URL property with the SSP server URL and MUST NOT percent encode it. In other words, Consumers are fully responsible for constructing the Spine proxy URL from the Pointer URL." %}

### SSP Headers

The HTTP GET request MUST include a number of Spine-specific HTTP headers:

|Header|Value|
|------------------|---------------------------|
|`Ssp-TraceID`|Consumer's TraceID (i.e. GUID/UUID)|
|`Ssp-From`|Consumer's ASID|
|`Ssp-To`|Provider's ASID|
|`Ssp-InteractionID`|Spine's Interaction ID.<br><br>The interaction ID for retrieving a record referenced in an NRL pointer is specific to the NRL service and is as follows:<br><br>`urn:nhs:names:services:nrl:DocumentReference.content.read`|

Please refer to the [Spine Secure Proxy Implementation Guide](https://developer.nhs.uk/apis/spine-core-1-0/ssp_overview.html) for full technical details.

Guidance on obtaining the provider ASID can be found on the [Consumer Guidance](retrieval_consumer_guidance.html#interaction-id) page.

## Authentication and Authorisation

Systems that interact with the SSP MUST meet the secure connection requirements of the SSP.

Consumer systems MUST ensure that users are authenticated and authorised, using an appropriate access control mechanism, before retrieving records and documents. HTTP(S) requests to the SSP for retrieving records and documents will include an access token (JWT), which can be used in Provider systems for auditing purposes. Providers are not required to perform any further authentication or authorisation.

More details can be found on the [Authentication &amp; Authorisation](integration_authentication_authorisation.html) page.
