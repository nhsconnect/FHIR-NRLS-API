---
title: API Read Interaction
keywords: structured rest documentreference
tags: [fhir,pointers,for_consumers]
sidebar: overview_sidebar
permalink: api_interaction_read.html
summary: To support the retrieval of an NRL pointer.
---

{% include custom/fhir.reference.nonecc.html NHSDProfiles="[NRL-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1), [Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1)" HL7Profiles="-" %}

## Read

Consumer interaction to support the retrieval of a single NRL pointer. The `read` interaction is a FHIR RESTful [read](https://www.hl7.org/fhir/STU3/http.html#read) interaction.

## Prerequisites

In addition to the requirements on this page, the general guidance and requirements detailed on the [NRL interaction overview](nrl_interaction_overview.html) page **MUST** be followed when using this interaction.

## Read Request Headers

The `read` interaction supports the following HTTP request headers:

| Header|Value|Conformance|
|-------|-----|-----------|
| `Accept` | The `Accept` header indicates the format of the response the client is able to understand, if set, this must be either `application/fhir+json` or `application/fhir+xml`. | OPTIONAL |
| `Authorization` | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](guidance_jwt.html) page for details. | REQUIRED |
| `fromASID` | Client System ASID. | REQUIRED |
| `toASID` | The Spine ASID. | REQUIRED |

## Read Operation

The `read` interaction allows a consumer to retrieve a single pointer (`DocumentReference`) by logical ID.

The consumer **MUST**:
- Use the supported method of pointer identification (logical ID):
    - The logical ID can be obtained from the `Location` header returned in a `create` interaction [response](api_interaction_create.html#create-response).
    - Example:
        <div markdown="span" class="alert alert-success" role="alert">
        `GET [baseUrl]/STU3/DocumentReference/[id]`
        </div>

        <div class="language-http highlighter-rouge">
        <pre class="highlight">
        <code><span class="err">GET [baseUrl]/STU3/DocumentReference/da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
        </span></code>
        Read the DocumentReference resource for a pointer with the logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'.</pre>
        </div>
- submit the request to the NRL using the FHIR RESTful [read](https://www.hl7.org/fhir/stu3/http.html#read) interaction.

{% include note.html content="Only pointers that have a status of `current` can be retrieved." %}

## Response

### Success

A successful execution of the `read` interaction will return:

- a `200` **OK** HTTP status code.
- a response body containing a `DocumentReference` resource which conforms to the [NRL-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1) FHIR resource and has a `current` status.

#### Example Success Response

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
