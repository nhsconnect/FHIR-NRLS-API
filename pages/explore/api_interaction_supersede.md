---
title: API Supersede Interaction
keywords: structured, update, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_supersede.html
summary: To support the update of NRLS pointers
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Supersede ##

API to support the superseding NRLS pointers. This functionality is only available for providers.
The supsersede functionality will be used in cases where a Provider wishes to deprecate the current pointer (DocumentReference) and replace it with a new version.

## Supersede Request Headers ##

Provider API supersede requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |


## Supersede Operation (Create) ##

The NRL API does not allow a true update i.e. the HTTP PUT verb is not supported. 
A pointer can be updated by superseding the pointer with a new pointer that has the updated attributes. 

A Provider transitions an existing Pointer’s status from current to superseded as part of the act of creating its replacement. In effect the POSTing of a new DocumentReference provides a means to specify an existing DocumentReference whose status should be moved to superseded. Concretely this is achieved as follows:

1.	Provider assembles a new DocumentReference resource
2.	Provider populates the relatesTo property with a new target element which holds  –
	- an identifier that is the masterIdentifier of the existing DocumentReference
	- the action code “replaces”
3.	Provider POSTs the DocumentReference resource
4.	NRLS will transactionally -
	1. create the new DocumentReference marking it as current
	2. resolve the existing DocumentReference using the relatesTo.target.identifer
	3. mark that DocumentReference as superseded

Note also that the NRL will only accept one relatesTo element. Requests that contain multiple relatesTo elements will be rejected. 

Providers systems SHALL only supersede pointers for records where they are the pointer owner (custodian).

The target property within the relatesTo attribute must be either a reference or a FHIR identifier, depending on whether a provider chooses to supersede by logical ID or supersede by master identifier. 

## Supersede by Logical ID ##

To supersede by logical ID, the relatesTo.target attribute should be a reference property i.e. an absolute literal reference to a DocumentReference held within NRL. The value should be a URL in the form of read by logical ID.

Example of a populated relatesTo property (reference) 

<!-- TODO add code example -->

## Supersede by Master Identifier ##

To supersede by master identifier, the relatesTo.target attribute should be a FHIR identifier. The Identifier is interpreted as the masterIdentifier of a DocumentReference held within NRL.

Example of a populated relatesTo property (identifier) 

<!-- TODO add code example -->

In both cases (use of reference or identifier values) the patient NHS Number on the new (to be created) DocumentReference and the DocumentReference being superseded must match.

If both the target.reference property and the target.identifier property are populated then the NRL will use the target.reference property to resolve the DocumentReference. If a DocumentReference is found, then the MasterIdentifier of the returned DocumentReference must match the identifier in the relatesTo collection.

### XML Example of a DocumentReference resource that supersedes an existing DocumentReference by Logical ID ###

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/supersede_documentreference_resource_reference.xml %}
{% highlight XML %}
{% github_sample /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/supersede_documentreference_resource_reference.xml %}
{% endhighlight %}
</div>

### JSON Example of a DocumentReference resource that supersedes an existing DocumentReference by Logical ID ###

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/supersede_documentreference_resource_reference.json %}
{% highlight json-doc %}
{% github_sample /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/supersede_documentreference_resource_reference.json %}
{% endhighlight %}
</div>

### XML Example of a DocumentReference resource that supersedes an existing DocumentReference by Master Identifier ###

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/supersede_documentreference_resource_identifier.xml %}
{% highlight XML %}
{% github_sample /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/supersede_documentreference_resource_identifier.xml %}
{% endhighlight %}
</div>

### JSON Example of a DocumentReference resource that supersedes an existing DocumentReference by Master Identifier ###

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/supersede_documentreference_resource_identifier.json %}
{% highlight json-doc %}
{% github_sample /nhsconnect/FHIR-NRLS-API/blob/phase-2/Examples/supersede_documentreference_resource_identifier.json %}
{% endhighlight %}
</div>

## Response ##

Success and Failure:

See [Create Response](api_interaction_create.html#create-response) for the response behaviour and codes.

## Code Examples ##

Code examples about updating the pointer can be found [here](api_interaction_create.html#code-examples).
