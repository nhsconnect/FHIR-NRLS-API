---
title: Solution Behaviour
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_behaviours.html
summary: Solution Behaviour
---

## Behaviour

The NRL has been designed around the Pointer as the fundamental unit. Both Providers and Consumers deal exclusively with Pointers. However, Provider and Consumer roles have different capabilities when it comes to Pointer manipulation.

A Provider can be thought of as a system that has **write access** to the NRL, to support Pointer maintenance.

A Consumer can be thought of as a system that has **read access** to the NRL, to facilitate the retrieval of Pointers that are of interest to the Consuming system.

<img alt="Consumer API includes functionality such as basic read and search; Provider API includes functionality such as create, supersede, update, and delete" src="images/solution/Solution_Behaviour_diagram.png" style="width:100%;max-width: 100%;">

A system can be assured as both a Consumer and a Provider, provided that all relevant pre-requisites and requirements are met.

### Identity on the NRL

Each client system will be given an Accredited System ID (ASID) by NHS Digital. Each ASID will be associated with one or more interaction IDs. An interaction ID defines an action that can be performed against NRL (for example, creating a new DocumentReference). As part of a request, a client will supply its ASID and the interaction ID that relates to the action that it is trying to perform. If the interaction ID is not associated with the client's ASID, the request will be blocked.

### Pointer maintenance by Providers

If a client system is in the Provider role, it can create, supersede, update, and delete Pointers. When it comes to the modification of existing Pointers, the Provider is only permitted to change Pointers that it owns. The concept of ownership is carried on the Pointer itself and is again centered around the ODS code. The client can modify a Pointer as long as it satisfies the following two conditions:
* The ASID of the client system verifies that the client has the Provider role.
* The ODS code associated with that ASID matches the owner’s ODS code found on the Pointer.

To manipulate a Pointer, a Provider must know the logical identifier _or_ the master identifier of that Pointer. The logical identifier is an NRL-generated value that uniquely identifies a Pointer within an instance of the NRL. The master identifier is a unique identifier for the pointer which is under the control of the Provider. See the [Pointer Identity page](pointer_identity.html) for more details on identifiers.

### Pointer retrieval by Consumers

Consumer NRL interactions are read only. A system can search for a collection of pointers or retrieve a single pointer by logical identifier. 

The NRL search interaction is predicated on the Consumer having a verified NHS number prior to retrieving Pointers. See the [Personal Demographics Service page](integration_personal_demographics_service.html) for more details on NHS number verification.

Once the Consumer has a verified NHS number, the NRL can be asked to retrieve a collection of all "current" Pointers that relate to that NHS number. The NRL looks for Pointers for which the Subject (Patient) property matches the NHS number query parameter. On this basis, the NRL will return a collection of zero or more matching Pointers. See the [search interaction page](api_interaction_search.html) for more details.

In order to retrieve a single pointer using the read interaction, the Consumer must know the logical identifier of the pointer. See the [read interaction page](api_interaction_read.html) for more details.

### Record retrieval by Consumers

The NRL does not take part in Record retrieval. The Pointers it holds can be seen as signposts that show the way. Retrieval of referenced documents and records can be facilitated by the Spine Secure Proxy (SSP).

The SSP is a forward HTTP proxy which is used as a front-end to control and protect access to Provider IT systems that will be exposing Records in a standards-compliant way. It provides a single security point for both authentication and authorisation for systems. More details on how document/record retrieval can be facilitated by the SSP can be found on the [retrieval overview page](retrieval_overview.html).

## Auditing
The NRL and the SSP will capture an audit trail for each request-response interaction that a client (Consumer or Provider) has with the system. Once captured, the audit trail can be retrieved.

### Capturing an audit trail
The audit trail begins with capturing key data from a client request, and it ends with capturing the NRL's response to that request. The request audit trail and response audit
trail will be combined to form a full end-to-end audit of a given request and response interaction with the NRL.

An audit trail will capture different information about who or what is making the request, depending on whether the client is a person or a system. An example of the latter case is a Provider periodically running a batch job to synchronise its Pointers to the NRL. When capturing the audit trail, the system needs to be aware of this difference. The audit capability treats the user ID as an optional field in some circumstances: namely, in the context of a Provider reading, searching, creating, updating, or deleting its Pointers. It is never optional in a Consumer context. If the user ID is available, the guidance is that it should always be provided, regardless of whether the client is a Provider or a Consumer.

Details on the audit requirements for Consumers and Providers can be found on the [auditing page](integration_auditing.html).

### Retrieving an audit trail

Providers can retrieve the following two types of audit trail data from NHS Digital:
* All audit trails for a given patient (identified by their NHS number)
* All audit trails for the Pointers the Provider owns

In either case, the Provider is permitted to view audit trail information only for Pointers that it owns and maintains.
