---
title: Pointer Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: pointer_overview.html
summary: A technical overview the pointers
---

## What do pointers do


Pointers are associated with a Record. As noted, a Record exists in a remote system. One of the roles of the Pointer is to provide enough context to allow a Consumer to retrieve that Record from the remote system and display it.

The format and method of retrieval for a Record are under the control of the Provider system. It might be that the Provider has exposed the Record for direct retrieval, such that using the context available in the Pointer, a Consumer is able to retrieve the Record.

Alternatively, rather than point to an electronic copy of the Record, the Provider can expose a set of contact details that a Consumer can use to retrieve the Record. In this scenario, the Consumer is not retrieving the Record electronically. Instead, they are using the contact details as an intermediate step to get to the Record, perhaps by phoning a healthcare service found in the contact details who will then relay the Record to the Consumer via another mechanism.

<img alt="Pointers link to Records by providing either an API endpoint or contact details of the Provider" src="images/solution/Solution_Concepts_Pointer2_diagram.png" style="width:100%;max-width: 100%;">

The preceding diagram shows two Pointers that reference the same Record (Record A). The ways that they describe how to get the contents of Record A are different. In red is a Pointer that directly references the Provider’s API. In this example, following the Pointer will return the Record in electronic form direct from the Provider’s record store (green).

In contrast, the blue Pointer contains a set of contact details. A Consumer following this Pointer would begin their retrieval by dialling the telephone number detailed in the Pointer. This would begin a human-controlled process that would ultimately lead to Record A being retrieved for them. In this example, the person referenced by the contact details accesses Record A using the same API endpoint that the red Pointer references.



## Pointer Lifecycle

A Pointer is a reference to some content, which is stored on a system external to NRL. It has its own lifecycle that is managed by a third party (the Record owner). The Pointer lifecycle as described by NRL defines the statuses and permitted transitions between those statuses for the pointer. The statuses and transitions ensure that only the appropriate pointers are shown to Consumers.

## Pointer Status

A Pointer can be in one of three possible statuses: 
- "current" - Indicates that the Pointer metadata and record URL are valid and can be used to inform clinical decision making. The definition of “current” is under the control of the Provider, but a Consumer should be confident that by selecting the Pointer they will be presented with a document or record that the Provider considers to be appropriate for Consumers to use.
- "superseded" – Indicates that this Pointer has been replaced by an updated version. This could be a Pointer with updated metadata or an updated reference to a document. Note that this represents the status of the pointer and does not necessarily indicate a previous version of a document.
- "entered-in-error" – Indicates that the Pointer should not have been entered into the NRL, as it is not valid. This could be for a number of reasons, including errors in either the pointer metadata or the record/document itself. This status allows a Provider to mark a Pointer as erroneous without needing to delete it.

Only pointers with the status of “current” are made available to Consumers. The statuses “superseded” and “entered-in-error” are in use in the Pointer Lifecycle for pointer management and auditing purposes. 

## Pointer Status: Legal Transitions

Not only is the value of a Pointer’s status constrained, but the transition from one status to another is also tightly controlled.

![Pointer transitions](images/pointers/pointer_transitions.png)

***Figure 1: Status transitions: The NRL controls the transition from one status to another. It is not possible to transition from any given status to any other.***

All Pointers begin life with a status of current. From there, it is possible to move to either the superseded or entered-in-error statuses.

