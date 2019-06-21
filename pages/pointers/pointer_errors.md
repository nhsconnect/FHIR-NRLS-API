---
title: Pointer Errors
keywords: engage, about
tags: [pointer]
sidebar: overview_sidebar
permalink: pointer_errors.html
summary: NRL Pointer Errors
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRL API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}

## Pointer Errors ##

The NRL API does not give Providers the ability to update the properties of an existing Pointer, other than the status property. The status property is modified in one of two ways. 

The first is where a Provider replaces one DocumentReference with another, known as superseding - see [API Interaction - Supersede](api_interaction_supersede.html) for more details. 

The second is by performing a update to directly change the status of the pointer - see [API Interaction - Update](api_interaction_update.html) for more details.

## Pointer error handling ##

Errors happen. It is important to acknowledge this reality and to design a solution with this in mind. To that end the NRL makes a distinction between the following kinds of error – 

- Errors with the Pointer meta data
- Errors with the content (record/document) that the Pointer references

## Errors with the Pointer meta data ##

There are two routes by which incorrect data could find its way in to a Pointer – 
1.	Error with the data that the Provider system is using to create a Pointer
2.	Defect in the Provider system that is creating and publishing Pointers

These errors, however they have originated could lead to one of two situations – 
1.	The Pointer itself should not have been added to the NRL
2.	It is valid for the Pointer to exist however there are problems with the data stored on a Pointer, for example the record creation date might be incorrect.
When the Provider realises that there is a problem with the Pointer then action must be taken by the Provider. Depending on the nature of the problem the Provider has different options when it comes to dealing with the issue.

### Pointer should not have been added to NRL ###

In this case as soon as the issue is recognised the Provider should mark that Pointer’s status as entered-in-error.

Note that it is important to do this before that Pointer has been superseded as once that transition has been made it is not possible to mark a Pointer as entered-in-error - see [Pointer lifecycle](pointer_lifecycle.html). Only those Pointers with a status of current can be moved to the entered-in-error state.

If a Provider finds that one of their superseded Pointers should not have been registered with the NRL then the entire lineage of that Pointer is considered corrupted. The Provider must mark the Pointer at the head of the lineage (i.e. the current Pointer) as being entered-in-error.

The Provider should then recreate a new "current" pointer with the correct information in place of the pointer that was marked as entered-in-error.

### Pointer’s data is invalid ###

Where the presence of the Pointer on NRL is valid but the data it holds is invalid then the Provider should update the pointer’s status to entered-in-error and create a new pointer that contains the correct data.

## Errors with the content (record/document) that the Pointer references ##

The Provider should correct the content using whatever local processes are in place. This may necessitate the creation of a new version of the content in which case it may be appropriate to replace the current Pointer with a new one or the correction to the content may be such that the existing Pointer transparently references the corrected content. In either case responsibility for ensuring that the referenced content is correct rests with the Provider.










