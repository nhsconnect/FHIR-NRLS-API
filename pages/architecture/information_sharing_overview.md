---
title: Information Sharing Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: information_sharing_overview.html
summary: An overview of the ways in which information can be shared by providers with consumers.
---

When sharing information, a provider will create pointers which tell consumers what type of information is being shared, the formats in which that information is shared and the mechanisms which can be used to retrieved the information.

To allow information shared to be used in different use cases, there needs to be standardisation in the grouping of information and the retrieval mechanisms used. The NRL has a list of supported pointer types and supported retrieval formats that can be used by providers to share information, these lists will be updated as new types and formats are added.

### Types of Information

When choosing the information types and retrieval mechanisms that will be supported by the NRL, the aim is to make the shared information useful in a broad set of use cases, across a number of different care settings whilst still allowing the consumer to identify the bits of information they are interested in.

Choosing how information should be grouped is challenging, it can be done at various levels of granularity and in different ways. How information is grouped will affect its usefulness and re-usability across different use cases and care settings. For example, here are a few options of information grouping/types for a patient (one pointer for each):
- A summary of the patient's complete record
- A list of the patient's medications
- A mental health crisis plan document
- A discharge summary

Choosing the types is about finding a balance between enabling consumers to find the information they want, enabling re-use and minimising pointer complexity.

A function within NHS Digital will manage the onboarding of new use cases and requests to share information, so that pointer types and retrieval formats aligns with the principles and aims of the service. NHS Digital will also consider information governance when determining the use cases, provider and retrieval formats that will be supported by the NRL.

## Information Formats

Information is created and stored within a provider's system in a variety of formats but the NRL broadly makes a distinction based on the notion of **structured** and **unstructured** information.

| Type | Description | Example |
| --- | --- | --- |
| Structured | Structured information is made up of clearly defined data types and data items, which have a composition that is usually machine readable, meaning that a consuming system can manipulate and use the information more easily. The information can usually be combined with locally held information when displayed to a user, providing a better user experience. | HL7 FHIR resource, XML |
| Unstructured | Unstructured information is comprised of information that does not have well defined data types and data items. It is usually not machine readable and requires users to interpret the information as its format might vary between providers. | PDF, image |

## Static/Dynamic

Information sharing provides a snapshot of the most up-to-date information available on the providing system at the time it's requested. Some pointer types will reference information which will never change, whilst others *could* return different information each time they are called. The NRL refers to the following two types of shared information:

| Type | Description |
| --- | --- |
| static | Static types of information are those which will never change, for example a PDF of a scanned paper document or a medical image will not change once stored in a patient record. If a pointer references static information it means that each time a consumer calls the provider endpoint they will always retrieve the same information. |
| dynamic | **Dynamic** information *could* change between calls to the retrieval endpoint stored in a pointer because the response content is dynamically built from the information available at the time the endpoint is called.<br/><br/>An example of dynamic information is a list of a patient's medications; because medications are added, removed or change over time, the information returned to a consumer will depend on when their request is invoked. |

## Use of National Standards

To enable consumers to retrieve information with minimal custom integration between consumer and provider systems, information should be exposed using national standards.

The pointer model includes a record format metadata attribute, which describes the technical structure of the information and the mechanism for retrieval. The set of currently supported formats for retrieval is described on the [retrieval formats page](retrieval_formats.html).

## Managing Information Shared With Users

The varying granularity of pointer types and re-use of pointer types by different use cases and care settings means consumers may get information that is:
- not relevant to their use case
- unsuitable for sharing with their some or all of their users

With this in mind, there will generally be a need for consumers to filter information before it is displayed to an end user. This responsibility belongs to the consumer, who must employ local access controls to filter out data to match the access level of the user viewing the information.
