---
title: API Read Interaction
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_read.html
summary: To support the creation of NRL pointers
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Read ##

API to support the retrieval of a single NRL pointer. This functionality is available for consumers and providers.

## Read Request Headers ##

Provider API read requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |


## Read Operation ##

The read interaction allows a consumer or provider to retrieve a single pointer (DocumentReference) by logical ID. The consumer or provider must issue an HTTP GET as shown:

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference/[id]</div>

## Read Response ##

Success:

- SHALL return a `201` **CREATED** HTTP status code on successful execution of the interaction and the entry has been successfully created in the NRL.
- SHALL return a response body containing a DocumentReference resource which conforms to the ['NRLS-DocumentReference-1'](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1) profile. 

Example Successful Response:

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/read_response.xml %}
{% endhighlight %}
</div>

Failure: 

The following errors can be triggered when performing this operation:

- [Invalid Request Message](development_general_api_guidance.html#invalid-request-message)
- [Invalid Parameter](development_general_api_guidance.html#parameters)
- [Resource not found](development_general_api_guidance.html#resource-not-found)
