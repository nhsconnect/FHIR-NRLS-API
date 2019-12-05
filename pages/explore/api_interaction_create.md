---
title: API Create Interaction
keywords: structured rest documentreference
tags: [fhir,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_create.html
summary: To support the creation of NRL pointers
---

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

## Create

Provider interaction to support the creation of NRL pointers.

## Pre-requisites

In addition to the requirements on this page the general guidance and requirements detailed on the [Development Guidance](explore.html#2-pre-requisites-for-nrl-api) page MUST be followed when using this interaction.

## Create Request Headers

Provider API create requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | OPTIONAL |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details. | REQUIRED |
| `fromASID`           | Client System ASID | REQUIRED |
| `toASID`             | The Spine ASID | REQUIRED |

## Create Operation

<div markdown="span" class="alert alert-success" role="alert">
`POST [baseUrl]/DocumentReference`
</div>

Provider systems:

- MUST construct and send a new Pointer (DocumentReference) resource that conforms to the NRL-DocumentReference-1 profile and submit this to NRL using the FHIR RESTful [create](https://www.hl7.org/fhir/http.html#create) interaction.
- MUST include the URI of the NRL-DocumentReference-1 profile StructureDefinition in the DocumentReference.meta.profile element of the DocumentReference resource.
- MUST include all of the mandatory data-elements contained in the `NRL-DocumentReference-1` profile when constructing a DocumentReference. The mandatory data-elements are detailed on the [Developer FHIR Resource](explore_reference.html#2-nrl-data-model-to-fhir-profile-mapping) page.
- MUST supply `subject`, `custodian` and `author` attributes as absolute literal references, the formats of which can be found on the [Developer FHIR Resource](explore_reference.html#6-identifiers) page.
- MUST only create pointers for records where they are the pointer owner (custodian). 

For all create requests the `custodian` ODS code in the DocumentReference resource MUST be affiliated with the `Client System ASID` value in the `fromASID` HTTP request header sent to the NRL.

### XML Example of a new DocumentReference resource (pointer)

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/create_documentreference_resource.xml  %}
{% endhighlight %}
</div>

### JSON Example of a new DocumentReference resource (pointer)
<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/create_documentreference_resource.json  %}
{% endhighlight %}
</div>

## Create Response

Success:

- MUST return a `201` **CREATED** HTTP status code on successful execution of the interaction and the entry has been successfully created in the NRL.
- MUST return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Operation Outcome'](http://hl7.org/fhir/STU3/operationoutcome.html) core FHIR resource (see the table below).
- MUST return an HTTP `Location` response header containing the full resolvable URL to the newly created 'single' DocumentReference. 
  - The URL will contain the 'server' assigned `logical Id` of the new DocumentReference resource.
  - The URL format MUST be: `https://[host]/[path]/[id]`. 
  - An example `Location` response header: 
    - `https://psis-sync.national.ncrs.nhs.uk/DocumentReference/297c3492-3b78-11e8-b333-6c3be5a609f5-54477876544511209789`
- When a resource has been created it will have a `versionId` of 1.

 

{% include note.html content="The versionId is an integer that is assigned and maintained by the NRL server. When a new DocumentReference is created the server assigns it a versionId of 1. The versionId will be incremented during an update or supersede transaction. See [API Interaction - Update](api_interaction_update.html) and [API Interaction - Supersede](api_interaction_supersede.html) for more details on these transactions.<br/><br/> The NRL server will ignore any versionId value sent by a client in a create interaction. Instead the server will ensure that the newly assigned verionId adheres to the rules laid out above. 
" %}

The table summarises the `create` interaction HTTP response code and the values expected to be conveyed in the successful response body `OperationOutcome` payload:

| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Details.Text |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|201|information|informational|RESOURCE_CREATED|New resource created | Spine message UUID |Successfully created resource DocumentReference|

{% include note.html content="Upon successful creation of a pointer the NRL Service returns in the response payload an OperationOutcome resource with the OperationOutcome.issue.details.text element populated with a Spine internal message UUID. This UUID is used to identify the client's Create transaction within Spine. A client system SHOULD reference the UUID in any calls raised with the Deployment Issues Resolution Team. The UUID will be used to retrieve log entries that relate to a specific client transaction." %}

Failure: 

The following errors can be triggered when performing this operation:

- [Invalid Request Message](development_general_api_guidance.html#invalid-request-message)
- [Invalid Resource](development_general_api_guidance.html#invalid-resource)
- [Organisation not found](development_general_api_guidance.html#organisation-not-found)
- [Invalid NHS Number](development_general_api_guidance.html#invalid-nhs-number)
- [Invalid Parameter](development_general_api_guidance.html#parameters)
- [Duplicate Resource](development_general_api_guidance.html#duplicate-resource)
- [Missing or Invalid Headers](development_general_api_guidance.html#headers)

### Ensuring that masterIdentifier is unique

The masterIdentifier should be unique within the NRL. For more information see the discussion on [Pointer identifiers](pointer_identity.html). The masterIdentifer is a [FHIR identifier](https://www.hl7.org/fhir/datatypes.html#Identifier) and for NRL the system and value properties are mandatory.

The system defines how the value is made unique. As the FHIR specification says this might be a recognised standard that describes how this uniqueness is generated.  

The NRL recommends the use of either an OID or a UUID as an Identifier in keeping with the need for the masterIdentifier value to be unique. In this case then the system MUST be "urn:ietf:rfc:3986" (see the [FHIR identifier registry](https://www.hl7.org/fhir/identifier-registry.html) for details) and the value is of the form – 

•	OID -  urn:oid:[oidValue] <br/>
•	UUID - urn:uuid:[uuidValue]

See the [example](https://www.hl7.org/fhir/datatypes-examples.html#Identifier) OID and UUID based Identifiers from the FHIR specification.

## Code Examples

### POST a Pointer with C#

The following code samples are taken from the NRL Demonstrator application which has both Consumer and Provider client implementations built in. More information about the design solution can be found
on the [NRL Demonstrator Wiki](https://github.com/nhsconnect/nrls-reference-implementation/wiki)

First we generate a base pointer request model that includes the custodian and author details, and the specific care plan attachment details that are later used to build our pointer (DocumentReference). 
These pointer values are taken from the demo crisis plan that is created for the Demonstrator Provider system.

Then we call our DocumentReference service GenerateAndCreatePointer method which will generate our pointer (DocumentReference) using the values stored in the model, build a POST command request and then start the call to the NRL API.

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/nrls-reference-implementation/blob/d6e952bd1ee53988bb8005b3a27f3fe16355b3ab/Demonstrator/Demonstrator.Services/Service/Epr/CrisisPlanService.cs#L125-L128 %}
{% highlight csharp %}
{% github_sample /nhsconnect/nrls-reference-implementation/blob/d6e952bd1ee53988bb8005b3a27f3fe16355b3ab/Demonstrator/Demonstrator.Services/Service/Epr/CrisisPlanService.cs 124 127 %}
{% endhighlight %}
</div>

<br/>
Within the DocumentReference service GenerateAndCreatePointer method we generate our pointer model and then serialise this generated model ready for posting:

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/nrls-reference-implementation/blob/d6e952bd1ee53988bb8005b3a27f3fe16355b3ab/Demonstrator/Demonstrator.NRLSAdapter/DocumentReferences/DocumentReferenceServices.cs#L53-L54 %}
{% highlight csharp %}
{% github_sample /nhsconnect/nrls-reference-implementation/blob/d6e952bd1ee53988bb8005b3a27f3fe16355b3ab/Demonstrator/Demonstrator.NRLSAdapter/DocumentReferences/DocumentReferenceServices.cs 52 53 %}
{% endhighlight %}
</div>

<br/>
<b>Calling the NRL</b><br />
Using our POST command request model we create a connection to the NRL using HttpClient.

You can view the common connection code example [here](connectioncode_example.html).

<b>Explore the NRL</b><br />
You can explore and test the NRL POST command using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html#/Nrls/createPointer).

{% include note.html content="The code in these examples is standard C# v7.2 taken directly from the [NRL Demonstrator](https://nrls.digital.nhs.uk) code.<br /><br />The official <b>[.NET FHIR Library](https://ewoutkramer.github.io/fhir-net-api/)</b> is utilised to construct, test, parse, and serialize FHIR models with ease." %}
