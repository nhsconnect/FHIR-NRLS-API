---
title: CareConnect Immunizations FHIR STU3
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_careconnect_immunizations_fhir_stu3.html
summary: CareConnect Immunizations, FHIR STU3 format for information retrieval.
---

The `CareConnect Immunizations FHIR STU3` retreival format included on a pointer denotes that the provider supports the [CareConnect Immunization FHIR STU3 - Search](https://nhsconnect.github.io/CareConnectAPI/api_medication_immunization.html#2-search) capability at the URL endpoint included in the pointer.

In alignment with national stratergy, providers should be aiming to implement a complete implementation of the CareConnect API, but this page outlines the minimum conformance to the standard required for endpoints which will be included within NRL pointers to immunization data.


## Pointer Retrieval `Format` Code

In the NRL pointer, the retrieval [format](pointer_fhir_resource.html#retrieval-format) code for this structure is as follows:

|System|Code|Display|
|------|----|-------|
| https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1 | urn:nhs-ic:fhir:stu3:careconnect-immunizations-fhir-stu3 | CareConnect Immunizations FHIR STU3 |



## Endpoint and Search Parameters

The [HL7 FHIR Search](https://www.hl7.org/fhir/STU3/search.html) specification details the use of chaining search parameters to retrive resources, including allowing for parameters which request the inclusion of resources that reference another specific resource. This allows a consumer to retrieve all or part of the information a provider holds.

### URL

The URL incuded in the pointer MUST be to the Immunization endpoint on the server, and MUST include the patient identifier parameter.

```url
https://{fhir_server_base_url}/Immunization?patient.identifier=https://fhir.nhs.uk/Id/nhs-number|{NHS_Number}
```

The consumer MAY add other chained search paramters to the request.


### Provider Requirements

The Provider endpoint MUST support the following search parameters, which the consumer can include in their request as part of a chained search.

| Parameter | Description |
| --- | --- |
| patient.identifier | The `patient.identifier` parameter allows the consumer to request Immunizations held by the provider for a patient with a specific identifier. The provider MUST support searching by NHS Number. |
| _include | The `_include` parameter allows the consumer to request that referenced resources are included within the response. This allows them to reduce the number of calls to the providers endpoint by retrieving all the data within the single call.<br/><br/>The provider must support the `:recurse` modifier on `_include` to also include references to references (e.g the organisation for an Encounter linked to the Immunization). This should include specific resources as well as the `*` wildcard to be specified.<br/><br/>Where referenced resources are not supported by the `_include` parameter, or are not included in the request by the consumer, the provider SHOULD include references to endpoints where the data can be retrieved inline with the CareConnect API specification. |


###  Consumer Requirements

A consumer should consider the following, when implementing a consumer for a CareConnect API endpoint:

- A consumer MUST not assume all referenced resources are supported by the `_include` parameter so SHOULD be able to make seperate calls to retrieve referenced resources, within the response from the provider



## Retrieval Authentication and Authorization

The `CareConnect Immunizations FHIR STU3` retrieval format endpoints **MUST** support the [SSP Read](retrieval_ssp.html) retrieval interaction.



## Examples

### All Immunizations For A Patient - referenced resources NOT include

Request:

```url
http://hapi.fhir.org/baseDstu3/Immunization?patient.identifier=https://fhir.nhs.uk/Id/nhs-number|9912003888
```


Response:

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/retrieval_formats/careconnect-immunizaitons-fhir-stu3.json %}
{% endhighlight %}
</div>


### All Immunizations For A Patient - referenced resources INCLUDED

Request:

```url
http://hapi.fhir.org/baseDstu3/Immunization?patient.identifier=https://fhir.nhs.uk/Id/nhs-number|9912003888&_include:recurse=*
```


Response:

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/retrieval_formats/careconnect-immunizaitons-fhir-stu3-with-references.json %}
{% endhighlight %}
</div>
