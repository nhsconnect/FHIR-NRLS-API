---
title: API Delete Interaction
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_delete.html
summary: To support the deletion of NRLS pointers.
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Delete ##

API to support the deletion of NRLS pointers. This functionality is only available for providers.

## Delete Request Headers ##


Provider API delete requests support the following HTTP request headers:

| Header               | Value |Conformance |
|----------------------|-------|-------|
| `Accept`      | The `Accept` header indicates the format of the response the client is able to understand, this will be one of the following <code class="highlighter-rouge">application/fhir+json</code> or <code class="highlighter-rouge">application/fhir+xml</code>. See the RESTful API [Content types](development_general_api_guidance.html#content-types) section. | MAY |
| `Authorization`      | The `Authorization` header will carry the base64url encoded JSON web token required for audit on the spine - see [Access Tokens and Audit (JWT)](integration_access_tokens_and_audit_JWT.html) for details. |  MUST |
| `fromASID`           | Client System ASID | MUST |
| `toASID`             | The Spine ASID | MUST |




## Delete Operation ##

{% include note.html content="Please make sure that all query parameters are encoded with the appropriate code." %}

### Delete by *'id'* ###

The API supports the conditional delete interaction which allows a provider to delete an existing pointer based on the search parameter `_id` which refers to the logical id of the pointer. 

The logical id can be obtained from the Location header which is contained in the [create response](api_interaction_create.html#create-response).

To accomplish this, the provider issues an HTTP DELETE as shown:

<div markdown="span" class="alert alert-success" role="alert">
DELETE [baseUrl]/DocumentReference?_id=[id]</div>



Providers systems SHALL only delete pointers for records where they are the pointer owner (custodian). 

For all delete requests the `custodian` ODS code in the DocumentReference to be deleted SHALL be affiliated with the Client System `ASID` value in the `fromASID` HTTP request header sent to the NRLS.

<div class="language-http highlighter-rouge">
<pre class="highlight"><code><span class="err">DELETE [baseUrl]/DocumentReference?_id=da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142
</span></code>
Delete the DocumentReference resource for a pointer with a logical id of 'da2b6e8a-3c8f-11e8-baae-6c3be5a609f5-584d385036514c383142'.</pre>
</div>


### Delete by *'masterIdentifier'* ###

The API supports the conditional delete interaction which allows a provider to delete an existing pointer using the masterIdentifier
so they do not have to persist or query for the NRLS generated logical id for the Pointer.
To accomplish this, the provider issues an HTTP DELETE as shown:

<div markdown="span" class="alert alert-success" role="alert">
DELETE [baseUrl]/DocumentReference?subject=[https://demographics.spineservices.nhs.uk/STU3/Patient/[nhsNumber]&identifier=[system]%7C[value]</div>

*[nhsNumber]* - The NHS number of the patient whose DocumentReferences the client is requesting

*[system]* - The namespace of the masterIdentifier value that is associated with the DocumentReference(s)

*[value]* - The value of the masterIdentifier that is associated with the DocumentReference(s)

Providers systems SHALL only delete pointers for records where they are the pointer owner (custodian). 

<div class="language-http highlighter-rouge">
<pre class="highlight">
<code><span class="err">
DELETE [baseUrl]/DocumentReference?subject=https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210&identifier=urn:ietf:rfc:3986%7Curn:oid:1.3.6.1.4.1.21367.2005.3.71
</span></code>
Delete the DocumentReference resource for a pointer with a subject and identifier.</pre>
</div>


## Delete Response ##

<p>The 'delete' interaction removes an existing resource. The interaction is performed by an HTTP DELETE of the <code class="highlighter-rouge">DocumentReference</code> resource.</p>


Success:

- SHALL return a `200` **OK** HTTP status code on successful execution of the interaction.
- SHALL return a response body containing a payload with an `OperationOutcome` resource that conforms to the ['Spine-OperationOutcome-1'](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1) FHIR profile. 

The table summarises the successful `delete` interaction scenario and includes HTTP response code and the values expected to be conveyed in the response body `OperationOutcome` payload:


| HTTP Code | issue-severity | issue-type | Details.Code | Details.Display | Details.Text |Diagnostics |
|-----------|----------------|------------|--------------|-----------------|-------------------|
|200|information|informational|RESOURCE_DELETED|Resource removed | Spine message UUID |Successfully removed resource DocumentReference: [url]|

{% include note.html content="Upon successful deletion of a pointer the NRLS Service returns in the reponse payload an OperationOutcome resource with the OperationOutcome.issue.details.text element populated with a Spine internal message UUID. This UUID is used to identify the client's Delete transaction within Spine. A client system SHOULD reference the UUID in any calls raised with the Deployment Issues Resolution Team. The UUID will be used to retrieve log entries that relate to a specific client transaction." %}


Failure: 

The following errors can be triggered when performing this operation:

- [No record found](development_general_api_guidance.html#resource-not-found)
- [Invalid Resource](development_general_api_guidance.html#invalid-resource)


## Code Examples ##

### DELETE a Pointer with C# ###

The following code samples are taken from the NRLS Demonstrator application which has both Consumer and Provider client implementations built in. More information about the design solution can be found
on the [NRLS Demonstrator Wiki](https://github.com/nhsconnect/nrls-reference-implementation/wiki)

First we generate a base pointer request model that includes the pointer logical id used for the _id parameter.
The logical id is obtained from a mapping stored within the Demonstrator that maps the Provider system crisis plans to NRLS pointers.

Then we call our DocumentReference service DeletePointer method which will build a DELETE command request and then start the call to the NRLS API.


<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.Services/Service/Epr/CrisisPlanService.cs#L158-L160 %}
{% highlight csharp %}
{% github_sample /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.Services/Service/Epr/CrisisPlanService.cs 157 159 %}
{% endhighlight %}
</div>

<b>Calling the NRLS</b><br />
Using our DELETE command request model we create a connection to the NRLS using HttpClient.

You can view the common connection code example [here](connectioncode_example.html).


<b>Explore the NRLS</b><br />
You can explore and test the NRLS DELETE command using Swagger in our [Reference implementation](https://data.developer.nhs.uk/nrls-ri/index.html#/Nrls/deletePointer).

{% include note.html content="The code in these examples is standard C# v7.2 taken direct from the [NRLS Demonstrator](https://nrls.digital.nhs.uk) code.<br /><br />The official <b>[.NET FHIR Library](https://ewoutkramer.github.io/fhir-net-api/)</b> is utilised to construct, test, parse and serialize FHIR models with ease." %}
