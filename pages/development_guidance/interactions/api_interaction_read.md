---
title: API Read Interaction
keywords: structured rest documentreference
tags: [fhir,pointers,for_consumers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_read.html
summary: To support the retrieval of an NRL pointer.
---

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Read

Consumer interaction to support the retrieval of a single NRL pointer. The read interaction is a FHIR RESTful [read](https://www.hl7.org/fhir/STU3/http.html#read) interaction.

## Prerequisites

In addition to the requirements on this page, the general guidance and requirements detailed on the [Development Overview](development_overview.html) page **MUST** be followed when using this interaction.

## Read Request Headers

Consumer API read requests support the following HTTP request headers:

| Header|Value|Conformance|
|-------|-----|-----------|
| `Accept` | The `Accept` header indicates the format of the response the client is able to understand, if set, this must be either `application/fhir+json` or `application/fhir+xml`. | OPTIONAL |
| `Authorization` | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](guidance_jwt.html) page for details. | REQUIRED |
| `fromASID` | Client System ASID. | REQUIRED |
| `toASID` | The Spine ASID. | REQUIRED |

## Read Operation

The read interaction allows a consumer to retrieve a single pointer (DocumentReference) by logical ID.

The consumer must issue an HTTP GET as shown:

<div markdown="span" class="alert alert-success" role="alert">
`GET [baseUrl]/STU3/DocumentReference/[id]`
</div>

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">GET [baseUrl]/STU3/DocumentReference/da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Read the DocumentReference resource for a pointer with the logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'.</pre>
</div>

Note the status of the pointer must be `current` for the pointer to be retrieved.

## Read Response

### Success

A successful execution of the read interaction will:

- return a `200` **OK** HTTP status code.
- return a response body containing a `DocumentReference` resource which conforms to the [NRL-DocumentReference-1 FHIR profile](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1) and has the status `current`.

<!--
{% include note.html content="When a document/record is to be retrieved via the SSP then the consumer **MUST** percent encode the `content.attachment.url` property, taken from an NRL pointer, and prefix it with the SSP server URL. For more details, see the [Retrieval Read](retrieval_interaction_read.html#retrieval-via-the-ssp) interaction page." %}
-->

Example Successful Response:

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/read_response.xml %}
{% endhighlight %}
</div>

### Failure

The following errors can be triggered when performing this operation:

- [Invalid Request Message](guidance_errors.html#invalid-request-message)
- [Invalid Parameter](guidance_errors.html#parameters)
- [Resource Not Found](guidance_errors.html#resource-not-found)
- [Inactive DocumentReference](guidance_errors.html#inactive-documentreference)

## Explore the NRL
You can explore and test the read interaction using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).
