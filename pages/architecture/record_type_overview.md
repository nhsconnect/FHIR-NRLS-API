---
title: Record Type Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: record_type_overview.html
summary: A overview of the types of information that can be made available via NRL
---

When sharing information, a provider will create pointers which tell consumers what type of information is being shared, the formats in which that information is shared and the mechanisms which can be used to retrieved the information.

To allow shared information to be used in different use cases, there needs to be standardisation in the grouping of information and the retrieval mechanisms used. The NRL has a list of supported pointer types and supported retrieval formats that can be used by providers to share information, these lists will be updated as new types and formats are added.

When choosing the information types and retrieval mechanisms that will be supported by the NRL, the aim is to make the shared information useful in a broad set of use cases, across a number of different care settings while still allowing the consumer to identify the bits of information they are interested in.


## Types of Information

Choosing how to group information is challenging, it can be done at various levels of granularity and in different ways. How information is grouped will affect its usefulness and re-usability across different use cases and care settings.

For example, a summary of the patients complete record could be shared as one type of pointer, a group of related items such as a list of medications could be shared as another type, and a specific bits of information such as a mental health crisis plan document or a discharge summary could be a separate type within NRL.

Choosing the types is about finding a balance between enabling consumers to find the information they want, enabling re-use and keeping the complexity of pointers low.

### Granularity of Pointer Types

The extreme of granular pointers would be for each document and data item in a patients record to have it's own type. Pointer types with a high level of granularity add a number of challenges for the service, the providers and consumers.

- Maintenance Overhead
  - The more granular the pointer types, the more time that is required to manage and maintain the list of supported types within the NRL, to make sure they are relevant and useful to providers and consumers use cases.
  - The more granular the pointers types, the more likely they will need to be updated as information reference within the provider system changes. This would correlate with an increased maintenance overhead for the provider.
  - With more granular pointers, consumers would need to spend time maintain the list of pointer types they are interested in, so that they are more likely to get all the information relevant to their use case.

- Added Complexity
  - Increased granularity of pointer types adds complexity within a provider system, as the provider will needs to maintain more mappings between their internal information types and pointer types. The information they hold may map to multiple different granular pointer types and could add complexity trying to map to all matching NRL pointer types.
  - With more granular pointer types, as information changes within the provider system there will be more trigger points where the system needs to perform pointer maintenance to maintain pointer accuracy and there is more risk of errors occurring.
  - With more granular pointers it makes it more difficult for consumers to process as there may be a number of similar types which the consumer would need to decide it they are relevant to their use case.
  - With very granular pointers, different provider may share the same information using slightly different variations on a type of pointer, making it difficult for consumers to consistently retrieve information which would be useful to them.

- Reduced Re-usability
  - Granular pointers are more likely to be tailored to a specific use case and could reduce re-usability, meaning that a proliferation of similar pointers would be see, on the NRL, as new pointer types are created to meet new use cases. This would adds additional complexity for consumers trying to get information as they would need to keep checking newly added pointer types and doing development with would be more frequent with more granular pointers.


On the other hand broad pointer types, such as pointing to the whole of a patients record, can makes the service less usable for a consumer and more resource intensive when trying to find information which is relevant.

- Identifying if an endpoint reference from a pointer will return relevant information
  - From a broad type of pointer the consumer would not know if the provider has information they are interested in, even if the record type reference could hold that information. The pointer would not indicate if the record actually contains the information only that it could. The consumer would need to retrieve the information to check if the information they want is in the record, meaning there would be an increased number of times where a consumer makes un-nessersary retrievals that return no information they are interested in. This is both additional burden on the consumer and provider systems.

- Added Complexity
  - Really broad pointers either return complex data structures or require a knowledge of an API referenced by the pointer. Both these scenarios make consuming and processing the returned information more complex and potentially more prone to error.

Pointer types need to be defined in a middle ground, with a balance between complexity and usability. The aim is to identify a core set of information which would help in a number of use cases but does not result in un-nessersary retrievals from providers to check if the specific type of information a consumer is interested in is present in the available information. Different types of information will need to be grouped in different ways and at different levels of granularity.


### Information Formats

Information is created and stored within a providers system in a variety of formats but the NRL broadly makes a distinction based on the notion of **structured** and **unstructured** information.

| Type | Description | Example |
| --- | --- | --- |
| Structured | Structured information is made up of clearly defined data types and data items, which has a composition that is usually machine readable, meaning that a consuming system can manipulate and use the information more easily. The information can usually be combined with locally held when displayed to a user which can give a better user experience. | HL7 FHIR Resources, XML |
| Unstructured | Unstructured information is comprised of information does not have well defined data types and data items. It is usually not machine readable and requires users to interpret the information as its format might vary between providers. | PDF, Images |


### Static/Dynamic

Information sharing is a snapshot of the current information available on a providing system, some pointer types will reference information which does not change and others could return different information each time they are call. The NRL refers to the following two types of shared information:

| Type | Description |
| --- | --- |
| static | Static types of information are those which do not change, for example a PDS document or a medical image will not change once stored in a patient record. If a pointer reference static information it means that each time a consumer calls the provider endpoint they will retrieve the same information. |
| dynamic | There is information which will be shared in a format that could change between calls to the retrieval endpoint by a consumer. This is known as **dynamic** information because the response to the consumers request is dynamically built from the available information when the endpoint is called.<br/><br/>An example of dynamic information would be a pointer that references a list of medications for a patient. As medications are added, removed or change the information returned to a consumer will depend on when the consumer sends a request to the endpoint. |


### Use of national standards

To enable Consumers to retrieve information with minimal custom integration between Consumer and Provider systems, information should be exposed using national standards.

The pointer model includes a 'Record format' metadata attribute, which describes the technical structure of the information and the mechanism for retrieval. The set of supported formats for retrieval is described on the [retrieval formats page](retrieval_formats.html).


## Managing Information Shared with Users

The varying granularity of pointer types and re-use of pointer types by different use cases and care settings means consumers may get information that is not useful to their use case or suitable for sharing with their some of their users.

With this in mind, there will most likely be a need for consumers to filter information before it is displayed to the end user. This responsibility belongs to the Consumer and must be implemented using local access controls to determine if a given user should be permitted access to that information.


