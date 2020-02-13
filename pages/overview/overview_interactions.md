---
title: Solution Interactions
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_interactions.html
summary: Getting involved with NRL
---

## Interactions

There are three main types of systems that need to integrate in order to share data with the NRL.

| System | Role in NRL | 
|-----------|----------------|
|Consumer|A system that wishes to retrieve Pointers related to a given patient by NHS number and optionally follow one or more of those Pointers to retrieve the record to which it points.|
|Provider|A system that wishes to expose its Records for sharing.|
|NRL|A system that stores and provides access to Pointers for retrieval and maintenance.|

### Provider Interactions

A Provider is responsible for maintaining a set of Pointers. This involves creating, replacing, updating, and deleting Pointers.

#### Pointer Creation

When a relevant event occurs within a Provider organisation, the Provider generates a Pointer referencing a record that the Provider wishes to expose to NRL Consumers.

Once generated, the Provider sends the Pointer to the [create interaction](api_interaction_create.html) exposed by the NRL maintenance interface.

After successfully persisting the Pointer, the NRL informs the Provider client of this in the returned response, which includes the address of the new Pointer.

If any problems prevent the Pointer from being created, the NRL will inform the client of this in the returned response.

#### Pointer Replacement

When an event occurs within a Provider organisation that requires a Pointer's metadata, such as the record URL, to be updated on the NRL, the Provider should create a new pointer with the updated metadata which supersedes (replaces) the existing pointer. This can be done using the [create (supersede) interaction](api_interaction_supersede.html), creating a new pointer that references the superseded pointer using the 'Related document' metadata item.

The creation of the new pointer with the 'Related document' metadata item will consequently update the existing Pointer to change the status to "superseded" and increment the pointer version. The superseded pointer will no longer be available to Consumers. 

After successfully persisting the Pointer, the NRL will inform the Provider client of this in the returned response which will include the address of the new Pointer.

If there were any problems that meant the Pointer could not be created, the NRL will inform the client of this in the returned response. In the case of an error occuring, all updates to the superseded pointer will be rolled back. 

#### Pointer Update

When an error is identified with a Pointer that means it should not exist on NRL, whether the error concerns the pointer metadata or the referenced record itself, the Provider should update the pointer status to "entered-in-error".

The Provider does this using the [update interaction](api_interaction_update.html) that is exposed on the NRL maintenance interface.

After successfully updating the Pointer, the NRL will inform the Provider client of this in the returned response, and the updated pointer will no longer be available to Consumers.

If there were any problems that meant the Pointer could not be updated, the NRL will inform the client of this in the returned response.

#### Pointer Removal

When an event occurs within a Provider organisation that requires the removal of an existing Pointer from the NRL the Provider uses the [delete interaction](api_interaction_delete.html) exposed in the NRL maintenance interface, passing it the address of the Pointer to be removed.

After successfully deleting the Pointer, the NRL will inform the Provider client of this in the returned response, and the deleted pointer will no longer be available to Consumers.

If there were any problems that meant the Pointer could not be removed, the NRL will inform the client.

### Consumer Interactions

Consumers can retrieve pointers using the search or read interactions. Only pointers with the status of "current" can be retrieved by Consumers.

#### Read Pointer

A Consumer can perform a [read interaction](api_interaction_read.html) to retrieve a single pointer by its logical identifier. 

#### Pointer Search

A Consumer can perform parameterised searches of the Pointers held within the NRL using a [search interaction](api_interaction_search.html):

- A Consumer can ask the NRL to return all Pointers that relate to a given patient by supplying the NHS number of that patient.
- A Consumer can combine the Patient search parameter with the ODS code of the organisation that owns a Pointer to further narrow the search space.
- The NRL also allows searching by logical ID. This uniquely identifies a Pointer and is similar to the `read` interaction, but returns the relevant Pointer wrapped in a [FHIR bundle](https://www.hl7.org/fhir/bundle.html).
