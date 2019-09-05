---
title: Solution Interactions
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_interactions.html
summary: Getting involved with NRL
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRL API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


## Interactions ##

In the overall solution for NRL broadly speaking there are three main systems that need to integrate in order for systems to share data.


| System | Role in NRL solution | 
|-----------|----------------|
|Consumer|A system that wishes to retrieve Pointers related to a given patient (NHS number) and optionally follow one or more of those Pointers to retrieve the record that they each point to.|
|Provider|A system that wishes to expose its Records for sharing.|
|NRL|A system that exposes Pointers for retrieval and maintenance.|


### Provider Interactions ###

A Provider is responsible for maintaining a set of Pointers. This involves creating, replacing, updating and deleting Pointers.

#### Pointer creation ####

When an event occurs within a Provider organisation that requires the creation of a Pointer in the NRL the Provider assembles an instance of a Pointer that references a record that the Provider wishes to expose to NRL Consumers. 

Once assembled the Provider sends the Pointer to the [create interaction](api_interaction_create.html) that is exposed on the NRL maintenance interface. 

After successfully persisting the Pointer, the NRL will return the address of the new Pointer to the Provider client.

If there were any problems that meant the Pointer could not be created the NRL will inform the client, otherwise the client should assume that the Pointer has been successfully created.

#### Pointer replacement ####

When an event occurs within a Provider organisation that requires a Pointer's metadata to be updated on the NRL, such as the record URL, the Provider should create a new pointer with the updated metadata which supersedes (replaces) the existing pointer. This can be done using the [create (supersede) interaction](api_interaction_supersede.html), to create a new pointer that references the pointer to replace using the 'Related document' metadata item. 

The creation of the new pointer with the 'Related document' metadata item will consequently update the existing Pointer to change the status to "superseded" and increment the pointer version. The superseded pointer will no longer be available to Consumers. 

After successfully persisting the superseding Pointer, the NRL will return the address of the new Pointer to the Provider client.

If there were any problems that meant the Pointer could not be replaced the NRL will inform the client, otherwise the client should assume that the existing pointer has been successfully updated and the new Pointer has been successfully created. In the case of any error occuring, all updates to the superseded pointer will be rolled back. 

#### Pointer update ####

When an error is identified with a Pointer which ascertains that it should not exist on NRL, whether the error on the pointer metadata or is with the referenced record itself, the Provider should update the pointer status to "entered-in-error". 

The Provider does this using the [update interaction](api_interaction_update.html) that is exposed on the NRL maintenance interface.

If there were any problems that meant the Pointer could not be updated the NRL will inform the client, otherwise the client should assume that the Pointer has been successfully updated. The updated pointer will no longer be available to Consumers. 

#### Pointer removal ####

When an event occurs within a Provider organisation that requires the removal of an existing Pointer from the NRL the Provider uses the [delete interaction](api_interaction_delete.html) that is exposed in the NRL maintenance interface passing it the address of the Pointer that is to be removed.

If there were any problems that meant the Pointer could not be removed the NRL will inform the client, otherwise the client should assume that the Pointer has been successfully deleted. The deleted pointer will no longer be available to Consumers. 

### Consumer Interactions ###

A Consumer is able to retrieve pointers using the search or read interaction. Only pointers with the status of "current" can be retrieved by Consumers. 

#### Read pointer ####

A Consumer can perform a [read interaction](api_interaction_read.html) to retrieve a single pointer by its logical identifier. 

#### Pointer search ####

A Consumer can perform parameterised searches of the Pointers held within the NRL:

- A Consumer can ask the NRL to return all Pointers that relate to a given patient by supplying the NHS number of that patient. 
- A Consumer can also combine the Patient search parameter with the ODS code of the organisation that owns a Pointer to further narrow the search space. 
- The NRL exposes a search using the identifier of a Pointer. In this instance the Consumer is asking for a specific Pointer instance to be returned.

