---
title: General API guidance
keywords: fhir development
tags: [fhir,development]
sidebar: overview_sidebar
permalink: development_general_api_guidance.html
summary: "Implementation guidance for developers - focusing on general API implementation guidance"
---

## Purpose ##

This implementation guide is intended for use by software developers looking to build a conformant NRLS API interface using the FHIR&reg; standard with a focus on general API implementation guidance.

### Notational conventions ###

The keywords ‘**MUST**’, ‘**MUST NOT**’, ‘**REQUIRED**’, ‘**SHALL**’, ‘**SHALL NOT**’, ‘**SHOULD**’, ‘**SHOULD NOT**’, ‘**RECOMMENDED**’, ‘**MAY**’, and ‘**OPTIONAL**’ in this implementation guide are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).


<!--
## Maturity roadmap ##

At a high level, the maturity roadmap of a compliant principal GP system is expected to follow the following FHIR and business capability maturity stages.

Refer to [Design - design principles - maturity model](designprinciples_maturity_model.html) for full details.

## General standards ##

Information on the technical standards that SHALL be conformed to can be found in the sections below and throughout the GP Connect specification.

{% include important.html content="Any additional principles highlighted in the GP Connect specification MUST take precedence over those defined in these technical standards." %}

## Internet standards ##

Clients and servers SHALL be conformant to the following Internet Engineering Task Force (IETF) request for comments (RFCs), which are the principal technical standards that underpin the design and development of the internet and thus FHIR's APIs.

