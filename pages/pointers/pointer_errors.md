---
title: Pointer Errors
keywords: engage about
tags: [pointers,for_providers]
sidebar: overview_sidebar
permalink: pointer_errors.html
summary: NRL Pointer Errors
---

## Pointer Errors

The NRL API does not give Providers the ability to update the properties of an existing Pointer, other than the status property. The status property is modified in one of two ways.

The first is where a Provider replaces one DocumentReference with another, known as superseding. See [API Interaction - Supersede](api_interaction_supersede.html) for details.

The second is by performing a update to directly change the status of the pointer. See [API Interaction - Update](api_interaction_update.html) for details.

## Pointer Error Handling

Errors happen. It is important to acknowledge this reality and to design a solution with this in mind. To that end, the NRL makes a distinction between the following kinds of error:

* Errors with the Pointer metadata
* Errors with the content (record/document) that the Pointer references

## Errors with the Pointer Metadata

There are two scenarios in which a Pointer metadata error may occur:
* Error with the data that the Provider system is using to create a Pointer
* Defect in the Provider system that is creating and publishing Pointers

These errors may lead to one the following two situations:
* The Pointer itself should not have been added to the NRL
* It is valid for the Pointer to exist, but there are problems with the data stored on a Pointer. For example, the record creation date might be incorrect.

When the Provider realises there is a problem with the Pointer, action must be taken by the Provider. Depending on the nature of the problem, the Provider has different options when it comes to dealing with the issue.

### Pointer Should Not Have Been Added to NRL

In this case, as soon as the issue is recognised, the Provider should mark that Pointer’s status as entered-in-error.

Note that it is important to do this before that Pointer has been superseded, as once that transition has been made it is not possible to mark a Pointer as entered-in-error — see [Pointer lifecycle](pointer_lifecycle.html). Only those Pointers with a status of current can be moved to the entered-in-error state.

If a Provider finds that one of its superseded Pointers should not have been registered with the NRL, the entire lineage of that Pointer is considered corrupted. The Provider must mark the Pointer at the head of the lineage (the "current" Pointer) as being entered-in-error.

The Provider should then recreate a new "current" pointer with the correct information in place of the Pointer that was marked as entered-in-error.

### Pointer Data Is Invalid

Where the presence of the Pointer on NRL is valid but the data it holds is invalid, the Provider should update the pointer’s status to entered-in-error and create a new pointer that contains the correct data.

## Errors with the Content (Record/Document) that the Pointer References

The Provider should correct the content using whatever local processes are in place. This may necessitate the creation of a new version of the content, in which case it may be appropriate to replace the current Pointer with a new one. Alternatively, the correction to the content may be such that the existing Pointer transparently references the corrected content. In either case, responsibility for ensuring that the referenced content is correct rests with the Provider.
