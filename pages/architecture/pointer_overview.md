---
title: Pointer Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: pointer_overview.html
summary: A technical overview the pointers
---

{% include warning.html content="NEW PAGE" %}

## What do pointers do


Pointers are associated with a Record. As noted, a Record exists in a remote system. One of the roles of the Pointer is to provide enough context to allow a Consumer to retrieve that Record from the remote system and display it.

The format and method of retrieval for a Record are under the control of the Provider system. It might be that the Provider has exposed the Record for direct retrieval, such that using the context available in the Pointer, a Consumer is able to retrieve the Record.

Alternatively, rather than point to an electronic copy of the Record, the Provider can expose a set of contact details that a Consumer can use to retrieve the Record. In this scenario, the Consumer is not retrieving the Record electronically. Instead, they are using the contact details as an intermediate step to get to the Record, perhaps by phoning a healthcare service found in the contact details who will then relay the Record to the Consumer via another mechanism.

<img alt="Pointers link to Records by providing either an API endpoint or contact details of the Provider" src="images/solution/Solution_Concepts_Pointer2_diagram.png" style="width:100%;max-width: 100%;">

The preceding diagram shows two Pointers that reference the same Record (Record A). The ways that they describe how to get the contents of Record A are different. In red is a Pointer that directly references the Provider’s API. In this example, following the Pointer will return the Record in electronic form direct from the Provider’s record store (green).

In contrast, the blue Pointer contains a set of contact details. A Consumer following this Pointer would begin their retrieval by dialling the telephone number detailed in the Pointer. This would begin a human-controlled process that would ultimately lead to Record A being retrieved for them. In this example, the person referenced by the contact details accesses Record A using the same API endpoint that the red Pointer references.


## What do pointers contain to allow them to do this

Broad Data items and what they are for
