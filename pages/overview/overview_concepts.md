---
title: Solution Concepts
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_concepts.html
summary: Solution Concepts
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop with the NRL API. This project is being developed using an agile methodology, so iterative updates to content will be added on a regular basis." %}


## Concepts

The NRL is based on the [Registry-Repository pattern](https://developer.nhs.uk/library/architecture/integration-patterns/registry-repository/), which separates the storage and retrieval of a record from data that describes its location. 

<img alt="Consumer queries NRL to get Pointer, then uses pointer to retrieve Record from Provider" src="images/solution/Solution_Concepts_diagram.png" style="width:100%;max-width: 100%;">

### Actors

The **NRL** is acting as a registry with the repository function carried out by so-called **Providers**. Providers are systems external to the NRL that expose records for retrieval. Pointers are created by Providers to signpost a record that is intended to be exposed for retrieval. 

**Pointers** are really at the core of the NRL. The NRL can be thought of as a collection of Pointers. Each Pointer describes how to retrieve a particular record from the Provider’s system or repository. It is key to the success of the NRL that Pointers are accurate. It is the responsibility of Providers to create and manage Pointers on the NRL in order to maintain this accuracy. 

Accuracy is important from the perspective of those systems who wish to understand what records are available and from there may wish to retrieve records from the Provider. This category of actor is known as a **Consumer**. Without accurate Pointer data the Consumer’s life is made harder as they cannot be assured that a given Pointer describes what it purports to.

The NRL does not take part in Record retrieval. The actual retrieval of the Record referenced by a given Pointer can be facilitated by the **Spine Security Proxy (SSP)**. 

The NRL actors are summarised [here](overview_interactions.html#interactions).

### Record

A Record exists on a remote system and collects together related data into a logical grouping. 

Records come in a variety of formats but the NRL broadly makes a distinction based on the notion of **structured** and **unstructured** Records. Structured Records are made up of clearly defined data types whose composition makes them relatively easy to manipulate. Contrast this with unstructured Records which crudely could be said to be “everything else” and are comprised of data that is usually not as easy to manipulate.

The NRL also acknowledges that there is a difference to be drawn between how the contents of a Record can change over time (see the [Record creation datetime](overview_data_model.html#data-model) field on Pointer). To the NRL a **static** Record is one whose contents will never change whereas a **dynamic** Record’s contents are not guaranteed to be the same from one point in time to another in the future.

### Pointer

Pointers are associated with a Record. As noted, a Record exists in a remote system. One of the roles of the Pointer is to provide enough context to allow a Consumer to retrieve that Record from the remote system and display it.

The format and method of retrieval for a Record are under the control of the Provider system. It might be that the Provider has exposed the Record for direct retrieval, such that using the context available in the Pointer, a Consumer is able to retrieve the Record.

Alternatively, rather than point to an electronic copy of the Record, the Provider can expose a set of contact details that a Consumer can use to retrieve the Record. In this scenario, the Consumer is not retrieving the Record electronically. Instead, they are using the contact details as an intermediate step to get to the Record, perhaps by phoning a healthcare service found in the contact details who will then relay the Record to the Consumer via another mechanism.

<img alt="Pointers link to Records by providing either an API endpoint or contact details of the Provider" src="images/solution/Solution_Concepts_Pointer2_diagram.png" style="width:100%;max-width: 100%;">

The preceding diagram shows two Pointers that reference the same Record (Record A). The ways that they describe how to get the contents of Record A are different. In red is a Pointer that directly references the Provider’s API. In this example, following the Pointer will return the Record in electronic form direct from the Provider’s record store (green).

In contrast, the blue Pointer contains a set of contact details. A Consumer following this Pointer would begin their retrieval by dialling the telephone number detailed in the Pointer. This would begin a human-controlled process that would ultimately lead to Record A being retrieved for them. In this example, the person referenced by the contact details accesses Record A using the same API endpoint that the red Pointer references.

<!--
Pointers are associated with a Record. As noted a Record exists in a remote system, one of the roles of the Pointer is to provide enough context to allow a Consumer to retrieve that Record from the remote system and display it.  

The NRL has two kinds of Pointer which are differentiated by the way they facilitate Record retrieval. A <b>direct</b> Pointer can be followed, and the expectation of the Consumer should be that the Record will be returned to them. An <b>indirect</b> Pointer is different. Following this kind of Pointer will not return the Record, instead it will present the Consumer with a further set of instructions that must be followed in order to retrieve the Record. Typically, this will be a set of contact details that must be used to request the Record, for example it might be the phone number of a healthcare service which can relay a Record’s contents over the phone.

<img src="images/solution/Solution_Concepts_Pointer_diagram.png" style="width:100%;max-width: 100%;">
-->