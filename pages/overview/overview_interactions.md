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


### Provider interaction ###

A Provider is responsible for maintaining a set of Pointers. Concretely this involves creating and deleting Pointers.

#### Pointer creation ####

When an event occurs within a Provider organisation that requires the creation of a Pointer in the NRL the Provider assembles an instance of a Pointer that references a record that the Provider wishes to expose to NRL Consumers. 

Once assembled the Provider sends the Pointer to the create function that is exposed on the NRL maintenance interface. 

After successfully persisting the Pointer the NRL will return the address of the new Pointer to the Provider client.

#### Pointer removal ####

When an event occurs within a Provider organisation that requires the removal of an existing Pointer from the NRL the Provider uses the remove function that is exposed in the NRL maintenance interface passing it the address of the Pointer that is to be removed.

If there were any problems that meant the Pointer could not be removed the NRL will inform the client otherwise the client should assume that the Pointer has been successfully removed.


<img src="images/solution/Provider_interaction_diagram.png" style="width:100%;max-width: 100%;">

### Consumer interaction ###

A Consumer can only read Pointers from the NRL. The NRL allows a Consumer to perform parameterised searches of the Pointers held within the NRL:

- A Consumer can ask the NRL to return all Pointers that relate to a given patient by supplying the NHS number of that patient. 
- A Consumer can also combine the Patient search parameter with the ODS code of the organisation that owns a Pointer to further narrow the search space. 
- The NRL exposes a search using the identifier of a Pointer. In this instance the Consumer is asking for a specific Pointer instance to be returned.


<br/>


<img src="images/solution/Consumer_interaction_diagram.png" style="width:100%;max-width: 100%;">