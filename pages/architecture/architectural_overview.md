---
title: Architectural Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: architectural_overview.html
summary: A architectural overview of how NRL works
---


The [NRL Introduction](index.html) gives a high level overview of the service and how it enables information sharing between providers and consumers. This page goes into more detail around the architecture of the NRL, the role of the providers and consumers, and how the NRL can be used to enable information sharing.


## Architectural Pattern

The NRL service is based on a `Registry-Repository` pattern which separates the storage and retrieval of information (the repository) from the data describing the location of the information (the registry). The **NRL** acts as the `registry` and the **Provider** carries out the `repository` function.

Providers are systems external to the NRL that expose information for retrieval, and create pointers on the NRL as a signpost to that information. The NRL can be thought of as a collection or index of pointers which are available to consumers. Consumers query the registry (NRL) to find out what repositories exist and how to access them.

<img alt="Consumer queries NRL to get Pointer, then uses pointer to retrieve Record from Provider" src="images/architecture/nrl_registry_repository.png" style="width:100%;max-width: 100%;">

Pointers are at the core of enabling information sharing, as they tell the consumer what type of information is available and how to get it. It is important that the providers keep their pointers up to date so that consumers can find and retrieve information correctly.

As the registry, the NRL does not take part in information retrieval. The retrieval interaction is between the consumer and provider, but may utilise other services such as the `Spine Secure Proxy (SSP)` to help with authentication and authorisation.


## NRL Interactions

The NRL exposes a number of different interactions which allows providers to maintain their pointers and consumers to search and retrieve pointers. Providers can be thought of as systems that have **write access** to the NRL, they can `create`, `update` and `delete` pointers. Consumers can be thought of as systems that have **read access** to the NRL, enabling them to `search` for and `read` pointers.

<img alt="Consumer API includes functionality such as basic read and search; Provider API includes functionality such as create, supersede, update, and delete" src="images/architecture/nrl_interface_interactions.png" style="width:100%;max-width: 100%;">

Even though conceptually a consumer and a provider are different, a system connected to the service may be both a consumer and a provider at the same time.


| Interaction | Description |
| --- | --- |
| [Create](api_interaction_create.html) | The `Create` interaction results in the creation of a pointer on NRL. <br/><br/>This interaction is triggered by the provider and is usually performed as a result of an event occurring within the provider system, such as some information being recorded in the patients record, a document being stored, a patient registering with the healthcare service. |
| [Create (Supersede)](api_interaction_supersede.html) | This interaction allows providers to create a new pointer which supersedes (replaces) one of their existing pointers. After storing the new pointer the NRL updates the status of the existing pointer to "superseded" and that superseded pointer is no longer available to Consumers.<br/><br>This interaction should be used where information on an existing pointer needs to be changed, for example when the retrieval URL needs changing or an additional supported retrieval format is added. |
| [Update](api_interaction_update.html) | The `Update` interaction allows a provider to remove one of their existing pointers from NRL while simultaniously flagging the pointer to indicate that an error was identified with the pointer or the information it references.<br/><br/>The interaction allows the Provider to update the pointer status to "entered-in-error" and the updated pointer will no longer be available to consumers. |
| [Delete](api_interaction_delete.html) | The `Delete` interaction allows a provider to remove one of their existing pointers from the NRL. |
| [Read](api_interaction_read.html) | The `Read` interaction allows a single pointer to be retrieved using its logical identifier. Only pointers with the status of "current" can be retrieved using the `Read` interaction. |
| [Search](api_interaction_search.html) | The `Search` interaction allows a consumer to perform a parameterised searches for pointers held on the NRL for a single patient. Only pointers with the status of "current" can be retrieved using the `Search` interaction |


## Information Retrieval

The NRL does not take part in the retrieval of information from providers. The pointers held with NRL and shared with consumers can be seen as signposts to where the information can be retreived. The retrieval of information is conducted between the consumer and provider, but may utilise other services such as the `Spine Security Proxy (SSP)` to help with authentication and authorisation. More detail on retrieval of information can be found on the [retrieval overview page](retrieval_overview.html).


## Auditing

The NRL will capture an audit trail for each interaction it has with any connected system (Consumer or Provider). This audit trail begins with capturing key data from the request, information around how the NRL processes the request and ends with capturing the response that the NRL sent back to the requesting system.

The providers and consumers are also required to cature audit information for interaction with NRL and sharing of information. Details of the audit requirements for consumers and providers can be found on the [Auditing](integration_auditing.html) page.

### Retrieving an Audit Trail

Providers can request the following two types of audit trail data from NHS Digital:
* All audit trails for a given patient (identified by their NHS number)
* All audit trails for the Pointers the Provider owns

In either case, the Provider is permitted to view audit trail information only for Pointers that it owns and maintains.
