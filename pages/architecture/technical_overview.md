---
title: Technical Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: technical_overview.html
summary: A technical overview of how NRL works
---

{% include warning.html content="NEW PAGE" %}

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

