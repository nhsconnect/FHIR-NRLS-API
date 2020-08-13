---
title: Retrieval Overview
keywords: structured rest documentreference
tags: [record_retrieval,for_consumers,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_overview.html
summary: Solution overview of record and document retrieval
---

The "Information Retrieval" pages are intended to give developers detailed requirements and guidance, about how to understand and implement the different types of information sharing and retrieval that can be reference in an NRL pointer.

Retrieval formats identify the types of information sharing that can be referenced by an NRL pointer. Retrieval formats are made up of two components:

| Component | Description |
| --- | --- |
| Retrieval Interaction | Identifies the mechanism that can be used to retrieve the information |
| Retrieval Data Model | Identifies the structure and rules of the information that can be retrieved |

Each retrieval format is a unique combination of a retrieval interaction and retrieval data model. It may be possible to retrieve the same data model via two different retrieval interactions, in which case there will be two retrieval formats to represent this.  

The retrieval format by which the information can be retrieved from a provider is shared in the NRL pointer, using the following two metadata fields:

| Field | Description |
| --- | --- |
| [Retrieval format](explore_reference.html#retrieval-format) | Describes the technical structure, the rules of the information and the mechanism for retrieval |
| [Retrieval MIME type](explore_reference.html#retrieval-mime-type) | Describes the data type of the information |

See the [Pointer Overview](pointer_overview.html) page and the [FHIR Profile Reference](explore_reference.html) page for more details on the data model and the two metadata fields.

The combination of these two metadata fields allows:
- a **provider** to say what format they are sharing information in.
- a **consumer** system the know the type and structure of the content that will recieve. This allows them to decide if they will be able to process and render the information for a user.

# Retrieval Interactions

The retrieval interaction identifies is the mechanism that can be used by a consumer to retrieve information from the provider and represents the authentication and authorisation requirements for that retrieval.

The retrival interaction information is important to:

- **providers** so they can expose information using a mechanism that consumers can understand and utilise
- **consumers** so they can understand how to retrieve information from a provider


## Supported Retrieval Interactions

The following table describes the retrieval interactions that are currently supported within NRL pointers:

| Retrieval Interaction | Description |
|-----------|----------------|
| [Public Web](retrieval_http_unsecure.html) | Some information types, such as Contact Details, can be shared and retrieved via public facing web pages. |
| [SSP](retrieval_ssp.html) | The SSP is a content agnostic forward proxy, which is used to control and protect access to health systems. It provides a single security point removing the need for a complex and onerous authentication and authorisation mechanism between all consumers and providers. |
| Direct Integration | The option for consumers and providers to communicate directly, not to use the SSP, is possible where direct integration and a shared authentication and authorisation model is established. |


# Retrieval Data Models

Retrieval data models refer to the structure in which information can be shared. The NRL pointers can refer to information which can retrieved in a range of formats, including both unstructured documents and structured data, as described on the [Record Type Overview](record_type_overview.html) page.

Structured data formats will be versioned and where any breaking changes to a data structure are required, a new format will be created with an increment to the version number. The NRL supports multiple versions of data structures. 

# Supported Retrieval Formats

The following table describes the formats that are currently supported within NRL pointers:

| Format | Description | Retrieval Interaction |
|-----------|----------------|----------------|
| [Contact Details (HTTP Unsecured)](retrieval_contact_details.html) | A publicly accessible HTML web page or PDF detailing contact details for retrieving a record. | [Public Web](retrieval_http_unsecure.html) |
| [Unstructured Document](retrieval_contact_details) | An unstructured document, such as a PDF. The content-type of the document returned should be described in the retrieval MIME type field of the pointer. |  [SSP](retrieval_ssp.html) |
| [Allergy List FHIR STU3 v1](retrieval_allergies_fhir_stu3.html) | A list of allergies, in a FHIR STU3 structured format. |  [SSP](retrieval_ssp.html) |
| [Observation List FHIR STU3 v1](retrieval_observations_fhir_stu3.html) | A list of observations, in a FHIR STU3 structured format. |  [SSP](retrieval_ssp.html) |
| [Vaccination List FHIR STU3 v1](retrieval_vaccinations_fhir_stu3.html) | A list of vaccinations, in a FHIR STU3 structured format. |  [SSP](retrieval_ssp.html) |


## Supporting Multiple Retrieval Formats

The NRL pointer model allows for multiple formats to be specified within a single pointer. Therefore a pointer could contain a reference for retrieval of information in a PDF format, but also as a structured FHIR resource.

Each retrieval format would be detailed in a separate `content` element, within on the FHIR DocumentReference resource which represents the pointer.

Where a Pointer contains reference to multiple formats, the consuming system must decide which is the most appropriate format to retrieve and display within their system.


### Multiple Format Example

The following examples show a pointer for a Mental Health Crisis Plan that can be retrieved over the phone (using the contact details listed on the referenced HTML web page) and directly as a PDF document.

#### XML

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/retrieval_multiple_formats.xml %}
{% endhighlight %}
</div>

#### JSON

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/retrieval_multiple_formats.json %}
{% endhighlight %}
</div>


# NRL Retrieval Management

## User Access to Information

When a consumer system requests pointers for a patient, the NRL will return all pointers for that patient which are of a type that the organisation has been approved to receive.

Once the pointers have been returned, it is the responsibility of the consuming organisation/system to control which pointers and what information retrieved using the pointers is shared with the end user. This will require a level of RBAC control and filtering within the consumer system and should be implemented in line with local access rules to judge whether a given user should be permitted to know that a pointer type exists or to be given access to information retrieved using information from a pointer.

Details of access control requirements are outlined on the [Access Controls](access_controls.html) page.


## Retrieval Availability

The NRL does not guarantee that Records can be retrieved by following information in pointers. 

There are complexities associated with retrieving data over a network that are outside of the scope of the metadata captured by a Pointer.

As an example, consider the need to define firewall rules to allow traffic to flow between a consumer and a provider. The NRL aims to facilitate record retrieval by supporting the [SSP](retrieval_ssp.html) retrieval interaction, reducing the need for point-to-point integration between consumer and provider systems. However, providers still have a responsibility to ensure that the pointer metadata accurately reflects the retrieval mechanism and format of the referenced information.


## Caching and Storing

It is important that consumers of NRL pointers, and the information retrieved using information from those pointers, can view and make clinical decisions based on the most up-to-date and accurate information available. For this reason, NRL recommends that pointers, and any information retrived using the references contained in the pointers, is not be cached or stored, apart from as part of audit history.

The consumer system should request the pointer and perform any data retrieval each time information is needed, in order to make sure they have the latest information about which providers have information about a patient and that any information retrieved is the latest and most up to date available from that providers system.