- transport level integration SHALL be via HTTP as defined in the following RFCs: [RFC 7230](https://tools.ietf.org/html/rfc7230), [RFC 7231](https://tools.ietf.org/html/rfc7231), [RFC 7232](https://tools.ietf.org/html/rfc7232), [RFC 7233](https://tools.ietf.org/html/rfc7233), [RFC 7234](https://tools.ietf.org/html/rfc7234) and [RFC 7235](https://tools.ietf.org/html/rfc7235)
- transport level security SHALL be via TLS/HTTPS as defined in [RFC 5246](https://tools.ietf.org/html/rfc5246) and [RFC 6176](https://tools.ietf.org/html/rfc6176)
- HTTP Strict Transport Security (HSTS) as defined in [RFC 6797](https://tools.ietf.org/html/rfcy 6797) SHALL be employed to protect against protocol downgrade attacks and cookie hijacking

{% include roadmap.html content="NHS Digital is currently evaluating how [cross-origin resource sharing](http://www.w3.org/TR/cors/) (CORS) will be handled for web and mobile based applications." %}

## Endpoint resolution ##

Clients SHALL perform a sequence of query operations against existing Spine services to enable FHIR endpoint resolution.

1. Clients SHALL perform (or have previously performed) a Personal Demographics Service (PDS) lookup for a patient.
	1. Using the PDS results, the client SHALL determine the patient's primary GP organisation. 
2. Clients SHALL perform (or have previously performed) a Spine Directory Service (SDS) lookup using the Organisation Data Service (ODS) code of the patient's primary GP organisation.
	1. Using the SDS results the client SHALL determine the principal GP system responsible for hosting the most up to date GP care record.
		1. [EMIS Health](http://www.emishealth.com/)
		2. [INPS](http://www.inps.co.uk/)
		3. [Microtest](http://www.microtest.co.uk/)
		4. [TPP](http://www.tpp-uk.com/)
2. Clients SHALL construct a [FHIR service root URL](#ServiceRootURL) suitable for access to a GP vendor's FHIR server. For GP Connect, access to the principal GP systems will be via the [Spine Security Proxy](#SpineSecurityProxy) (SSP) and as such the URL will need to be pre-pended with a proxy service root URL.

{% include tip.html content="Where a practitioner (with a valid SDS user ID) or organisation (with a valid ODS code) record already exists within the local system, the details associated with these existing records may be used for display purposes." %}
-->

## RESTful API ##

<!--
The [RESTful API](https://www.hl7.org/fhir/STU3/http.html) described in the FHIR&reg; standard is built on top of the Hypertext Transfer Protocol (HTTP) with the same HTTP verbs (`GET`, `POST`, `PUT`, `DELETE`, and so on) commonly used by web browsers. Furthermore, FHIR exposes resources (and operations) as Uniform Resource Identifiers (URIs). For example, a `Patient` resource `/fhir/Patient/1`, can be operated upon using standard HTTP verbs such as `DELETE /fhir/Patient/1` to remove the patient record.

The FHIR RESTful API style guide defines the following URL conventions which are used throughout the remainder of this page:

- URL pattern content surrounded by **[ ]** are mandatory
- URL pattern content surrounded by **{ }** are optional

### Service root URL ###

The [service root URL](https://www.hl7.org/fhir/STU3/http.html#general) is the address where all the resources defined by this interface are found. 

The service root URL is the `[base]` portion of all FHIR APIs.

{% include important.html content="All URLs (and IDs that form part of the URL) defined by this specification are case sensitive." %}

### FHIR API Versioning ###
FHIR APIs SHALL be versioned according to [Semantic Versioning](http://semver.org/spec/v2.0.0.html) in the server's service root URL to provide a clear distinction between API versions that are incompatible (that is, contain breaking changes) versus backwards-compatible (that is, contain no breaking changes).

Provider systems are required to publish service root URLs for major versions of FHIR APIs in the Spine Directory Service in the following format:

{% include callout.html content="`https://[FQDN of FHIR Server]/[ODS_CODE]/[FHIR_VERSION_NAME]/{API_MAJOR_VERSION}/{PROVIDER_ROUTING_SEGMENT}`" %}


- `[FQDN_OF_FHIR_SERVER]` is the fully qualified domain name where traffic will be routed to the logical FHIR server for the organisation in question

- `[ODS_CODE]` is the [Organisation Data Service](https://digital.nhs.uk/organisation-data-service) code which uniquely identifies the GP practice organisation

- `[FHIR_VERSION_NAME]` refers to the textual name identifying the major FHIR version, examples being `DSTU2` and `STU3`. The FHIR version name SHALL be specified in upper case characters

- `{API_MAJOR_VERSION}` identifies the major version number of the provider API. Where the provider API version number is omitted, the major version SHALL be assumed to be 1

- `{PROVIDER_ROUTING_SEGMENT}` enables providers to differentiate between GP Connect and non-GP Connect requests (for example, via a load balancer). If included, this optional provider routing segment SHALL be static across all the provider's GP Connect API endpoints.
  
- The FHIR base URL SHALL NOT contain a trailing `/`

#### Example server root URL

The provider will publish the server root URL to Spine Directory Services as follows:

`https://provider.nhs.uk/GP0001/DSTU2/2/gpconnect`

Consumer systems are required to construct a [service root URL containing the SSP URL followed by the FHIR Server Root URL of the logical practice FHIR server](integration_spine_security_proxy.html#proxied-fhir-requests) that is suitable for interacting with the SSP service. API provider systems will be unaware of the SSP URL prefix as this will be removed prior to calling the provider API endpoint.

The consumer system would therefore issue a request to the new version of the provider FHIR API to the following URL:

`https://[ssp_fqdn]/https://provider.nhs.uk/GP0001/STU3/2`


### Resource URL ###

The [Resource URL](http://www.hl7.org/implement/standards/fhir/STU3/http.html) will be in the following format:

	VERB [base]/[type]/[id] {?_format=[mime-type]}

Clients and servers constructing URLs SHALL conform to [RFC 3986 Section 6 Appendix A](https://tools.ietf.org/html/rfc3986#appendix-A) which requires percent-encoding for a number of characters that occasionally appear in the URLs (mainly in search parameters).

### HTTP verbs ###

The following [HTTP verbs](http://hl7.org/fhir/STU3/valueset-http-verb.html) SHALL be supported to allow RESTful API interactions with the various FHIR resources:

- **GET**
- **POST**
- **PUT**
- **DELETE**

{% include tip.html content="Please see later sections for which HTTP verbs are expected to be available for specific FHIR resources." %}

<p/>

{% include roadmap.html content="In a future version of the FHIR&reg; standard, it is expected that the **PATCH** verb will also be supported." %}

#### Resource types ####

GP Connect provider systems SHALL support FHIR [resource types](http://hl7.org/fhir/STU3/resourcelist.html) as profiled within the [GP Connect FHIR Resource Definitions](http://developer.nhs.uk/downloads-data/fhir-resource-definitions-library/). 

#### Resource ID ####

This is the [logical Id](http://hl7.org/fhir/STU3/resource.html#id) of the resource which is assigned by the server responsible for storing it. The logical identity is unique within the space of all resources of the same type on the same server, is case sensitive and can be up to 64 characters long.

Once assigned, the identity SHALL never change. `logical Ids` are always opaque, and external systems need not and should not attempt to determine their internal structure.

{% include important.html content="As stated above and in the FHIR&reg; standard, `logical Ids` are opaque and other systems should not attempt to determine their structure (or rely on this structure for performing interactions). Furthermore, as they are assigned by each server responsible for storing a resource they are usually implementation specific. For example, NoSQL document stores typically preferring a GUID key (for example, 0b28be67-dfce-4bb3-a6df-0d0c7b5ab4) while a relational database stores typically preferring a integer key (for example, 2345)." %} 

For further background, refer to principles of [resource identity as described in the FHIR standard](http://www.hl7.org/implement/standards/fhir/STU3/resource.html#id)  

#### External resource resolution ####

In line with work being undertaken in other jurisdictions (see the [Argonaut Implementation Guide](http://argonautwiki.hl7.org/index.php?title=Implementation_Guide) for details) GP Connect provider systems are not expected to resolve full URLs that are external to their environment.
-->
### Content types ###

- The NRLS Server SHALL support both formal [MIME-types](https://www.hl7.org/fhir/STU3/http.html#mime-type) for FHIR resources:
  - XML: `application/fhir+xml`
  - JSON: `application/fhir+json`
  
- The NRLS Server SHALL also support DSTU2 [MIME-types](https://www.hl7.org/fhir/DSTU2/http.html#mime-type) for backwards compatibility:
  - XML: `application/xml+fhir`
  - JSON: `application/json+fhir`
  
- The NRLS Server SHALL also gracefully handle generic XML and JSON MIME types:
  - XML: `application/xml`
  - JSON: `application/json`
  - JSON: `text/json`
  
- The NRLS Server SHALL support the optional `_format` parameter in order to allow the client to specify the response format by its MIME-type. If both are present, the `_format` parameter overrides the `Accept` header value in the request.

<!--- The NRLS Server SHALL prefer the encoding specified by the `Content-Type` header if no explicit `Accept` header has been provided by a client system.-->

- If neither the `Accept` header nor the `_format` parameter are supplied by the client system the NRLS Server SHALL return data in the default format of `application/fhir+xml`.


<!--
### Wire format representations ###

Servers should support two [wire formats](https://www.hl7.org/fhir/STU3/formats.html#wire) as ways to represent resources when they are exchanged:

- Servers SHALL support [JSON](https://www.hl7.org/fhir/STU3/json.html)
- Servers SHOULD support [XML](https://www.hl7.org/fhir/STU3/xml.html)

{% include important.html content="The FHIR standard outlines specific rules for formatting XML and JSON on the wire. It is important to read and understand in full the differences between how XML and JSON are required to be represented." %}

Consumers SHALL ignore unknown extensions and elements in order to foster [forwards compatibility](https://www.hl7.org/fhir/STU3/compatibility.html#1.10.3) and declare this by setting [CapabilityStatement.acceptUnknown](https://www.hl7.org/fhir/STU3/capabilitystatement-definitions.html#CapabilityStatement.acceptUnknown) to 'both' in their capability statement.

Systems SHALL declare which format(s) they support in their CapabilityStatement. If a server receives a request for a format that it does not support, it SHALL return an HTTP status code of `415` indicating an `Unsupported Media Type`.

### Transfer encoding ###

Clients and servers SHALL support the HTTP [Transfer-Encoding](https://www.hl7.org/fhir/STU3/http.html#mime-type) header with a value of `chunked`. This indicates that the body of a HTTP response will be returned as an unspecified number of data chunks (without an explicit `Content-Length` header).

### Character encoding ###

Clients and servers SHALL support the `UTF-8` [character encoding](https://www.hl7.org/fhir/STU3/http.html#mime-type) as outlined in the FHIR standard.

> FHIR uses `UTF-8` for all request and response bodies. Since the HTTP specification (section 3.7.1) defines a default character encoding of `ISO-8859-1`, requests and responses SHALL explicitly set the character encoding to `UTF-8` using the `charset` parameter of the MIME-type in the `Content-Type` header. Requests MAY also specify this charset parameter in the `Accept` header and/or use the `Accept-Charset` header.

### Content compression ###

To improve system performances clients/servers SHALL support GZIP compression.

Compression is requested by setting the `Accept-Encoding` header to `gzip`.

{% include tip.html content="Applying content compression is key to reducing bandwidth needs and improving battery life for mobile devices." %} 

### [Inter-version compatibility](https://www.hl7.org/fhir/STU3/compatibility.html) ###

Unrecognized search criteria SHALL always be ignored. As search criteria supported in a query are echoed back as part of the search response there is no risk in ignoring unexpected search criteria.

### HTTP headers ###

#### Proxying headers ####

Additional HTTP headers SHALL be added into the HTTP request/response for allowing the proxy system to disclose information lost in the proxying process (for example, the originating IP address of a request). Typically, this information is added to proxy forwarding headers as defined in [RFC 7239](http://tools.ietf.org/html/rfc7239).

#### Cross-organisation provenance and audit headers ####

To meet auditing and provenance requirements (which are expected to be closely aligned with the IM1 requirements), clients SHALL provide an oAuth 2.0 Bearer token in the HTTP Authorization header (as outlined in [RFC 6749](http://tools.ietf.org/html/rfc6749)) in the form of a JSON Web Token (JWT) as defined in [RFC 7519](http://tools.ietf.org/html/rfc7519).

{% include tip.html content="We are using an open standard (JWT) to provide a container for the provenance and audit data for ease of transport between the consumer and provider systems. It is important to note that these tokens (for GP Connect FoT) will **not** be centrally issued and are not signed or encrypted (that is, they are constructed of plain text). There are JWT libraries available for most programming languages simplifying the generation of this data in JWT format." %}

Refer to [Integration - cross-organisation audit and provenance](integration_cross_organisation_audit_and_provenance) for full details of the JWT claims that SHALL be used for passing audit and provenance details between systems.

{% include important.html content="We have defined a small number of additional headers which are also required to be included in NHS Digital defined custom headers." %}

Clients SHALL add the following Spine proxy headers for audit and security purposes:

- `Ssp-TraceID` - TraceID (generated per request) which identifies the sender's message/interaction (for example, a GUID/UUID).
- `Ssp-From` - ASID which identifies the sender's FHIR endpoint.
- `Ssp-To` - ASID which identifies the recipient's FHIR endpoint.
- `Ssp-InteractionID` - identifies the FHIR interaction that is being performed <sup>1</sup>

<sup>1</sup> please refer to the [Development - FHIR API guidance - operation guidance](development_fhir_operation_guidance.html) for full details.

The SSP SHALL perform the following checks to authenticate client request:

- get the common name (CN) from the TLS session and compare the host name to the declared endpoint
- check that the client/sending endpoint has been registered (and accredited) to initiate the given interaction
- check that the server/receiving endpoint has been registered (and accredited) to receive/process the given interaction   

#### Caching headers ####

Providers SHALL use the following HTTP header to ensure that no intermediaries cache responses: `Cache-Control: no-store`


### [Managing Return Content](https://www.hl7.org/fhir/STU3/http.html#return) ###

Provider SHALL maintain resource state in line with the underlying system, including the state of any associated resources.

For example: 

_If the practitioner associated with a schedule is changed on the provider's system, such as when a locum is standing in for a regular doctor, this should be reflected in all associated resources to that schedule. The diagram below shows the expected change to the appointment resources for this scenario._

_When the appointment is booked, the appointment resource is associated with a slot resource and references the practitioner resource associated with the schedule in which the slot resides. If the schedule is then updated within the provider system to reflect the change of practitioner from the original doctor to a locum doctor, then the practitioner reference with the schedule will be updated. If a consumer then performs a read of the appointment the returned appointment resource should reflect the updated practitioner on the schedule._
-->

<!--[Diagram of reflection of state](images/development/Reseource Reflection of state.png)-->

<!--
Servers SHALL default to the `return=representation` behaviour (that is, returning the entire resource) for interactions that create or update resources.

Servers SHOULD honour a `return=minimal` or `return=representation` preference indicated in the `Prefer` request header, if present.

### Demographic cross-checking ###

Consumer systems SHALL compare the returned structured patient demographic data (supplied by the provider system as structured data) against the demographic data held in the consumer system.

The following data SHALL be cross-checked between consumer and returned provider data. Any differences between these fields SHALL be brought to the attention of the user.   

| Item | Resource field |
| ---- | -------------- | 
| Family name | patient.name.family |
| Given name | patient.name.given |
| Gender | patient.gender |
| Birth date | patient.birthDate |

Additionally, the following data MAY be displayed if returned from the provider to assist a visual cross-check and for safe identification, but should not be part of the automatic comparison:
* Address and postcode
* Contact (telephone, mobile, email)

All above may be redacted if patient is flagged on Spine as sensitive demographics.

### Managing resource contention ###

To facilitate the management of [resource contention](http://hl7.org/fhir/STU3/http.html#concurrency), servers SHALL always return an `ETag` header with each resource including the resource’s `versionId`:

```http
HTTP 200 OK
Date: Sat, 09 Feb 2013 16:09:50 GMT
Last-Modified: Sat, 02 Feb 2013 12:02:47 GMT
ETag: W/"23"
Content-type: application/json+fhir
```

`ETag` headers which denote resource `version Id`s SHALL be prefixed with `W/` and enclosed in quotes, for example:

```http
ETag: W/"3141"
```

Clients SHALL submit update requests with an `If-Match` header that quotes the `ETag` from the server.

```http
PUT /Patient/347 HTTP/1.1
If-Match: W/"23"
```

If the `version Id` given in the `If-Match` header does not match, the server returns a `409` **Conflict** status code instead of updating the resource.

For servers that don't persist historical versions of a resource (that is, any resource other than the currently available/latest version) then they SHALL operate in line with the guidance provided in the following [Hay on FHIR - FHIR versioning with a non-version capable back-end](https://fhirblog.com/2013/11/21/fhir-versioning-with-a-non-version-capable-back-end/) blog post. This is to ensure that GP Connect servers will be compatible with version-aware clients, even though the server itself doesn't support the retrieval of historical versions.

### Managing return errors ###

To [manage return errors](http://hl7.org/fhir/STU3/http.html#2.1.0.4), FHIR defines an [OperationOutcome](http://hl7.org/fhir/STU3/operationoutcome.html) resource that can be used to convey specific detailed processable error information. An `OperationOutcome` may be returned with any HTTP `4xx` or `5xx` response, but is not always required.
-->

## Error handling ##

The NRLS API defines numerous categories of error, each of which encapsulates a specific part of the request that is sent to the NRLS. Each type of error will be discussed in its own section below with the relevant Spine response code:
- [Not found](development_general_api_guidance.html#not-found---no_record_found) - Spine supports this behaviour when:
  - a request references a resource that cannot be resolved be it a DocumentReference, Patient or Organisation
  - a request supports an NHS Number where no Spine Clinicals record exists for that NHS Number.

<!--
	BROKEN URL
- [Access](development_general_api_guidance.html#access-access_denied) - Used to cover scenarios where a client is attempting to perform an action for which they are not authorised
-->

- [Headers](development_general_api_guidance.html#headers---missing_invalid_header) - There are a number of HTTP headers that must be supplied with any request. In addition that values associated with those headers have their own validation rules- Parameters – Certain actions against the NRLS allow a client to specify HTTP parameters. This class of error covers problems with the way that those parameters may have been presented
- [Parameters](development_general_api_guidance.html#parameters---invalid_parameter) – Certain actions against the NRLS allow a client to specify HTTP parameters. This class of error covers problems with the way that those parameters may have been presented
- [Payload business rules](development_general_api_guidance.html#payload-business-rules---invalid_resource) - Errors of this nature will arise when the request payload (DocumentReference) does not conform to the business rules associated with its use as an NRLS Pointer
- [Payload syntax](development_general_api_guidance.html#payload-syntax---message_not_well_formed) - Used to inform the client that the syntax of the request payload (DocumentReference) is invalid for example if using JSON to carry the DocumentReference then the structure of the payload may not conform to JSON notation.
- [ODS not found](development_general_api_guidance.html#payload-syntax---message_not_well_formed) - Used to inform the client that the URL being used to reference a given Organisation is invalid.
- [Invalid NHS Number](development_general_api_guidance.html#invalid_nhs_number) - Used to inform a client that the the NHS Number used in a provider pointer create or consumer search interaction is invalid.
- [Unsupported Media Type](development_general_api_guidance.html#unsupported_media_type) - Used to inform a client that requested content types are not supported by NRLS Service



### Not found - NO_RECORD_FOUND ###
There are two situations when Spine supports this behaviour:

- When a request references a resource that cannot be resolved. For example This error should be expected when a request references the [unique id](explore_reference.html#2-nrls-pointer-fhir-profile) of a DocumentReference however the id is not known to the NRLS. There are two scenarios when the NRLS Service supports this exception:
  - provider client retrieval of a DocumentReference by logical id
  - provider client request to delete a DocumentReference by logical id

- When a request supports an NHS Number where no Clinicals record exists in the Spine Clinicals data store for that NHS Number. The NRLS Service supports this exception scenario in the consumer and Provider Search API interface.

<!--
These exceptions are raised by the Spine Core common requesthandler and not the NRLS Service so are supported by the default Spine OperationOutcome [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to the default Spine valueSet [spine-response-code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0).
-->
<br/>

The below table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for these exception scenarios.


| HTTP Code | issue-severity | issue-type |  Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|404|error|not-found |NO_RECORD_FOUND|No record found|No record found for supplied DocumentReference identifier - [id]|
|404|error|not-found|NO_RECORD_FOUND|No record found|The given NHS number could not be found [nhsNumber]|



<!--
### Access - ACCESS_DENIED ###
There could be a variety of reasons as to why the client is not permitted to perform the action that they have requested:
- The client's SSL certificate is not trusted by the Spine
-->
<!--The interaction ID (Ssp-InteractionID) supplied by the client in the Ssp-From request header is valid however it has not been assigned to the ASID that the client request originated from-->

### Headers - MISSING_OR_INVALID_HEADER ###

<!--
This error will be thrown in relation to the mandatory Authorisation header. There are two main reasons as to why this error might be thrown:
- The header is missing (note that the header name is case-sensitive)
- The header is present however it's value is not valid:
  - Authorisation header is not a valid [JWT](integration_cross_organisation_audit_and_provenance.html)
  - `fromASID` is not a known ASID
  - `toASID` is not the ASID of the NRLS
-->

<!--This error will be thrown in relation to the mandatory Authorisation header. There is one reason why this error might be thrown:
- The header is missing (note that the header name is case-sensitive)-->


This error will be thrown in relation to the mandatory HTTP request headers. There are two scenarios when this error might be thrown:
- The  mandatory `fromASID` HTTP Header is missing in the request
  - The table details the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this scenario.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid| MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|fromASID HTTP Header is missing|

Note that the header name is case-sensitive


- The mandatory `toASID` HTTP Header is missing in the request
  - The table details the HTTP response code, along with the values to expect in the `OperationOutcome` in the response body for this scenario.

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|invalid| MISSING_OR_INVALID_HEADER|There is a required header missing or invalid|toASID HTTP Header is missing|

<!--
- The header is present however it's value is not valid:
  - Authorisation header is not a valid [JWT](integration_cross_organisation_audit_and_provenance.html)
  - `fromASID` is not a known ASID
  - `toASID` is not the ASID of the NRLS
-->
  <!--InteractionId – is not a valid NRLS InteractionId
  InteractionId – does not match the HTTP verb-->


### Parameters - INVALID_PARAMETER ###
This error will be raised in relation to request parameters that the client may have specified. As such this error can be raised in a variety of circumstances:

#### Subject parameter ####
When using the MANDATORY `subject` parameter the client is referring to a Patient FHIR resource by reference. Two pieces of information are needed: 
- the URL of the FHIR server that hosts the Patient resource.  If the URL of the server is not `https://demographics.spineservices.nhs.uk/STU3/Patient/` then this error will be thrown.

- an identifier for the Patient resource being referenced. The identifier must be known to the server. In addition where NHS Digital own the business identifier scheme for a given type of FHIR resource then the logical and business identifiers will be the same. In this case the NHS number of a Patient resource is both a logical and business identifier meaning that it can be specified without the need to supply the identifier scheme. If the NHS number is missing from the patient parameter then this error will be thrown.

#### Custodian parameter ####
When using the OPTIONAL `custodian` parameter the client is referring to an Organisation by a business identifier, specifically its ODS code. Two pieces of information are needed:
 - The business identifier scheme. In this case it must be `https://fhir.nhs.uk/Id/ods-organization-code`
 - The business identifier. The identifier must meet the following requirements:
   - It must be a valid ODS code. 
   - The ODS code must be an organisation that is known to the NRLS.
   - The ODS code must be in the Provider role.

#### `_format` request parameter ####
This parameter must specify one of the [mime types](development_general_api_guidance.html#restful-api) recognised by the NRLS.

#### Invalid Reference URL in Pointer Create Request ####
This error is raised during a provider create interaction. There are two exception scenarios:
- The DocumentReference in the request body specifies an incorrect URL of the FHIR server that hosts the Patient resource. 
- The DocumentReference in the request body specifies an incorrect URL of the author and custodian Organization resource. 


#### Type parameter ####
When using the MANDATORY `type` parameter the client is referring to a pointer by record type. Two pieces of information are needed: 
- the Identity of the [SNOMED URI](http://snomed.info/sct) terminology system
- the pointer record type SNOMED concept e.g. 736253002

If the search request specifies unsupported parameter values in the request, this error will be thrown. 

<!--
#### Consumer search should return 422 with error code of INVALID_PARAMETER under the following circumstances: ####
- `custodian` is considered an invalid parameter for searches by systems that only have authorised NRLS Consumer acccess rights. The reason that it's invalid is down to IG and the direct care leg relationship.

#### Provider search should return 422 with error code of INVALID_PARAMETER under the following circumstances: ####
- Providers can only pass their own ODS code in the `custodian` parameter otherwise an invalid parameter error respone will be returned. 
- Provider Pointer(s) owners are allowed to view their own pointers in bulk
-->
### Payload business rules - INVALID_RESOURCE ###
This error code may surface when creating or <!--modifying--> deleting a DocumentReference. There are a number of properties that make up the DocumentReference which have business rules associated with them. If there are problems with one or more of these properties then this error may be thrown.

#### mandatory fields ####
If one or more mandatory fields are missing then this error will be thrown. See [DocumentReference](explore_reference.html#2-nrls-pointer-fhir-profile) profile.

#### mandatory field values ####
If one or more mandatory fields are missing values then this error will be thrown. 

<!--
#### id ####
The id field is mandatory during an update. 
-->
<!--
#### custodian & author Organisations ####
These two Organisations are referenced in a DocumentReference. Therefore the references must point to a resolvable FHIR Organisation resource. If the URL being used to reference a given Organisation is invalid then this error will result. The URL must conform to the following rules:
- must be `https://directory.spineservices.nhs.uk/STU3/Organization`
- must supply a logical identifier which will be the organisation's ODS code:
  - It must be a valid ODS code. 
  - The ODS code must be an organisation that is known to the NRLS 
  - The ODS code associated with the custodian property must be in the Provider role.
-->

#### custodian ODS code ####

If the DocumentReference in the request body contains an ODS code on the custodian element that is not tied to the ASID supplied in the HTTP request header fromASID then this error will result. 



<!--
#### Attachment.url #### 
As well as being mandatory this field must also be a valid [URL](https://www.w3.org/Addressing/URL/url-spec.txt).
-->

#### Attachment.creation ####
This is an optional field but if supplied:
- must be a valid FHIR [dateTime](https://www.hl7.org/fhir/STU3/datatypes.html#dateTime) 

<!--date portion of the field must not be a date that is in the future as determined by the system date on the NRLS server-->

<!--
#### identifier ####
The action that is being performed (create or update) determines whether or not the field should be provided:
- create: no identifier should be supplied. If one is provided the NRLS server will reject the request
- update: the identifier is mandatory however it must be known to the NRLS (see RESOURCE_NOT_FOUND error)
-->

#### DocumentReference.Status ####

If the DocumentReference in the request body specifies a status code that is not supported by the required HL7 FHIR [document-reference-status](http://hl7.org/fhir/ValueSet/document-reference-status) valueset then this error will be thrown. 


#### DocumentReference.Type ####
If the DocumentReference in the request body specifies a type that is not part of the valueset defined in the [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) FHIR profile this error will be thrown. 

#### DocumentReference.Indexed ####
If the DocumentReference in the request body specifies an indexed element that is not a valid [instant](http://hl7.org/fhir/STU3/datatypes.html#instant) as per the FHIR specification this error will be thrown. 



#### Delete Request - Provider ODS Code does not match Custodian ODS Code ####
This error is raised during a provider delete interaction. There is one exception scenario:
- A provider delete pointer request contains a URL that resolves to a single DocumentReference however the custodian property does not match the ODS code in the fromASID header.



<!--
### Payload syntax - MESSAGE_NOT_WELL_FORMED ###

This kind of error will be created in response to problems with the request payload. However the kind of errors that trigger this error are distinct from those that cause the INVALID_RESOURCE error which is intended to convey a problem that relates to the business rules associated with an NRLS DocumentReference. The MESSAGE_NOT_WELL_FORMED error is triggered when there is a problem with the format of the DocumentReference Resource in terms of the XML or JSON syntax that has been used.

-->



### Payload syntax - INVALID_REQUEST_MESSAGE ###

This kind of error will be created in response to problems with the request payload. However the kind of errors that trigger this error are distinct from those that cause the INVALID_RESOURCE error which is intended to convey a problem that relates to the business rules associated with an NRLS DocumentReference. The INVALID_REQUEST_MESSAGE error is triggered when there is a problem with the format of the DocumentReference Resource in terms of the XML or JSON syntax that has been used.

<!--
The INVALID_REQUEST_MESSAGE exception is raised by the Spine Core common requesthandler and not the NRLS Service so is supported by the default Spine OperationOutcome [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to the default Spine valueSet [spine-response-code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-2-0). 
-->
The below table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for this exception scenario.


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|400|error|value| INVALID_REQUEST_MESSAGE|Invalid Request Message|Invalid Request Message|


### Custodian & Author Organisations - ORGANISATION_NOT_FOUND ###
These two Organisations are referenced in a DocumentReference. Therefore the references must point to a resolvable FHIR Organisation resource. If the URL being used to reference a given Organisation is invalid then this error will result. The URL must conform to the following rules:
- must be `https://directory.spineservices.nhs.uk/STU3/Organization`
- must supply a logical identifier which will be the organisation's ODS code:
  - It must be a valid ODS code. 
  - The ODS code must be an organisation that is known to the NRLS 
  - The ODS code associated with the custodian property must be in the Provider role.


### INVALID_NHS_NUMBER ###
Used to inform a client that the the NHS Number used in a provider pointer create or consumer search interaction is invalid.

### UNSUPPORTED_MEDIA_TYPE ###
There are three scenarios when an Unsupported Media Type business response code SHALL be returned to a client:
- Request contains an unsupported `Accept` header and an unsupported `_format` parameter.
- Request contains a supported `Accept` header and an unsupported `_format` parameter.
- Retrieval search query request parameters are valid however the URL contains an unsupported `_format` parameter value. 

These exceptions are raised by the Spine Core common requesthandler and not the NRLS Service so are supported by the default Spine OperationOutcome [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to the default Spine valueSet [spine-response-code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0). The below table summarises the HTTP response codes, along with the values to expect in the `OperationOutcome` in the response body for these exception scenarios.


| HTTP Code | issue-severity | issue-type | Details.System | Details.Code | Details.Display | Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|415|error|invalid|http://fhir.nhs.net/ValueSet/spine-response-code-1-0 | UNSUPPORTED_MEDIA_TYPE|Unsupported Media Type|Unsupported Media Type|


 
