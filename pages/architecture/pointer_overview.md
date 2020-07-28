---
title: Pointer Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: pointer_overview.html
summary: A technical overview the pointers
---

## What Do Pointers Do?

Pointers on the NRL tell consumers the type of information that is available from a provider and how to get it. A provider can choose what information they want to share and how they want to share it.

A provider might allow consumers to retrieve the same information in a number of different ways, and this would be reflected in the pointer(s), they create on the NRL. The following diagram illustrates the concept that a provider might enable different ways of retrieving the same information.

<img alt="Pointers link to Records by providing either an API endpoint or contact details of the Provider" src="images/architecture/pointer_type_overview.png" style="width:100%;max-width: 100%;">

The provider  creates a single pointer on NRL that points to the information (Record A) within the provider system. The pointer references each method or format of retrieving the record:
- The first reference included on the pointer is to contact details for the provider organisation. Retrieval in this scenario begins with a user in the consumer organisation dialling the telephone, using the contact details in the pointer. This would begin a human-controlled process that would ultimately lead to "Record A" being retrieved.
- The second reference included on the pointer is to an API endpoint exposed by the provider. In this scenario the consumer system would use the details in the pointer to request the record directly from the provider system and could display the returned record to the user in the consumer system. 

A pointer could contain multiple references to API endpoints that returned the record in different formats. For example, an endpoint which returns the record as a PDF document and another that returns it in a structured data format. 


## Pointer Data Items

For a consumer, the information carried in the pointer serves two main purposes:
- to allowing the them to determine which information could be useful
- to tell the them how they can retrieve the information

The content of the pointer is intended to be light weight and high level, giving enough information to indicate to the consumer the type of information they can retrieve and some contextual information, such as the care setting the information is being shared from. This enables a consumer system or user to apply filtering to find relevant pointers. 

The pointer model is intentionally lean. Including complex detail within a pointer would put a significant maintenance burden on the provider and risks making consumption of pointers more difficult for consumers.

The pointer data model is based on the [FHIR NRL-DocumentReference-1 resource](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1) and carries the following information:
- Identifiers for the pointer and patient
- Metadata about the pointer (e.g. version control, pointer ownership)
- Metadata about the referenced information (e.g. information type, ownership and associated dates)
- Information for retrieving the record (e.g. URL, information format)

For more detailed information about the pointer data model and population guidance, see the [Pointer Data Model page](pointer_data_model.html).

## Pointer Lifecycle

The pointer lifecycle within the NRL focuses on the `status` of pointers and the permitted transitions between those statuses. The statuses and transitions ensure that only the appropriate pointers are shown to Consumers.

### Pointer Status

A Pointer can be in one of three possible statuses:

| status | Description |
| --- | --- |
| current | Indicates that the pointer and referenced information is considered by the provider to be valid for consumption and can be used to inform clinical decision making. The NRL will make pointers with the `current` status available to consumers. |
| superseded | Indicates that this pointer has been replaced by a new pointer. `superseded` pointers will not be available to consumers and exist for pointer management and audit purposes. |
| entered-in-error | Indicates that the Pointer should not have been created in the NRL, and is not valid. This status allows a Provider to mark a pointer as erroneous without needing to delete it. `entered-in-error` pointers will not be available to consumers and exist for pointer management and auditing purposes. |


### Pointer Status Transitions

The permitted transition from one status to another, within the NRL, are outlined within the diagram below:

![Pointer transitions](images/pointers/pointer_transitions.png)

When a pointer is created it will have a status of `current`. From the `current` state the pointer may either transition to the `superseded` or `entered-in-error` state. After entering the `superseded` or `entered-in-error` state the pointer may not transition to any other state.


### Making Transitions

Pointer status transitions are related to the pointer management interactions provided by NRL:

| Interaction | State Transition |
| --- | --- |
| Create | A new pointer create will have the status "current" |
| Supersede | A supersede interaction will transition the existing pointer status from `current` to `superseded`, and the new pointer will be created with a status of `current` |
| Update | The update interaction allows the provider to transition the status of the pointer from `current` to `entered-in-error` |


### Deleting Pointers

If a pointer is no longer valid or appropriate for use and should not be superseded or marked as "entered-in-error", then the pointer should be deleted.
