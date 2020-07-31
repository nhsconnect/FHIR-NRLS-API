---
title: Information Sharing Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: information_sharing_overview.html
summary: A overview of the ways in which iformation can be shared by providers with consumers
---

When sharing information, a provider will create pointers which tell consumers what type of information is being shared, the formats in which that information is shared and the mechanisms which can be used to retrieved the information.

To allow information shared to be used in different use cases, there needs to be standardisation in the grouping of information and the retrieval mechanisms used. The NRL has a list of supported pointer types and supported retrieval formats that can be used by providers to share information, these lists will be updated as new types and formats are added.


### Types of Information

When choosing the information types and retrieval mechanisms that will be supported by the NRL, the aim is to make the shared information useful in a broad set of use cases, across a number of different care settings while still allowing the consumer to identify the bits of information they are interested in.

Choosing how information should be grouped is challenging, it can be done at various levels of granularity and in different ways. How information is grouped will affect its usefulness and re-usability across different use cases and care settings.

For example, a summary of the patients complete record could be shared as one type of pointer, a group of related items such as a list of medications could be shared as another type, and a specific bits of information such as a mental health crisis plan document or a discharge summary could be a separate type within NRL.

Choosing the types is about finding a balance between enabling consumers to find the information they want, enabling re-use and keeping the complexity of pointers low.

A function within NHS Digital will manage the onboarding of new use cases and requests to share information, so that pointer types and retrieval formats aligns with the principles and aims of the service. NHS Digital will also consider information governance when determining the use cases, provider and retrieval formats that will be supported by NRL.


## Information Formats

Information is created and stored within a providers system in a variety of formats but the NRL broadly makes a distinction based on the notion of **structured** and **unstructured** information.

| Type | Description | Example |
| --- | --- | --- |
| Structured | Structured information is made up of clearly defined data types and data items, which have a composition that is usually machine readable, meaning that a consuming system can manipulate and use the information more easily. The information can usually be combined with locally held information when displayed to a user which can give a better user experience. | HL7 FHIR Resources, XML |
| Unstructured | Unstructured information is comprised of information does not have well defined data types and data items. It is usually not machine readable and requires users to interpret the information as its format might vary between providers. | PDF, Images |


## Static/Dynamic

Information sharing is a snapshot of the current information available on a providing system, some pointer types will reference information which does not change and others could return different information each time they are call. The NRL refers to the following two types of shared information:

| Type | Description |
| --- | --- |
| static | Static types of information are those which do not change, for example a PDF of a scanned paper document or a medical image will not change once stored in a patient record. If a pointer reference static information it means that each time a consumer calls the provider endpoint they will retrieve the same information. |
| dynamic | There is information which will be shared in a format that could change between calls to the retrieval endpoint by a consumer. This is known as **dynamic** information because the response to the consumers request is dynamically built from the available information when the endpoint is called.<br/><br/>An example of dynamic information would be a pointer that references a list of medications for a patient. As medications are added, removed or change the information returned to a consumer will depend on when the consumer sends a request to the endpoint. |


## Use of national standards

To enable Consumers to retrieve information with minimal custom integration between Consumer and Provider systems, information should be exposed using national standards.

The pointer model includes a 'Record format' metadata attribute, which describes the technical structure of the information and the mechanism for retrieval. The set of currently supported formats for retrieval is described on the [retrieval formats page](retrieval_formats.html).


## Managing Information Shared with Users

The varying granularity of pointer types and re-use of pointer types by different use cases and care settings means consumers may get information that is not useful to their use case or suitable for sharing with their some of their users.

With this in mind, there will generally be a need for consumers to filter information before it is displayed to the end user. This responsibility belongs to the consumer and must be implemented using local access controls to determine if a given user should be permitted access to that information.


