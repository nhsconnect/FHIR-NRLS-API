---
title: API Supersede Interaction
keywords: structured supersede rest documentreference
tags: [fhir,for_providers]
sidebar: overview_sidebar
permalink: api_interaction_supersede.html
summary: To support the superseding of NRL pointers.
---

{% include custom/fhir.reference.nonecc.html NHSDProfiles="[NRL-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1), [Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1)" HL7Profiles="-" %}

## Create (Supersede)

Provider interaction to support superseding NRL pointers. The `create with supersede` (abbreviated to `supersede`) is an extension of the [`create` interaction](api_interaction_create.html). The supersede functionality can be used in cases where a provider wishes to replace one `DocumentReference` with another, newer one.

## Prerequisites

In addition to the requirements on this page the general guidance and requirements detailed on the [NRL interaction overview](nrl_interaction_overview.html) page **MUST** be followed when using this interaction.

## Supersede Request Headers

The `supersede` interaction supports the following HTTP request headers:

|Header|Value|Conformance|
|------|-----|-----------|
| `Accept` | The `Accept` header indicates the format of the response the client is able to understand, if set, this must be either `application/fhir+json` or `application/fhir+xml`. | OPTIONAL |
| `Authorization` | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](guidance_jwt.html) page for details. | REQUIRED |
| `fromASID` | Client System ASID. | REQUIRED |
| `toASID` | The Spine ASID. | REQUIRED |

## Supersede Operation

The NRL does not allow a pointer to be modified once created; instead, if a provider wishes to modify any of the components within an existing pointer, that pointer **MUST** be replaced by superseding it with another pointer that contains the alternative attributes.

When creating the new pointer, the `supersede` interaction allows the specifying of an existing `DocumentReference` to be superseded; the identified pointer's status will transition from `current` to `superseded` at the same time its replacement is created.

{% include note.html content="Provider systems **MUST** only supersede pointers for records where they are the pointer owner (custodian). Also, the patient NHS Number on the new `DocumentReference` must match the patient NHS Number on the `DocumentReference` being superseded." %}

The provider can choose to identify the existing pointer to be superseded by either logical ID or master identifier, by populating the appropriate property within the `relatesTo` attribute.

To supersede by logical ID, the `relatesTo.target` attribute on the `DocumentReference` should be a FHIR reference property i.e. an absolute literal reference to a `DocumentReference` held within NRL, for example:

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/relatesTo_reference.json %}
{% endhighlight %}
</div>

To supersede by master identifier, the `relatesTo.target` attribute on the `DocumentReference` should be a FHIR identifier. The identifier is interpreted as the masterIdentifier of a `DocumentReference` held within the NRL, for example:

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/relatesTo_identifier.json %}
{% endhighlight %}
</div>

If both `relatesTo.target.reference` and `relatesTo.target.identifier` properties are populated, the NRL will use the `relatesTo.target.reference` property to resolve the `DocumentReference`. If a `DocumentReference` is found, the master identifier of the returned `DocumentReference` must match the identifier in the `relatesTo` collection.

{% include note.html content="The NRL will only accept **one** `relatesTo` element. Requests that contain multiple `relatesTo` elements will be rejected." %}

The process is as follows:

1. The provider assembles a new `DocumentReference` resource.
2. The provider populates the `relatesTo` property with a new target element which holds:
   - A reference that is the logical identifier of the existing `DocumentReference` or an identifier that is the master identifier of the existing `DocumentReference`.
   - The action code `replaces`.
3. The provider POSTs the `DocumentReference` resource (`supersede` interaction).
4. The NRL will, transactionally:
   1. Create the new `DocumentReference`, marking it as `current`.
   2. Resolve the existing `DocumentReference` using `relatesTo.target`.
   3. Mark the original `DocumentReference` as `superseded` and increment its `versionId` by 1.
   4. Set the version number of the newly-created `DocumentReference` to 1.

{% include note.html content="The NRL also supports the ability to update a pointer's status from `current` to `entered-in-error` using the [update](api_interaction_update.html) interaction." %}

### Supersede by Logical ID XML Example

An XML example of a `DocumentReference` resource that supersedes an existing `DocumentReference` by logical ID.

Please note the addition of the `relatesTo` property within the `DocumentReference` example below:

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/supersede_documentreference_resource_reference.xml %}
{% endhighlight %}
</div>

### Supersede by Logical ID JSON Example

A JSON example of a `DocumentReference` resource that supersedes an existing `DocumentReference` by logical ID.

Please note the addition of the `relatesTo` property within the `DocumentReference` example below:

<div class="github-sample-wrapper scroll-height-350">
{% highlight json-doc %}
{% include /examples/supersede_documentreference_resource_reference.json %}
{% endhighlight %}
</div>

### Supersede by Master Identifier XML Example

An XML example of a `DocumentReference` resource that supersedes an existing `DocumentReference` by master identifier.

Please note the addition of the `relatesTo` property within the `DocumentReference` example below:

<div class="github-sample-wrapper scroll-height-350">
{% highlight XML %}
{% include /examples/supersede_documentreference_resource_identifier.xml %}
{% endhighlight %}
</div>

### Supersede by Master Identifier JSON Example

A JSON example of a `DocumentReference` resource that supersedes an existing `DocumentReference` by master identifier.

Please note the addition of the `relatesTo` property within the `DocumentReference` example below:

<div class="github-sample-wrapper scroll-height-350">
{% highlight json-doc %}
{% include /examples/supersede_documentreference_resource_identifier.json %}
{% endhighlight %}
</div>

## Response

As the `supersede` interaction is an extension of the `create` interaction, the success and failure responses are the same. See [Create Interaction - Responses](api_interaction_create.html#create-response) for details of the expected response behaviours and codes.

## Explore the NRL
You can explore and test the `supersede` interaction using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).
