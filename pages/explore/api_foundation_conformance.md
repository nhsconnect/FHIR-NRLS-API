---
title: Capability Statement
keywords: foundations fhir
tags: [fhir]
sidebar: accessrecord_rest_sidebar
search: exclude # TODO
permalink: api_foundation_conformance.html
summary: A capability statement is a set of capabilities of a FHIR Server that may be used as a statement of actual server functionality or a statement of required or desired server implementation.
---

{% include custom/fhir.referencemin.html resource="" page="" fhirlink="[CapabilityStatement](http://www.hl7.org/fhir/STU3/capabilitystatement.html)" content="User Stories" userlink="" %}

## 1. Capabilities

API to support getting the NRL server capability statement.

<!--Alternatively, an HTTP OPTIONS request against the root of the FHIR server will also return the conformance profile:-->

<!--<div markdown="span" class="alert alert-success" role="alert">-
`OPTIONS [baseUrl]/`
</div>-->

### 1.1 Capabilities Request Headers

The Capabilities Interaction supports the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand. This will be one of <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | OPTIONAL |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details. |  REQUIRED |
| `fromASID`           | Client System ASID | REQUIRED |
| `toASID`             | The Spine ASID | REQUIRED |

<!--
| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | OPTIONAL |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Cross Organisation Audit and Provenance](integration_cross_organisation_audit_and_provenance.html) for details. | REQUIRED |
| `Ssp-TraceID`        | Client System TraceID (i.e. GUID/UUID). This is a unique ID that the client system should provide. It can be used to identify specific requests when troubleshooting issues with API calls. All calls into the service should have a unique TraceID so they can be uniquely identified later if required. | REQUIRED |
| `Ssp-From`           | Client System ASID | REQUIRED |
| `Ssp-To`             | The Spine ASID | REQUIRED |
| `Ssp-InteractionID`  | `urn:nhs:names:services:nrls:fhir:rest:read:metadata`| REQUIRED |
| `Ssp-Version`  | `1` | REQUIRED |

Note: The Ssp-Version defaults to 1 if not supplied (this is currently the only version of the API). This indicates the major version of the interaction, so when new major releases of this specification are released (for example releases with breaking changes), implementors will need to specify the correct version in this header.
-->

### 1.2 Capabilities Interaction (Get the NRL CapabilityStatement)

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/metadata`
</div>

The `/metadata` path on the root of the NRL FHIR server will return the capability statement for the FHIR server.

For details of this interaction - see [HL7 FHIR STU3 RESTful API](https://www.hl7.org/fhir/STU3/http.html#capabilities).

<!--All requests MUST contain a valid <code class="highlighter-rouge">Authorization</code> header and MAY contain an <code class="highlighter-rouge">Accept</code> header with at least one of the following: <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>.-->

### 1.3 Capabilities Response

Success:

<ul>
  <li>MUST return a <code class="highlighter-rouge">200</code> <strong>OK</strong> HTTP status code on successful retrieval of the capability statement.</li>
  <li>MUST return a capability statement which conforms to the standard <a href="http://hl7.org/fhir/STU3/capabilitystatement.html">FHIR CapabilityStatement</a>
</li>
</ul>

Error Handling:

<p>The NRL Server is expected to always be able to return a valid capability statement.</p>

## 2. Example

### 2.1 Capabilities Request Query

Retrieve the capability statement from the NRL Server, the format of the response body will be xml. 

#### 2.1.1. cURL

{% include custom/embedcurl.html title="Read Server Capability Statement" command="curl -H 'Accept: application/fhir+xml' -H 'Authorization: BEARER [token]' -X GET '[baseUrl]/metadata'" %}

{% include custom/search.response.headers.html resource="Conformance"  %}

<h4 id="32-response-headers">2.2.2 Response Body</h4>

<!--### 2.2.2 Response Body ###-->

<p>An example NRL CapabilityStatement of kind <code class="highlighter-rouge">Requirements</code> is shown below:</p>

<script src="https://gist.github.com/swk003/2961c7f768ff4ddc44c483fb6ac80833.js"></script>

<!--<script src="https://gist.github.com/IOPS-DEV/873579911893ce480f15393917812587.js"></script>-->

### 2.3 C#

{% include tip.html content="C# code snippets utilise Ewout Kramer's [fhir-net-api](https://github.com/ewoutkramer/fhir-net-api) library which is the official .NET API for HL7&reg; FHIR&reg;." %}

```csharp
var client = new FhirClient("http://[fhir_base]/");
client.PreferredFormat = ResourceFormat.Json;
var resource = client.CapabilityStatement();
FhirSerializer.SerializeResourceToXml(resource).Dump();
```
