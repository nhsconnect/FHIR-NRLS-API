---
title: API Read Interaction
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_read.html
summary: To support retrieval of an NRL pointer
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Read ##

API to support the retrieval of a single NRL pointer. This functionality is available for consumers and providers.

## Read Request Headers ##

Consumer and Provider API read requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |


## Read Operation ##

The read interaction allows a consumer or provider to retrieve a single pointer (DocumentReference) by logical ID. The consumer or provider must issue an HTTP GET as shown:

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference/[id]</div>

Note the status of the pointer must be "current" for the pointer to be retrieved. 

## Read Response ##

Success:

- SHALL return a `200` **SUCCESS** HTTP status code on successful execution of the interaction.
- SHALL return a response body containing a DocumentReference resource which conforms to the ['NRL-DocumentReference-1'](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1) profile and has the status "current".

{% include note.html content="Where a DocumentReference content.format property indicates the referenced resource should be retrieved via the SSP the NRL will automatically pre-fix the content.attachment.url property with the SSP server url. For further detail, see [Retrieval Formats](retrieval_formats.html)." %}

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
- [Resource Not Found](development_general_api_guidance.html#resource-not-found)
- [Inactive Document Reference](development_general_api_guidance.html#inactive-documentreference)

## Example Scenario ##

An authorised NRL Consumer retrieves a pointer to patient's relevant health record using the NRL to discover potentially vital information to support a patient's emergency crisis care.

### Request Query ###

Return DocumentReference resource (pointer) with logical ID 0353e505-f7be-4c20-8f4e-337e79a32c51-76009894321256642261. The format of the response body will be XML. 

#### cURL ####

{% include custom/embedcurl.html title="Read DocumentReference" command="curl -H 'Accept: application/fhir+xml' -H 'Authorization: BEARER [token]' -X GET  '[baseUrl]/DocumentReference/0353e505-f7be-4c20-8f4e-337e79a32c51-76009894321256642261'" %}

#### Query Response Http Headers ####

```
{% include /examples/search_response_headers %}
```

#### Query Response ####

##### **Pointer (DocumentReference) Returned:** ##### 

- HTTP 200-Request was successfully executed
- DocumentReference that conforms to the `NRL-DocumentReference-1` profile.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/read_response.xml %}
{% endhighlight %}
</div>

##### **No Record (pointer) Matched:** ##### 

- HTTP 404-Not Found. No record found.
- OperationOutcome resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/read_response_error_not_found.xml %}
{% endhighlight %}
</div>

##### **Error Response (OperationOutcome) Returned:** ##### 

- HTTP 400-Bad Request.  
- OperationOutcome resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) profile if the resource cannot be returned

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/read_response_error_status_not_current.xml %}
{% endhighlight %}
</div>

See the [general API guidance](development_general_api_guidance.html#error-handling) for all HTTP Error response codes supported by the NRL.