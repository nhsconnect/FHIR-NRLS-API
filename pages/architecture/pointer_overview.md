---
title: Pointer Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: pointer_overview.html
summary: A technical overview the pointers
---

## What do pointers do

Pointers on the NRL tell consumers what type of information is available from provider and how to get it. A provder can choose what information they want to share and how they want to share it.

A provider might allow consumers to retrieve the same information in a number of different ways, and this would be reflected in the pointer(s), they create on the NRL. The following diagram illustrates the concept that a provider might enable different ways of retrieving the same information.

<img alt="Pointers link to Records by providing either an API endpoint or contact details of the Provider" src="images/architecture/pointer_type_overview.png" style="width:100%;max-width: 100%;">

The provider  creates two pointers on NRL that point to the same information (Record A) within the provider system:
- The first pointer contains contact details for the provider. Retrieval in this scenario begins with a user in the consumer organisation dialling the telephone, using the contact details in the pointer. This would begin a human-controlled process that would ultimately lead to "Record A" being retrieved.
- The second pointer references an API endpoint exposed by the provider. In this scenario the consumer system would use the details in the pointer to request the record directly from the provider system and could display the returned record to the user in the consumer system.


## Pointer Data Items

For a consumer, the information carried in the pointer serves two main purposes:
- to allowing the them to determin which information could be useful
- to tell the them how they can retrieve the information

The content of the pointer is intended to be light weight and high level, giving enough information to indicate to the consumer the type of information they can retrieve and some contectual information, such as the care setting the information is being shared from, so that the consumer can filter down the returned pointer to a smaller set which they can retrieve. The pointer model aims to keep complexity low, as including too much detail within a pointer would put a significant maintenance burden on the provider and make consumption of pointers more difficult for consumers.

The following table shows the data items that can be carried within a pointer:

| Data Item | Description |
|----------------|------------|
|Patient|The NHS number of the patient which the information referenced, by the pointer, relates to.|
|Information category|A high-level category of the information, from a set of NRL supported categories.|
|Information Type|The clinical type of the information which is reference by the pointer. The clinical type will be from a controlled set of types supported by the NRL.|
|Clinical setting|Describes the clinical setting in which the information was recorded.|
|Period of care|Optional information detailing the period in which the documented care, reference by the pointer, is relevant.|
|Retrieval URL|An absolute URL for the location of the information on the Provider’s system.|
|Retrieval format|An identifier for the technical structure and rules of the information.|
|Retrieval MIME type|Describes the type of data, in addition to the "Retrieval format".|
|Information stability|Describes whether the information shared at the time of the consumers request is dynamically generated or static.|
|Information creation datetime|Optional information about the date and time (on the Provider’s system) that the information was created (for static records).|
|Pointer owner|The entity that maintains the Pointer.|
|Information owner|The entity that maintains the information.|
|Pointer Identifier|Assigned by the NRL at creation time. Uniquely identifies this record within the NRL.|
|Master Identifier|An optional identifier for the pointer as assigned by the Provider. It is version specific and a new master identifier is required if the pointer is updated.|
|Pointer version |Assigned by the NRL at creation or update time. Used to track the current version of a Pointer.|
|Pointer last updated datetime|Assigned by the NRL at creation and update time. The date and time that the pointer was last updated.|
|Pointer indexed datetime|Assigned by the NRL at creation time. The date and time that the pointer was created.|
|Related Pointer|Relationship to another pointer|



## Pointer Identity

A pointer stored on the NRL has a logical identifier, assigned by the NRL, but it may also have a second identifier which is set by the provider, called the master identifier.

### Logical Identifier

This identifier is assigned by the NRL when it persists a pointer. It uniquely identifies that pointer within the NRL.

The format of the ID is under the control of the NRL service and consumers should treat the identifier as an opaque. In other words, the client should not make assumptions about the structure of the identifier.

### Master Identifier

This identifier also uniquely identifies the pointer within the NRL. However, unlike the logical identifier, the master identifier is optional and is under the control of the provider.

When providers create a pointer they must use a unique master identifier, following the guidlines below:

- A Master Identifier must not be re-used, once use in a pointer
- 'Superseding' a pointer requires a new, unique, master identifier to be included in the new pointer superseding the existing pointer
- Master Identifiers within deleted pointers cannot be used again for new pointers


## Pointer Lifecycle

A Pointer is a reference to some content, which is stored on a system external to NRL. It has its own lifecycle that is managed by a third party (the Record owner). The Pointer lifecycle as described by NRL defines the statuses and permitted transitions between those statuses for the pointer. The statuses and transitions ensure that only the appropriate pointers are shown to Consumers.