Once in the superseded or entered-in-error statuses, the Pointer cannot transition anywhere else. One cannot build a chain of Pointers on top of a Pointer with a status other than current. Only the current Pointer can be used in this way by superseding it and replacing it with a new version that becomes the current Pointer. See the [Pointer status transition: worked examples](#pointer-status-transition-worked-examples) section for details on how the NRL allows a Provider to transition the status of its Pointers.

## Pointer Status: Making Transitions

When a Pointer is first created it will always have a status of current. 
From there it is possible to supersede that Pointer or to mark it as entered-in-error. Figure 2 below illustrates the NRL functions that must be invoked in order to trigger the transition from one state to another (legal) state.

![Allowed pointer interactions](images/pointers/pointer_transitions2.png)

***Figure 2: Interactions to transition between statuses: The NRL allows a Provider to transition its Pointers' status using a combination 
of create and update actions.***

One transition that is worth expanding on is the transition from current to superseded. In this case, an existing Pointer (P1) with a status of current is to be superseded (replaced) by a new Pointer (P2). P2 will become the current Pointer, and P1 will become superseded.

In order to supersede a pointer, there must always be a newer version. Therefore, to ensure the transactional integrity of this activity, which spans two Pointers (P1 and P2 in our example), the action is wrapped up into the CREATE of P2. More details on the mechanics of this are provided in the [Managing Pointers to content](pointer_maintenance.html#managing-pointers-to-content) section.

## Pointer Status Transition: Worked Examples

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

## Deleting Pointers

If a pointer is no longer valid or appropriate for use and should not be superseded or marked as "entered-in-error", then the pointer should be deleted.



## What do pointers contain to allow them to do this

Broad Data items and what they are for


## Pointer Identity

Once persisted within the NRL there are up to two ways to refer to a specific Pointer instance. Both are identifiers that are stored on the Pointer itself, but the master identifier is optional and is specified by the Provider.

- Logical identifier – This identifier is assigned by the NRL service when it persists a Pointer. It uniquely identifies that Pointer within the NRL service. The NRL service instance is the namespace for a given Pointer’s Logical identifier. 

- Master identifier – This also uniquely identifies the Pointer within the boundary of the NRL service. However, unlike the logical identifier, the master identifier is optional and is under the control of the Provider. For more details, see the [Master Identifier](#master-identifier) and [Uniqueness](#uniqueness) sections below.

### Logical Identifier

The logical identifier (ID) is generated by the NRL during the creation of a new Pointer. It is unique across all Pointers on the NRL service that created the Pointer. If the Pointer were ever to be migrated to a different NRL service instance then it is possible that its ID might need to change to avoid clashes with Pointers on the target NRL service.

The format of the ID is under the control of the NRL service. Clients should treat the id as an opaque identifier. In other words, the client should not make assumptions about the structure of the ID.

### Master Identifier

The master identifier is an optional identifier on the Pointer. It is under the control of the Provider. Guidance on the use of a unique master identifier value:

- Once a pointer with a master identifier value has been created, that same master identifier value must not be re-used with another pointer.
- 'Superseding' requires a new master identifier value. If a pointer is superseded, the new Pointer that replaces it must have a new, unique master identifier value.
- Once a pointer with a master identifier is deleted, the master identifier value used in that pointer cannot be used again on the NRL.

## Data

In order to support the Consumer and Provider interactions with the NRL, a data model is provided for the Pointer. The data model is purposefully lean, each property has a clear reason to exist, and it directly supports the activities of Consumers and Providers.

You can explore an in-depth view of the lean data model and the full NRL DocumentReference profile in the [FHIR Resources and References section](explore_reference.html).

| Property | Cardinality | Description | 
|-----------|----------------|------------|
|[Identifier](pointer_identity.html)|0..1|Assigned by the NRL at creation time. Uniquely identifies this record within the NRL. Used by Providers to update or delete.|
|Profile|0..1|The URI of the FHIR profile that the resource conforms to. Indicates the version of the pointer model.|
|Pointer version |0..1|Assigned by the NRL at creation or update time. Used to track the current version of a Pointer.|
|Pointer last updated datetime|0..1|Assigned by the NRL at creation and update time. The date and time that the pointer was last updated.|
|Pointer indexed datetime|0..1|Assigned by the NRL at creation time. The date and time that the pointer was created.|
|[Master Identifier](pointer_identity.html)|0..1|An optional identifier of the document as assigned by the Provider. It is version specific — a new master identifier is required if the document is updated.|
|[Pointer Status](pointer_lifecycle.html)|1..1|The status of the pointer|
|Patient|1..1|The NHS number of the patient that the record referenced by this Pointer relates to. Supports Pointer retrieval scenarios.|
|Pointer owner|1..1|The entity that maintains the Pointer. Used to control which systems can modify the Pointer.|
|Record owner|1..1|The entity that maintains the Record. Used to provide the Consumer with context around who they will be interacting with if retrieving the Record.|
|Record category|1..1|A high-level category of the record. The category will be one of a controlled set. It will not be possible to create a pointer with a category that does not exist within this controlled set.|
|Record type|1..1|The clinical type of the record. Used to support searching to allow Consumers to make sense of large result sets of Pointers. The clinical type will be one of a controlled set. It will not be possible to create a pointer with a type that does not exist within this controlled set.|
|Record creation clinical setting|1..1|Describes the clinical setting in which the content was created.|
|Period of care|0..1|Details the period in which the documented care is relevant.|
|Pointer reference|1..*|Information about the record referenced|
|Record creation datetime|0..1|The date and time (on the Provider’s system) that the record was created, for static records.|
|Record URL|1..1|Absolute URL for the location of the record on the Provider’s system|
|Record format|1..1|Describes the technical structure and rules of the record such that the Consumer can pick an appropriate mechanism to handle the record.|
|Record MIME type|1..1|Describes the type of data such that the Consumer can pick an appropriate mechanism to handle the record.|
|Record stability|1..1|Describes whether the record content at the time of the request is dynamically generated or is static.|
|[Related Documents](pointer_maintenance.html)|0..1|Relationship to another pointer|
