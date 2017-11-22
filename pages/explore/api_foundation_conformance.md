---
title: Conformance | CapabilityStatement
keywords: foundations, fhir
tags: [rest,fhir,use_case,api,foundation,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_foundation_conformance.html
summary: A capability statement is a set of capabilities of a FHIR Server that may be used as a statement of actual server functionality or a statement of required or desired server implementation.
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.referencemin.html resource="" page="" fhirlink="[CapabilityStatement](http://www.http://hl7.org/fhir/STU3/capabilitystatement.html)" content="User Stories" userlink="" %}


## 1. Read ##

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/metadata</div>

The /metadata path on the root of the FHIR server will return the Capability statement for the FHIR server:

<!--Alternatively, a HTTP OPTIONS request against the root of the FHIR server will also return the conformance profile:-->

<!--<div markdown="span" class="alert alert-success" role="alert">-
OPTIONS [baseUrl]/</div>-->

For details of this interaction - see the [HL7 FHIR STU3 RESTful API](https://www.hl7.org/fhir/STU3/http.html#capabilities)

All requests SHALL contain a valid ‘Authorization’ header and SHALL contain an ‘Accept’ header with at least one of the following application/json+fhir or application/xml+fhir.

## 2. Example ##

### 2.1 Request Query ###

Retrieve the capability statement from the FHIR Server, the format of the response body will be xml. Replace 'baseUrl' with the actual base Url of the FHIR Server.

#### 2.1.1. cURL ####

{% include custom/embedcurl.html title="Read Server Capability Statement" command="curl -H 'Accept: application/xml+fhir' -H 'Authorization: BEARER [token]' -X GET '[baseUrl]/metadata'" %}

{% include custom/search.response.headers.html resource="Conformance"  %}

### 2.3 Response Body ###

{% include important.html content="The following draft capability statement will move as the implementation guide moves on." %}

```xml
TBA
```

{% include important.html content="The following draft capability statement will move as the implementation guide moves on." %}


### 2.4 C# ###

{% include tip.html content="C# code snippets utilise Ewout Kramer's [fhir-net-api](https://github.com/ewoutkramer/fhir-net-api) library which is the official .NET API for HL7&reg; FHIR&reg;." %}

```csharp
var client = new FhirClient("http://[fhir_base]/");
client.PreferredFormat = ResourceFormat.Json;
var resource = client.Conformance();
FhirSerializer.SerializeResourceToXml(resource).Dump();
```