### Pointer Status

A Pointer can be in one of three possible statuses: 
- "current" - Indicates that the Pointer metadata and record URL are valid and can be used to inform clinical decision making. The definition of “current” is under the control of the Provider, but a Consumer should be confident that by selecting the Pointer they will be presented with a document or record that the Provider considers to be appropriate for Consumers to use.
- "superseded" – Indicates that this Pointer has been replaced by an updated version. This could be a Pointer with updated metadata or an updated reference to a document. Note that this represents the status of the pointer and does not necessarily indicate a previous version of a document.
- "entered-in-error" – Indicates that the Pointer should not have been entered into the NRL, as it is not valid. This could be for a number of reasons, including errors in either the pointer metadata or the record/document itself. This status allows a Provider to mark a Pointer as erroneous without needing to delete it.

Only pointers with the status of “current” are made available to Consumers. The statuses “superseded” and “entered-in-error” are in use in the Pointer Lifecycle for pointer management and auditing purposes. 

### Pointer Status: Legal Transitions

Not only is the value of a Pointer’s status constrained, but the transition from one status to another is also tightly controlled.

![Pointer transitions](images/pointers/pointer_transitions.png)

***Figure 1: Status transitions: The NRL controls the transition from one status to another. It is not possible to transition from any given status to any other.***

All Pointers begin life with a status of current. From there, it is possible to move to either the superseded or entered-in-error statuses.

Once in the superseded or entered-in-error statuses, the Pointer cannot transition anywhere else. One cannot build a chain of Pointers on top of a Pointer with a status other than current. Only the current Pointer can be used in this way by superseding it and replacing it with a new version that becomes the current Pointer. See the [Pointer status transition: worked examples](#pointer-status-transition-worked-examples) section for details on how the NRL allows a Provider to transition the status of its Pointers.

### Pointer Status: Making Transitions

When a Pointer is first created it will always have a status of current. 
From there it is possible to supersede that Pointer or to mark it as entered-in-error. Figure 2 below illustrates the NRL functions that must be invoked in order to trigger the transition from one state to another (legal) state.

![Allowed pointer interactions](images/pointers/pointer_transitions2.png)

***Figure 2: Interactions to transition between statuses: The NRL allows a Provider to transition its Pointers' status using a combination 
of create and update actions.***

One transition that is worth expanding on is the transition from current to superseded. In this case, an existing Pointer (P1) with a status of current is to be superseded (replaced) by a new Pointer (P2). P2 will become the current Pointer, and P1 will become superseded.

In order to supersede a pointer, there must always be a newer version. Therefore, to ensure the transactional integrity of this activity, which spans two Pointers (P1 and P2 in our example), the action is wrapped up into the CREATE of P2. More details on the mechanics of this are provided in the [Managing Pointers to content](pointer_maintenance.html#managing-pointers-to-content) section.

### Pointer Status Transition: Worked Examples

Note that in the diagrams below, three properties from the Pointer data model are referenced. One of them is the version. 
This is the version of the Pointer, not the version of the content referenced. Each time a particular instance of a Pointer is modified, the NRL service will increment the version by one, as can be seen in several of the worked examples.

***Null to current***

As a Provider, I want to create a new Pointer on the NRL, so that Consumers are aware of a resource that I own.

![Null to current](images/pointers/pointer_transitions3.png)

The Provider CREATEs a brand new Pointer, transitioning from the null state (no Pointer exists) to a newly-minted Pointer, whose status can only be current.

***Current to superseded (replaced)***

As a Provider, I want to create a new Pointer on NRL that supersedes one of my existing Pointers, so that Consumers have access to the latest information regarding my resource.

![Current to superseded (replaced)](images/pointers/pointer_transitions4.png)

As part of the CREATE action for the new Pointer, the Provider describes a relationship between the new and existing (obsoleted) Pointer. The NRL uses this relationship to create a new Pointer, marking it as current. It also deprecates the existing Pointer by marking it as superseded and modifying its version to reflect the change.

***Current to entered-in-error***

As a Provider, I want to mark an existing Pointer as entered-in-error, so that Consumers know not to base any clinical decisions 
on the Pointer or the resource that it references.

![Current to entered-in-error](images/pointers/pointer_transitions5.png)

The Provider must UPDATE the existing resource, changing its status from current to entered-in-error. In doing so, the NRL will modify its version to reflect the change.

### Deleting Pointers

If a pointer is no longer valid or appropriate for use and should not be superseded or marked as "entered-in-error", then the pointer should be deleted.

