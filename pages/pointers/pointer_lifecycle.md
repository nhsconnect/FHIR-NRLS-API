---
title: Pointer Lifecycle
keywords: engage, about
tags: [pointer]
sidebar: overview_sidebar
permalink: pointer_lifecycle.html
summary: NRL Pointer Lifecycle
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRL API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}

## Pointer Lifecycle ##

A Pointer is a reference to some content. From the perspective of NRL that content is held on a remote system. It has its own lifecycle that is managed by a third-party (the Record owner). The Pointer Lifecycle as described by NRL defines the statuses and permitted transitions between those statuses for the pointer. The statuses and transitions ensure that only the appropriate pointers are shown to Consumers. 

## Pointer Status ##

The Pointer has the concept of a status. It can have one of three possible values: 
- "current" - Indicates that the Pointer references a clinically relevant record. The definition of “current” is under the control of the Provider but a Consumer should be confident that by selecting the Pointer they will be presented with a document or record that the Provider considers to be appropriate for Consumers to use.
- "superseded" – Indicates that this Pointer has been replaced by another. This could be a Pointer with updated meta-data or an updated reference to a document. Note that this represents the status of the pointer and does not necessarily indicate a previous version of a document.  
- "entered-in-error" – Indicates that the Pointer should not have been entered into the NRL as it is not valid. This could be for a number of reasons, including errors on either the pointer meta-data or the document itself. This status allows a Provider to mark a Pointer as erroneous without needing to delete it.

Only pointers with the status of “current” are made available to Consumers. The statuses “superseded” and “entered-in-error” are in use in the Pointer Lifecycle for pointer management and auditing purposes. 

## Pointer status: legal transitions ##

Not only is the value of a Pointer’s status constrained but the transition from one status to another is also tightly controlled.

<img src="images/pointers/pointer_transitions.png">

***Fig 1: status transitions: The NRL controls that transition from one status to another. It is not possible to transition from one to all states.***

All Pointers begin life with a status of current. From there it is possible to move into a superseded state or to an entered-in-error state.

Once in a superseded state, or an entered-in-error state, the Pointer cannot transition anywhere else. One cannot build a chain of Pointers on top of a Pointer whose status is entered-in-error, or a Pointer which has already been superseded. Only the current Pointer can be used in this way by superseding it and replacing it with a new version that becomes the current Pointer. See the Pointer status transition: worked examples section that details how the NRL allows a Provider to transition the status of their Pointers.

## Pointer status: making transitions ##

When a Pointer is first created it will always have a status of current. 
From there it is possible to supersede that Pointer or to mark it as entered-in-error. Fig 2 below illustrates the NRL functions that must be invoked in order to trigger the transition from one state to another (legal) state.

<img src="images/pointers/pointer_transitions2.png">

***Fig 2: How to transition between statuses: The NRL allows the Provider to transition their Pointers state using a combination 
of the create and update actions.***

One transition that is worth expanding on is the transition from current to superseded. In this case the existing Pointer (P1) whose status is current is to be replaced or superseded by a new Pointer (P2) which will become the current Pointer and P1 will become superseded. 

In order to supersede there must always be a replacement. Therefore, to ensure the transactional integrity of this activity which spans 
two Pointers (P1 and P2 in our example) the action is wrapped up into the CREATE of P2. More details on the mechanics of this are provided 
in the section named Managing Pointers to static content below.

## Pointer status transition: worked examples ##

Note that in the diagrams below three properties from the Pointer data model are referenced. One of them is the version. 
This is the version of the Pointer and not the version of the content that the Pointer references. 
Each time a particular instance of a Pointer is modified the NRL service will increment the version by one as can be seen in several of the worked examples.

***Null to Current***

As a Provider I want to create a new Pointer on NRL so that Consumers are aware of a resource that I own.

<img src="images/pointers/pointer_transitions3.png">

The Provider CREATEs a brand new Pointer transitioning from the null state (no Pointer exists) to a newly minted Pointer whose status can only be current.

***Current to Superseded (replaced)***

As a Provider I want to create a new Pointer on NRL that supersedes one of my existing Pointers so that Consumers have access to the latest 
information regarding my resource.

<img src="images/pointers/pointer_transitions4.png">

As part of the CREATE of the new Pointer that will replace the existing one the Provider describes the relationship between the 
new and existing Pointer. The NRL uses this relationship to create a new Pointer marking it as current and to deprecate the existing 
Pointer marking it as superseded and modifying its version to reflect the change to that Pointer.

***Current to Entered in error***

As a Provider I want to mark an existing Pointer as entered in error so that Consumers know not to base any clinical decisions 
on the Pointer or the resource that it references.

<img src="images/pointers/pointer_transitions5.png">

The Provider must UPDATE the existing resource changing its status from current to entered-in-error. In doing so the NRL will modify its version to reflect the change to that Pointer.

## Deleting Pointers ##

If a pointer is no longer valid or appropriate for use and should not be superseded or marked as "entered-in-error", then the pointer should be deleted.

