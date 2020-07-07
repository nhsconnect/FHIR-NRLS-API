---
title: Record Type Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: record_type_overview.html
summary: A overview of the types of information that can be made available via NRL
---

When sharing informaiton, a proviers will create pointers which tell consumers what type of information is being shared, the formats in which that information is shared and the mechanisms which can be used to retrieved the information.

To allow shared information to be used in different use cases, there needs to be standardisation in the grouping of information and the retrieval mechanisms used. The NRL has a list of supported pointer types and supported retrieval formats that can be used by providers to share information.

When choosing the information types and retrieval mechanisms that will be supported by the NRL, the aim is to make the shared information useful in a broad set of use cases, across a number of different care settings while still allowing the consumer to identify information they would be interested in.


## Types of Information

Choosing how to group information is challenging, it can be done at various levels of granularity and in different ways. How information is grouped will affect its usefulness and re-usability across different use cases and care settings.

For example, a summary of the patients complete record could be shared as one type of pointer, a group of related items such as a list of medications could be shared as another type, or a specific bits of information such as a mental health crisis plan document or a discharge summary could be a type within NRL.

Choosing the types is about finding a balance between enabling consumers to find the informaiton they want, enabling re-use and keeping the complexity of pointers to a minimum.

### Granularity of Pointer Types

The extreme of granular pointers would be for each document and data item in a patients record to have it's own type. Pointer types with a high level of granularity add a number of challenges for the service, the providers and the consumers.

- Maintenance Overhead
  - The more granular the pointer types, the more time that would be need to managing and maintining the list of supported types within the NRL, to make sure they are still relevant and useful to providers and consumers.
  - The more granular pointers are more likely they will need to be updating as information they reference changes within the provider system. This directly relates to an increase in maintenance overhead for the provider as pointer types become more granular.
  - With more granular pointers, consumers would need to spend time maintain the list of pointer types they are interested in, so that they get all the information relevant to their use case.

- Added Complexity
  - Increased granularity of pointer types adds complexity within a provider system, as they will needs to maintain more mappings between their internal information types and pointer types. The information they hold may map to multiple different granular pointer types and could add complexity trying to mapp to all matching pointer types.
  - With more granular pointer types, as information changes within the provider system there will be more trigger points where the system needs to perform pointer maintenance to maintain pointer accuracy and there is more risk of errors occuring.
  - With more granular pointers it makes it more difficult for consumers to process as there may be a number of similar types which the consumer would need to decide it they are relevant to their use case.
  - With very granular pointers, different provider may share the same information using different types of pointer making it difficult for consumers to consistently retrieve information which would be useful to them.

- Reduced Re-usability
  - Granular pointers are more likely to be tailored to a specific use case and could reduce re-usibility, meaning that a proliferation of similar pointers would be see as new pointer types are created to meet new use cases. Which adds to the complexity for consumers trying to get information.


Broad pointer types such as pointing to the whole of a patients record can makes the service less usable for a consumer.

- Knowing what pointer will return relevant information
  - The consumer would not know if the provider has information they are interested in, even if the record could hold the information the pointer would not indicate if the record actuall contains the information. The consumer would need to retrieve the information to check if the information they want is in the record, mean there would be more un-nessersary retrievals that return no information. This is both additional burden on the consumer and provider.


Pointer types need to sit in the middle ground and get a balance between complexity and usability. The aim is to identify a core set of information which would help in a number of use cases but does not result in un-nessersary retrievals from providers to check if the specific type of information a consumer is interested in is present in the available information. Different types of information will need to be grouped and accessed at different levels of granularity.



## Use of national standards

To enable Consumers to retrieve records with minimal custom integration between Consumer and Provider systems, records should be exposed using national standards. 

The NRL defines a [Read interaction](retrieval_interaction_read.html) for retrieval of a record via the SSP, which enables a retrieval of records using a standard HTTP GET interaction for a set of specified formats and data structures. There may be exceptions where record retrieval takes place using an alternative retrieval mechanism. 

The pointer model includes a 'Record format' metadata attribute, which describes the technical structure of the record and the mechanism for retrieval. The set of supported formats for retrieval is described on the [retrieval formats page](retrieval_formats.html).


## Retrieval Formats

Un-structured/ Structured

Records come in a variety of formats but the NRL broadly makes a distinction based on the notion of **structured** and **unstructured** Records. Structured Records are made up of clearly defined data types whose composition makes them relatively easy to manipulate. Contrast this with unstructured Records which crudely could be said to be “everything else” and are comprised of data that is usually not as easy to manipulate.

FHIR / PDF / HTML web page

### Static/Dynamic

The NRL also acknowledges that there is a difference to be drawn between how the contents of a Record can change over time (see the [Record creation datetime](overview_data_model.html#data-model) field on Pointer). To the NRL a **static** Record is one whose contents will never change whereas a **dynamic** Record’s contents are not guaranteed to be the same from one point in time to another in the future.

### Digital Maturity

The NRL recognises that there exist varying levels of digital maturity across Providers and Consumers. The format and method of retrieval for a Record are under the control of the Provider system. Currently, two record retrieval scenarios are envisaged:

- A Provider exposes a Record for direct retrieval, such that using the context available in the Pointer, a Consumer can retrieve the Record electronically. 
- A Provider exposes a set of contact details that a Consumer can use to retrieve the Record. The Consumer does not retrieve the Record electronically. Instead, they use the contact details as an intermediate step to get to the Record, such as by phoning a healthcare service found in the contact details, who can then relay the Record to the Consumer by other means.

beneficial to add multiple supported retrieval formats?


## Managing pointers or retrieve information shared with users

When a Consumer requests that the NRL return the Pointers that it has for a given patient (NHS number) it will return all Pointers. The NRL will not perform any filtering before sending that collection of Pointers back to the Consumer. 

Once consequence of this is that the end user on the Consumer side may be exposed to Pointers that reveal sensitive information about the Patient, for example it will be possible to infer through a Pointer that a Patient has a certain kind of record. Even though the user may not be able to retrieve the Record, knowing that it exists is in itself revealing a degree of personal information about that patient that may not be appropriate.

With this in mind, there will most likely be a need to filter Pointers before they are displayed to the end user. This responsibility belongs to the Consumer and should be implemented using local access rules to judge whether a given user should be permitted to know that a given Pointer exists. This is in addition to the RBAC requirements for NRL (see the [Authentication & Authorisation page](integration_authentication_authorisation.html)).

The mechanism for making this decision is predicated on the [Record type](overview_data_model.html#data-model) that the Pointer references.


