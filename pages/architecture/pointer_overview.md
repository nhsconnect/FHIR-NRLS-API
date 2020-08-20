---
title: Pointer Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: pointer_overview.html
summary: A technical overview of pointers.
---

## What Do Pointers Do?

Pointers on the NRL tell consumers the type of information that is available from a provider and how to get it. A provider can choose what information they want to share and how they want to share it.

A provider might allow consumers to retrieve the same information in a number of different ways, and this would be reflected in the pointer(s) they create on the NRL. The following diagram illustrates the concept that a provider might enable different ways of retrieving the same information.

<img alt="Pointers link to Records by providing either an API endpoint or contact details of the Provider" src="images/architecture/pointer_type_overview.png" style="width:100%;max-width: 100%;">

The provider creates a single pointer on the NRL that points to the information (Record A) within the provider system. The pointer references each method or format of retrieving the record:
- The first reference included on the pointer is the URL of a web page contianing contact details for the provider organisation. Retrieval in this scenario begins with a user in the consumer organisation visiting the URL contained within the pointer and dialling the telephone number listed on the web page; this begins a human-controlled process that ultimately leads to "Record A" being retrieved.
- The second reference included on the pointer is to an API endpoint exposed by the provider. In this scenario the consumer system would use the details in the pointer to programatically request Record A directly from the provider system to use/display its content within the consumer system. 

A pointer could contain multiple references to API endpoints that return the record in different formats. For example, an endpoint which returns the record as a PDF document and another that returns it in a structured data format.

## Pointer Data Items

For a consumer, the information carried in the pointer serves two main purposes:
- to determine which information could be useful
- how to retrieve the information

The content of the pointer is intended to be lightweight and high-level, giving enough information to indicate the type of information the consumer can retrieve and some contextual information, such as the care setting the information is being shared from. This enables the consumer system or user to apply filtering to find relevant pointers.

The pointer model is intentionally lean. Including complex detail within a pointer would put a significant maintenance burden on the provider and risks making consumption of pointers more difficult for consumers.

The pointer data model is based on the [FHIR NRL-DocumentReference-1 resource](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1) and carries the following information:
- Identifiers for the pointer and patient
- Metadata about the pointer (e.g. version control, pointer ownership)
- Metadata about the referenced information (e.g. information type, ownership and associated dates)
- Information for retrieving the record (e.g. URL, information format)

For more detailed information about the pointer data model and population guidance, see the [Pointer Data Model page](pointer_data_model.html).

## Pointer Lifecycle

The pointer lifecycle within the NRL focuses on the `status` of pointers and the permitted transitions between those statuses. The statuses and transitions ensure that only the appropriate pointers are shown to consumers.

### Pointer Status

A pointer can have one of three possible statuses:

| Status | Description |
| --- | --- |
| current | Indicates that the pointer and referenced information is considered by the provider to be valid for consumption and can be used to inform clinical decision making. The NRL will make pointers with the `current` status available to consumers. |
| superseded | Indicates that this pointer has been replaced by a new pointer. `superseded` pointers will not be available to consumers and will remain only for pointer management and audit purposes. |
| entered-in-error | Indicates that the pointer should not have been created in the NRL, and is not valid. This status allows a provider to mark a pointer as erroneous without needing to delete it. `entered-in-error` pointers will not be available to consumers and will remain only for pointer management and auditing purposes. |

### Pointer Status Transitions

The permitted transition from one status to another, within the NRL, are outlined within the diagram below:

![Pointer transitions](images/pointers/pointer_transitions.png)

When a pointer is created it will have a status of `current`. From the `current` state the pointer may either transition to the `superseded` or `entered-in-error` state. After entering the `superseded` or `entered-in-error` state the pointer may not transition to any other state.

### Making Transitions

Pointer status transitions are related to the pointer management interactions provided by the NRL:

| Interaction | Status Transition |
| --- | --- |
| Create | A new pointer will default to the `current` status. |
| Supersede | The new pointer will be created with a status of `current`. The status of the overridden pointer will transition from `current` to `superseded`. |
| Update | The status of the pointer will transition from `current` to `entered-in-error`. |

### Deleting Pointers

If a pointer is no longer valid or appropriate for use and should not be superseded or marked as `entered-in-error`, the pointer should be deleted.
