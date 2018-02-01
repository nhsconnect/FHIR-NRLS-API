---
title: Solution Concepts
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_concepts.html
summary: Solution Concepts
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


## Concepts ##

The NRLS is based on the [Registry-Repository:](https://developer.nhs.uk/library/architecture/integration-patterns/registry-repository/) pattern which separates the storage and retrieval of a record from data that describes its location. 


<img src="images/solution/Solution_Concepts_diagram.png" style="width:100%;max-width: 100%;">




### Actors ###

The <b>NRLS</b> is acting as a registry with the repository function carried out by so-called <b>Providers</b>. Providers are systems external to the NRLS that expose records for retrieval. Pointers are created by Providers to signpost a record that is intended to be exposed for retrieval. 

<b>Pointers</b> are really at the core of the NRLS. The NRLS can be thought of as a collection of Pointers. Each Pointer describes how to retrieve a particular record from the Provider’s system or repository. It is key to the success of the NRLS that Pointers are accurate. It is the responsibility of Providers to create and manage Pointers on the NRLS in order to maintain this accuracy. 

Accuracy is important from the perspective of those systems who wish to understand what records are available and from there may wish to retrieve records from the Provider. This category of actor is known as a <b>Consumer</b>. Without accurate Pointer data the Consumer’s life is made harder as they cannot be assured that a given Pointer describes what is purports to.

The NRLS does not take part in Record retrieval. The actual retrieval of the Record referenced by a given Pointer can be facilitated by the <b>Spine Security Proxy (SSP)</b>. 

The NRLS actors are summarised [here](overview_interactions.html#interactions).

### Record ###

A Record exists on a remote system and collects together related data into a logical grouping. 

Records come in a variety of formats but the NRLS broadly makes a distinction based on the notion of <b>structured</b> and <b>unstructured</b> Records. Structured Records are made up of clearly defined data types whose composition makes them relatively easy to manipulate. Contrast this with unstructured Records which crudely could be said to be “everything else” and are comprised of data that is usually not as easy to manipulate.

 <!--whose composition makes them easily searchable. -->

The NRLS also acknowledges that there is a difference to be drawn between how the contents of a Record can change over time (see the [Record creation datetime](overview_data_model.html#data-model) field on Pointer). To the NRLS a <b>static</b> Record is one whose contents will never change whereas a <b>dynamic</b> Record’s contents is not guaranteed to be the same from one point in time to another in the future.

### Pointer ###

Pointers are associated with a Record. As noted a Record exists in a remote system, one of the roles of the Pointer is to provide enough context to allow a Consumer to retrieve that Record from the remote system and display it.  

The NRLS has two kinds of Pointer which are differentiated by the way they facilitate Record retrieval. A <b>direct</b> Pointer can be followed, and the expectation of the Consumer should be that the Record will be returned to them. An <b>indirect</b> Pointer is different. Following this kind of Pointer will not return the Record, instead it will present the Consumer with a further set of instructions that must be followed in order to retrieve the Record. Typically, this will be a set of contact details that must be used to request the Record, for example it might be the phone number of a healthcare service which can relay a Record’s contents over the phone.


<img src="images/solution/Solution_Concepts_Pointer_diagram.png" style="width:100%;max-width: 100%;">
