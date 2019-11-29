---
title: Pointer Lifecycle
keywords: engage about
tags: [pointers,for_providers,for_consumers]
sidebar: overview_sidebar
permalink: pointer_lifecycle.html
summary: NRL Pointer Lifecycle
---

## Pointer lifecycle

A Pointer is a reference to some content, which is stored on a system external to NRL. It has its own lifecycle that is managed by a third party (the Record owner). The Pointer lifecycle as described by NRL defines the statuses and permitted transitions between those statuses for the pointer. The statuses and transitions ensure that only the appropriate pointers are shown to Consumers.

## Pointer status

A Pointer can be in one of three possible statuses: 
- "current" - Indicates that the Pointer metadata and record URL are valid and can be used to inform clinical decision making. The definition of “current” is under the control of the Provider, but a Consumer should be confident that by selecting the Pointer they will be presented with a document or record that the Provider considers to be appropriate for Consumers to use.
- "superseded" – Indicates that this Pointer has been replaced by an updated version. This could be a Pointer with updated metadata or an updated reference to a document. Note that this represents the status of the pointer and does not necessarily indicate a previous version of a document.
- "entered-in-error" – Indicates that the Pointer should not have been entered into the NRL, as it is not valid. This could be for a number of reasons, including errors in either the pointer metadata or the record/document itself. This status allows a Provider to mark a Pointer as erroneous without needing to delete it.

Only pointers with the status of “current” are made available to Consumers. The statuses “superseded” and “entered-in-error” are in use in the Pointer Lifecycle for pointer management and auditing purposes. 

## Pointer status: legal transitions

Not only is the value of a Pointer’s status constrained, but the transition from one status to another is also tightly controlled.

![Pointer transitions](images/pointers/pointer_transitions.png)

***Figure 1: Status transitions: The NRL controls the transition from one status to another. It is not possible to transition from any given status to any other.***

All Pointers begin life with a status of current. From there, it is possible to move to either the superseded or entered-in-error statuses.

Once in the superseded or entered-in-error statuses, the Pointer cannot transition anywhere else. One cannot build a chain of Pointers on top of a Pointer with a status other than current. Only the current Pointer can be used in this way by superseding it and replacing it with a new version that becomes the current Pointer. See the [Pointer status transition: worked examples](#pointer-status-transition-worked-examples) section for details on how the NRL allows a Provider to transition the status of its Pointers.

## Pointer status: making transitions

When a Pointer is first created it will always have a status of current. 
From there it is possible to supersede that Pointer or to mark it as entered-in-error. Figure 2 below illustrates the NRL functions that must be invoked in order to trigger the transition from one state to another (legal) state.

![Allowed pointer interactions](images/pointers/pointer_transitions2.png)

***Figure 2: Interactions to transition between statuses: The NRL allows a Provider to transition its Pointers' status using a combination 
of create and update actions.***

One transition that is worth expanding on is the transition from current to superseded. In this case, an existing Pointer (P1) with a status of current is to be superseded (replaced) by a new Pointer (P2). P2 will become the current Pointer, and P1 will become superseded.

In order to supersede a pointer, there must always be a newer version. Therefore, to ensure the transactional integrity of this activity, which spans two Pointers (P1 and P2 in our example), the action is wrapped up into the CREATE of P2. More details on the mechanics of this are provided in the [Managing Pointers to content](pointer_maintenance.html#managing-pointers-to-content) section.

## Pointer status transition: worked examples

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
