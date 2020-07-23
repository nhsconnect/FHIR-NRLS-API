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

The following table shows the data items that can be carried within a pointer:

| Data Item | Description |
|----------------|------------|
|Patient|The NHS number of the patient which the information referenced, by the pointer, relates to.|
|Information category|A high-level category of the information, from a set of NRL supported categories.|
|Information Type|The clinical type of the information which is reference by the pointer. The clinical type will be from a controlled set of types supported by the NRL.|
|Clinical setting|Describes the clinical setting in which the information was recorded.|
|Period of care|Optional information detailing the period in which the referenced record is/was active.|
|Retrieval URL|An absolute URL for the location of the information on the Provider’s system.|
|Retrieval format|An identifier for the technical structure and rules of the information.|
|Retrieval MIME type|Describes the type of data, in addition to the "Retrieval format".|
|Information stability|Describes whether the information shared at the time of the consumers request is dynamically generated or static.|
|Information creation datetime|Optional information about the date and time (on the Provider’s system) that the information was created (for static records).|
|Pointer owner|The entity that maintains the Pointer.|
|Information owner|The entity that maintains the information.|
|Pointer Identifier|Assigned by the NRL at creation time. Uniquely identifies this record within the NRL.|
|Master Identifier|An optional identifier for the pointer as assigned by the Provider. It is version specific and a new master identifier is required if the pointer is superdeded, or deleted and recreated.|
|Pointer version |Assigned by the NRL at creation or update time. Used to track the current version of a Pointer.|
|Pointer last updated datetime|Assigned by the NRL at creation and update time. The date and time that the pointer was last updated.|
|Pointer indexed datetime|Assigned by the NRL at creation time. The date and time that the pointer was created.|
|Related Pointer|Relationship referencing the previous version of the pointer, which has been superseded.|



## Pointer Identity

A pointer stored on the NRL has a logical identifier, assigned by the NRL, but it may also have a second identifier which is set by the provider, called the master identifier.

### Logical Identifier

This identifier is assigned by the NRL when it persists a pointer. It uniquely identifies that pointer within the NRL.

The format of the ID is under the control of the NRL service and consumers should treat the identifier as an opaque. In other words, the client should not make assumptions about the structure of the identifier.

### Master Identifier

This identifier also uniquely identifies the pointer within the NRL. However, unlike the logical identifier, the master identifier is optional and is under the control of the provider.

When providers create a pointer they must use a globally unique master identifier, following the guidelines below:

- A Master Identifier must not be re-used, once used in a pointer
- 'Superseding' a pointer requires a new, unique, master identifier to be included in the new pointer superseding the existing pointer
- Master Identifiers within deleted pointers cannot be used again for new pointers

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
