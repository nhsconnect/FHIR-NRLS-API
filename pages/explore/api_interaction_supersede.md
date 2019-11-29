---
title: API Supersede Interaction
keywords: structured supersede rest documentreference
tags: [fhir,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_supersede.html
summary: To support the superseding of NRL pointers
---

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Create (Supersede)

Provider interaction to support superseding NRL pointers. 
Create with Supersede (abbreviated to Supersede) is an extension of the [Create Interaction](api_interaction_create.html).
The Supersede functionality will be used in cases where a Provider wishes to replace one DocumentReference with another, newer one.

## Pre-requisites

In addition to the requirements on this page the general guidance and requirements detailed on the [Development Guidance](explore.html#2-pre-requisites-for-nrl-api) page MUST be followed when using this interaction.

## Supersede Request Headers

Provider API supersede requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | OPTIONAL |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details. | REQUIRED |
| `fromASID`           | Client System ASID | REQUIRED |
| `toASID`             | The Spine ASID | REQUIRED |

## Supersede Operation

The NRL API does not allow a true Update operation (the HTTP `PUT` verb is not supported).

Instead, a pointer can be replaced by superseding it with a newer version that contains the updated attributes. 

A Provider transitions an existing Pointer's status from "current" to "superseded" as part of the act of creating its replacement. The Create action allows specifying an existing DocumentReference to be superseded. The process is as follows:

1. The Provider assembles a new DocumentReference resource
2. The Provider populates the `relatesTo` property with a new target element which holds:
   - A reference that is the logical identifier of the existing DocumentReference or an identifier that is the masterIdentifier of the existing DocumentReference
   - The action code "replaces"
3. The Provider POSTs the DocumentReference resource
4. The NRL will transactionally:
   1. Create the new DocumentReference, marking it as "current"
   2. Resolve the existing DocumentReference using `relatesTo.target`
   3. Mark that DocumentReference as "superseded"
   4. Set the version number of the newly-created DocumentReference to its predecessor's version +1

Provider systems MUST only supersede pointers for records where they are the pointer owner (custodian).

The target property within the relatesTo attribute must be either a reference or a FHIR identifier, depending on whether a provider chooses to supersede by logical ID or supersede by master identifier. 

{% include note.html content="NRL supports the ability to update a pointers status from &quot;current&quot; to &quot;entered-in-error&quot; using the HTTP PATCH verb. For more details, see the [Update Interaction](api_interaction_update.html) page." %}

## Supersede by Logical ID

To supersede by logical ID, the relatesTo.target attribute on the DocumentReference should be a FHIR reference property i.e. an absolute literal reference to a DocumentReference held within NRL. The value should be a URL in the form of read by logical ID.

Example of a DocumentReference relatesTo property populated using a FHIR reference.

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/relatesTo_reference.json %}
{% endhighlight %}
</div>

## Supersede by Master Identifier

To supersede by Master identifier, the relatesTo.target attribute on the DocumentReference should be a FHIR identifier. The Identifier is interpreted as the masterIdentifier of a DocumentReference held within NRL.

Example of a DocumentReference relatesTo property populated using a FHIR identifier.

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/relatesTo_identifier.json %}
{% endhighlight %}
</div>

In both cases (use of reference or identifier values) the patient NHS Number on the new (to be created) DocumentReference and the DocumentReference being superseded must match. For more details, see [Error Handling Guidance](development_general_api_guidance.html#patient-mismatch). 

If both the target.reference property and the target.identifier property are populated then the NRL will use the target.reference property to resolve the DocumentReference. If a DocumentReference is found, then the MasterIdentifier of the returned DocumentReference must match the identifier in the relatesTo collection. For more details, see [Error Handling Guidance](development_general_api_guidance.html#masteridentifier-mismatch).

The NRL will only accept one relatesTo element. Requests that contain multiple relatesTo elements will be rejected. For more details, see [Error Handling Guidance](development_general_api_guidance.html#documentreferencerelatesto).

### Supersede by Logical ID XML example

An XML Example of a DocumentReference resource that supersedes an existing DocumentReference by Logical ID.

Please note the addition of the relatesTo property within the DocumentReference example below.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/supersede_documentreference_resource_reference.xml %}
{% endhighlight %}
</div>

### Supersede by Logical ID JSON example

A JSON Example of a DocumentReference resource that supersedes an existing DocumentReference by Logical ID.

Please note the addition of the relatesTo property within the DocumentReference example below.

<div class="github-sample-wrapper scroll-height-350">
{% highlight json-doc %}
{% include /examples/supersede_documentreference_resource_reference.json %}
{% endhighlight %}
</div>

### Supersede by Master Identifier XML example

An XML Example of a DocumentReference resource that supersedes an existing DocumentReference by Master Identifier.

Please note the addition of the relatesTo property within the DocumentReference example below.

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/supersede_documentreference_resource_identifier.xml %}
{% endhighlight %}
</div>

### Supersede by Master Identifier JSON example

A JSON Example of a DocumentReference resource that supersedes an existing DocumentReference by Master Identifier.

Please note the addition of the relatesTo property within the DocumentReference example below.

<div class="github-sample-wrapper scroll-height-350">
{% highlight json-doc %}
{% include /examples/supersede_documentreference_resource_identifier.json %}
{% endhighlight %}
</div>

## Response

Success and Failure:

As an extension of the Create interaction, the success and failure responses are the same for Supersede as they are for Create.

See [Create Interaction - Responses](api_interaction_create.html#create-response) for details of the expected response behaviours and codes.

## Code Examples

When either Creating or Superseding a Pointer, the same HTTP POST verb is used.

See [Create Interaction - Code Examples](api_interaction_create.html#code-examples) for an example of POSTing a pointer.
