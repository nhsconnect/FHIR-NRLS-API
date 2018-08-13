---
title: Pointer Errors
keywords: engage, about
tags: [pointer]
sidebar: overview_sidebar
permalink: pointer_errors.html
summary: NRLS Pointer Errors
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}

{% include warning.html content="
The current version of the NRLS API does not give Providers the ability to update the properties of an existing Pointer. 
The only property that can be modified is the status and that is done in a very specific way only allowing a Provider to replace one 
pointer with another [Managing Pointers](pointer_maintenance.html#managing-pointers-to-static-content).
<br/>
This means that a number of scenarios outlined below around updating a Pointer can not yet be achieved though the NRLS intends to support these features in a future release. 
<br/>
Specifically the NRLS API does not currently support- <br/>

- The following status property transitions:<br/>

	&emsp; o **current** to **entered-in-error**<br/>
	&emsp; o **entered-in-error** to **current**<br/>
	&emsp; o **current** to **superseded** where the current Pointer is not being replaced.<br/>
	
- Modification of other properties<br/>
" %}


## Pointer Errors ##

The current version of the NRLS API does not give Providers the ability to update the properties of an existing Pointer, other than status . The status property is modified  in a very specific way by  only allowing a Provider to replace one document reference with another - see [Managing Pointers to static content](pointer_maintenance.html#managing-pointers-to-static-content.html). This means that a number of scenarios outlined below around updating a Pointer cannot yet be achieved though the NRLS intends to support these features in a future release. Specifically the NRLS API does not currently support -

- Modification of the status property – 
  - current to entered-in-error
  - entered-in-error to current
  - current to superseded where the current Pointer is not being replaced.
- Modification of other properties

## Pointer error handling ##

Errors happen. It is important to acknowledge this reality and to design a solution with this in mind. To that end the NRLS makes a distinction between the following kinds of error – 

- Errors with the Pointer
- Errors with the content that the Pointer references

## Errors with the Pointer ##

There are two routes by which incorrect data could find its way in to a Pointer – 
1.	Error with the data that the Provider system is using to create a Pointer
2.	Defect in the Provider system that is creating and publishing Pointers

These errors, however they have originated could lead to one of two situations – 
1.	The Pointer itself should not have been added to the NRLS
2.	It is valid for the Pointer to exist however there are problems with the data stored on a Pointer, for example the record creation date might be incorrect.
When the Provider realises that there is a problem with the Pointer then action must be taken by the Provider. Depending on the nature of the problem the Provider has different options when it comes to dealing with the issue.

### Pointer should not have been added to NRLS ###

In this case as soon as the issue is recognised the Provider should mark that Pointer’s status as entered-in-error.

Note that it is important to do this before that Pointer has been superseded as once that transition has been made it is not possible to mark a Pointer as entered-in-error - see [Pointer lifecycle](pointer_lifecycle.html). Only those Pointers with a status of current can be moved to the entered-in-error state.

If a Provider finds that one of their superseded Pointers should not have been registered with the NRLS then the entire lineage of that Pointer is considered corrupted. The Provider must mark the Pointer at the head of the lineage (i.e. the current Pointer) as being entered-in-error.

The Provider should then recreate the entire lineage missing out the erroneous Pointer.

### Pointer’s data is invalid ###

Where the presence of the Pointer on NRLS is valid but the data it holds is invalid then the Provider could choose to update the erroneous data in order to repair that Pointer. 

Each property on the Pointer is listed below along with a description of what action should be taken if the Provider finds a problem with that property. In most cases where the Pointer at fault is part of a lineage of related Pointers then the state of the other Pointers in the [lineage](pointer_lineage.html) should be taken in to account when deciding what changes to make .

| Property               | Notes |
|------------------------|-------|
| status      | The modification of status is restricted. See [Pointer lifecycle](pointer_lifecycle.html) |
| author      | If the DocumentReference is part of a lineage then the author should  be consistent |
| URL        | - |
| content type           | - |
| created           |If the  DocumentReference is part of a lineage then the new date should not be before the created date of any of the previous Pointers in the lineage |


<b>Table 1: Mutable properties.</b> These properties can be changed without the need to create a new Pointer.

| Property               | Notes |
|------------------------|-------|
| patient      | If the Pointer is not part of a lineage then mark it as entered-in-error and create a new Pointer that is associated with the correct Patient. <br><br>If the Pointer is part of a lineage then mark it as entered-in-error and create a new lineage that mirrors the existing one however the Pointers will now be  associated with the correct Patient.|
| type      | If the Pointer is not part of a lineage then mark it as entered-in-error and create a new Pointer that is associated with the correct type. <br><br>If the Pointer is part of a lineage then mark it as entered-in-error and create a new lineage that mirrors the existing one however the Pointers will now be  associated with the correct type. |
| related       | Where the relationship is one of replacement the following advice applies: <br><br>Mark the Pointer (A) as entered-in-error and create a new Pointer (B) that is related to the correct Pointer. <br><br>The Pointer (C) that was originally (and incorrectly)  replaced by A will be incorrectly marked as having been replaced. <br><br>Create a new Pointer that is largely identical to C except its status will be “current”. <br><br>If C was part of a lineage create a new lineage that mirrors the existing one.|

<b>Table 2: Immutable properties.</b> These properties cannot be changed on an existing Pointer. Instead a new Pointer must be created.

## Errors with the content that the Pointer references ##

The Provider should correct the content using whatever local processes are in place. This may necessitate the creation of a new version of the content in which case it may be appropriate to replace the current Pointer with a new one or the correction to the content may be such that the existing Pointer transparently references the corrected content. In either case responsibility for ensuring that the referenced content is correct rests with the Provider.










