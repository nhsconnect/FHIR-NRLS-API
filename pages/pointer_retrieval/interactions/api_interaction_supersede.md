---
title: API Supersede Interaction
keywords: structured supersede rest documentreference
tags: [fhir,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_supersede.html
summary: To support the superseding of NRL pointers.
---

{% include custom/fhir.reference.nonecc.html resource="NRL-DocumentReference-1" resourceurl="https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Create (Supersede)

Provider interaction to support superseding NRL pointers. Create with Supersede (abbreviated to Supersede) is an extension of the [Create Interaction](api_interaction_create.html). The Supersede functionality will be used in cases where a provider wishes to replace one `DocumentReference` with another, newer one.

## Prerequisites

In addition to the requirements on this page the general guidance and requirements detailed on the [pointer retrieval overview](pointer_retrieval_overview.html) page MUST be followed when using this interaction.

## Supersede Request Headers

Provider API supersede requests support the following HTTP request headers:

|Header|Value|Conformance|
|------|-----|-----------|
| `Accept` | The `Accept` header indicates the format of the response the client is able to understand, if set, this must be either `application/fhir+json` or `application/fhir+xml`. | OPTIONAL |
| `Authorization` | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see the [JSON Web Token Guidance](guidance_jwt.html) page for details. | REQUIRED |
| `fromASID` | Client System ASID. | REQUIRED |
| `toASID` | The Spine ASID. | REQUIRED |

## Supersede Operation

The NRL API does not allow a traditional Update operation (the HTTP `PUT` verb is not supported). Instead, a pointer can be replaced by superseding it with a newer version that contains the updated attributes.

A provider transitions an existing pointer's status from `current` to `superseded` as part of the act of creating its replacement. The create action allows specifying an existing `DocumentReference` to be superseded. The process is as follows:

1. The provider assembles a new `DocumentReference` resource.
2. The provider populates the `relatesTo` property with a new target element which holds:
   - A reference that is the logical identifier of the existing `DocumentReference` or an identifier that is the master identifier of the existing `DocumentReference`.
   - The action code `replaces`.
3. The provider POSTs the `DocumentReference` resource.
4. The NRL will transactionally:
   1. Create the new `DocumentReference`, marking it as `current`.
   2. Resolve the existing `DocumentReference` using `relatesTo.target`.
   3. Mark the original `DocumentReference` as `superseded` and increment its `versionId` by 1.
   4. Set the version number of the newly-created `DocumentReference` to 1.

Provider systems **MUST** only supersede pointers for records where they are the pointer owner (custodian).

The target property within the `relatesTo` attribute must be either a reference or a FHIR identifier, depending on whether a provider chooses to supersede by logical ID or master identifier.

{% include note.html content="NRL supports the ability to update a pointer's status from &quot;current&quot; to &quot;entered-in-error&quot; using the HTTP PATCH verb. For more details, see the [Update Interaction](api_interaction_update.html) page." %}

## Supersede by Logical ID

To supersede by logical ID, the `relatesTo.target` attribute on the `DocumentReference` should be a FHIR reference property i.e. an absolute literal reference to a `DocumentReference` held within NRL.

Example of a `DocumentReference.relatesTo` property populated using a FHIR reference.

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/relatesTo_reference.json %}
{% endhighlight %}
</div>

## Supersede by Master Identifier

To supersede by master identifier, the `relatesTo.target` attribute on the `DocumentReference` should be a FHIR identifier. The identifier is interpreted as the masterIdentifier of a `DocumentReference` held within the NRL.

Example of a `DocumentReference.relatesTo` property populated using a FHIR identifier.

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/relatesTo_identifier.json %}
{% endhighlight %}
</div>

In both cases, the patient NHS Number on the new (to be created) `DocumentReference` and the `DocumentReference` being superseded must match.

If both `target.reference` and `target.identifier` properties are populated then the NRL will use the `target.reference property` to resolve the `DocumentReference`. If a `DocumentReference` is found, then the master identifier of the returned `DocumentReference` must match the identifier in the `relatesTo` collection.

The NRL will only accept **one** `relatesTo` element. Requests that contain multiple `relatesTo` elements will be rejected.

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

As an extension of the Create interaction, the success and failure responses are the same for Supersede as they are for Create. See [Create Interaction - Responses](api_interaction_create.html#create-response) for details of the expected response behaviours and codes.

## Explore the NRL
You can explore and test the Create (Supersede) interaction using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).
