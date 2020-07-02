---
title: Technical Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: technical_overview.html
summary: A technical overview of how NRL works
---


## Architectural Pattern

Pointers, actors and components


The NRL is based on a `Registry-Repository pattern`, which separates the storage and retrieval of a record from data that describes its location. 

<img alt="Consumer queries NRL to get Pointer, then uses pointer to retrieve Record from Provider" src="images/solution/Solution_Concepts_diagram.png" style="width:100%;max-width: 100%;">

The **NRL** is acting as a registry with the repository function carried out by so-called **Providers**. Providers are systems external to the NRL that expose records for retrieval. Pointers are created by Providers to signpost a record that is intended to be exposed for retrieval. 

**Pointers** are really at the core of the NRL. The NRL can be thought of as a collection of Pointers. Each Pointer describes how to retrieve a particular record from the Provider’s system or repository. It is key to the success of the NRL that Pointers are accurate. It is the responsibility of Providers to create and manage Pointers on the NRL in order to maintain this accuracy. 

Accuracy is important from the perspective of those systems who wish to understand what records are available and from there may wish to retrieve records from the Provider. This category of actor is known as a **Consumer**. Without accurate Pointer data the Consumer’s life is made harder as they cannot be assured that a given Pointer describes what it purports to.

The NRL does not take part in Record retrieval. The actual retrieval of the Record referenced by a given Pointer can be facilitated by the **Spine Security Proxy (SSP)**. 

The NRL actors are summarised [here](overview_interactions.html#interactions).

## Providers

Expose information
- contact details
- clinical records
- care plans
- etc.

Create Pointers on NRL


## Consumers

What they do and what they get from it




## ------------------------


## From other pages to include


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


## ------------------------

The NRL has been designed around the Pointer as the fundamental unit. Both Providers and Consumers deal exclusively with Pointers. However, Provider and Consumer roles have different capabilities when it comes to Pointer manipulation.

A Provider can be thought of as a system that has **write access** to the NRL, to support Pointer maintenance.

A Consumer can be thought of as a system that has **read access** to the NRL, to facilitate the retrieval of Pointers that are of interest to the Consuming system.

<img alt="Consumer API includes functionality such as basic read and search; Provider API includes functionality such as create, supersede, update, and delete" src="images/solution/Solution_Behaviour_diagram.png" style="width:100%;max-width: 100%;">

A system can be assured as both a Consumer and a Provider, provided that all relevant prerequisites and requirements are met.

### Identity on the NRL

Each client system will be given an Accredited System ID (ASID) by NHS Digital. Each ASID will be associated with one or more interaction IDs. An interaction ID defines an action that can be performed against NRL (for example, creating a new DocumentReference). As part of a request, a client will supply its ASID and the interaction ID that relates to the action that it is trying to perform. If the interaction ID is not associated with the client's ASID, the request will be blocked.

### Pointer Maintenance by Providers

If a client system is in the Provider role, it can create, supersede, update, and delete Pointers. When it comes to the modification of existing Pointers, the Provider is only permitted to change Pointers that it owns. The concept of ownership is carried on the Pointer itself and is again centered around the ODS code. The client can modify a Pointer as long as it satisfies the following two conditions:
* The ASID of the client system verifies that the client has the Provider role.
* The ODS code associated with that ASID matches the owner’s ODS code found on the Pointer.

To manipulate a Pointer, a Provider must know the logical identifier _or_ the master identifier of that Pointer. The logical identifier is an NRL-generated value that uniquely identifies a Pointer within an instance of the NRL. The master identifier is a unique identifier for the pointer which is under the control of the Provider. See the [Pointer Identity page](pointer_identity.html) for more details on identifiers.

### Pointer Retrieval by Consumers

Consumer NRL interactions are read only. A system can search for a collection of pointers or retrieve a single pointer by logical identifier. 

The NRL search interaction is predicated on the Consumer having a verified NHS number prior to retrieving Pointers. See the [Personal Demographics Service page](integration_personal_demographics_service.html) for more details on NHS number verification.

Once the Consumer has a verified NHS number, the NRL can be asked to retrieve a collection of all "current" Pointers that relate to that NHS number. The NRL looks for Pointers for which the Subject (Patient) property matches the NHS number query parameter. On this basis, the NRL will return a collection of zero or more matching Pointers. See the [search interaction page](api_interaction_search.html) for more details.

In order to retrieve a single pointer using the read interaction, the Consumer must know the logical identifier of the pointer. See the [read interaction page](api_interaction_read.html) for more details.

### Record Retrieval by Consumers

The NRL does not take part in Record retrieval. The Pointers it holds can be seen as signposts that show the way. Retrieval of referenced documents and records can be facilitated by the Spine Secure Proxy (SSP).

The SSP is a forward HTTP proxy which is used as a front-end to control and protect access to Provider IT systems that will be exposing Records in a standards-compliant way. It provides a single security point for both authentication and authorisation for systems. More details on how document/record retrieval can be facilitated by the SSP can be found on the [retrieval overview page](retrieval_overview.html).

## Auditing
The NRL and the SSP will capture an audit trail for each request-response interaction that a client (Consumer or Provider) has with the system. Once captured, the audit trail can be retrieved.

### Capturing an Audit Trail
The audit trail begins with capturing key data from a client request, and it ends with capturing the NRL's response to that request. The request audit trail and response audit
trail will be combined to form a full end-to-end audit of a given request and response interaction with the NRL.

An audit trail will capture different information about who or what is making the request, depending on whether the client is a person or a system. An example of the latter case is a Provider periodically running a batch job to synchronise its Pointers to the NRL. When capturing the audit trail, the system needs to be aware of this difference. The audit capability treats the user ID as an optional field in some circumstances: namely, in the context of a Provider reading, searching, creating, updating, or deleting its Pointers. It is never optional in a Consumer context. If the user ID is available, the guidance is that it should always be provided, regardless of whether the client is a Provider or a Consumer.

Details on the audit requirements for Consumers and Providers can be found on the [auditing page](integration_auditing.html).

### Retrieving an Audit Trail

Providers can request the following two types of audit trail data from NHS Digital:
* All audit trails for a given patient (identified by their NHS number)
* All audit trails for the Pointers the Provider owns

In either case, the Provider is permitted to view audit trail information only for Pointers that it owns and maintains.
