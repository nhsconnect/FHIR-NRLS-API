---
title: Solution Behaviour
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_behaviours.html
summary: Solution Behaviour
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRL API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


## Behaviour ##

The NRL has been designed around the Pointer being the unit of currency. Both Providers and Consumers deal exclusively with Pointers. However the roles of Provider and Consumer have different capabilities when it comes to Pointer manipulation. 

A Provider can be thought of as a system that has <b>write access</b> to the NRL that is designed to support Pointer maintenance. 

A Consumer can be thought of as a system that has <b>read-access</b> to the NRL that is designed to facilitate the retrieval of Pointers that are of interest to the Consuming system.

<img src="images/solution/Solution_Behaviour_diagram.png" style="width:100%;max-width: 100%;">

### Identity on the NRL ###

The NRL has two roles – Provider and Consumer. A Consumer has a read-only role with the NRL and a Provider has a write-only role with the NRL. A system can be assured to be both a Consumer and a Provider, provided that all relevant pre-requisites and requirements are met.

Each client system will be given an Accredited System ID (ASID) by NHS Digital. Each ASID will be associated with one or more interaction IDs. An interaction ID defines an action that can be performed against NRL (for example creating a new DocumentReference). As part of a request, a client will supply thier ASID and the interaction ID that relates to the action that they are trying to perform. If the interaction ID is not associated with the client's ASID then the request will be blocked.

### Pointer maintenance by Providers ###

If a client system is in the Provider role then as already mentioned they are permitted to create new Pointers, replace, delete and update existing Pointers. Note that when it comes to the modification of existing Pointers the Provider is only permitted to change the Pointers that it owns. The concept of ownership is carried on the Pointer itself and is again centered around the ODS code. So long as the ASID of the client system puts the client in the Provider role and so long as the ODS code associated wth that ASID matches the owner’s ODS code found on the Pointer in question then the client can modify that Pointer.

In order to manipulate a Pointer a Provider must know the logical identifier or master identifier of that Pointer. The logical identifier is an NRL generated value that uniquely identifies a Pointer across an instance of the NRL. The master identifier is a unique identifier for the pointer which is under the control of the Provider. See the [Pointer Identity page](pointer_identity.html) for further detail on identifiers. 


### Pointer retrieval by Consumers ###

Consumer NRL interactions are read-only. A system can search for a collection of pointers or retrieve a single pointer by logical identifier. 

The NRL search interaction is predicated on the Consumer having a verified NHS number prior to retrieving Pointers. See the [Personal Demographics Service page](integration_personal_demographics_service.html) for further detail on NHS number verification.

Once the Consumer has a verified NHS number the NRL can be asked to retrieve a collection of all "current" Pointers that relate to that NHS number. The NRL looks for Pointer’s whose Subject (Patient) property matches the NHS number query parameter. On this basis the NRL will return a collection of zero or more matching Pointers. See the [search interaction page](api_interaction_search.html) for further detail. 

In order to retrieve a single pointer using the read interaction, the Consumer must know the logical identifier of the pointer. See the [read interaction page](api_interaction_read.html) for further detail. 

### Record retrieval by Consumers ###

The NRL does not take part in Record retrieval. The Pointers that is holds can be seen as signposts that show the way. Retrieval of referenced documents and records can be facilitated by the Spine Secure Proxy (SSP). 

Briefly, the SSP is a forward HTTP proxy which is used as a front-end to control and protect access to Provider IT systems that will be exposing Records in a standards compliant way. It provides a single security point for both authentication and authorisation for systems. Further detail on how document/record retrieval can be facilitated by the SSP can be found on the [retrieval overview page](retrieval_overview.html).

## Auditing ##
The NRL and the SSP will capture an audit trail for each request-response interaction that a client (Consumer or Provider) has with the system. Once captured the audit trail can be retrieved.

### Capturing an audit trail ###
The audit trail begins with capturing key data from a client request and it ends with capturing the NRL' response to that request. The request audit trail and response audit
trail will be combined to form a full end to end audit of a given request and response interaction with NRL.

An audit trail will capture different information about who or what is making the request depending on whether the client is a person or a system. In the latter case one can imagine a Provider may have a batch job that runs periodically to synchronise its Pointers in the NRL. In this case it cannot be assumed that there will be a person making the requests. Instead it may well be a system making the request. When capturing the audit trail the system needs to be aware of this difference. On that basis the audit capability views the user id as an optional piece of the audit data. Having said that the user id is optional in very specific circumstances; namely in the context of a Provider reading, searching, creating, updating or deleting their Pointers. It is not optional in a Consumer context. If the user ID is available then the guidance is that it should always be provided regardless of whether the client is a Provider or a Consumer.

Details on the audit requirements for Consumers and Providers can be found on the [auditing page](integration_auditing.html).

### Retrieving an audit trail ###
Providers are able to retrieve an audit trail from NHS Digital. Specifically they will be able to retrieve audit trail data in two different ways - 

1. By asking for all audit trails related to a given patient (identified by their NHS number)
2. By asking for all audit trails that relate to the Pointers that they own

In both cases it is important to understand that the Provider will not be able to view audit trail information that relates to Pointers other than the ones that they own and maintain.
