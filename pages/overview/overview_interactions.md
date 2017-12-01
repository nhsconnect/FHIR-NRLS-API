---
title: Solution Interactions
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_interactions.html
summary: Getting involved with NRLS
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


## Interactions ##

In the overall solution for NRLS broadly speaking there are four main systems that need to integrate in order for systems to share data. Diagram 1


| System | Role in NRLS solution | 
|-----------|----------------|
|Consumer|A system that wishes to retrieve Pointers related to a given patient (NHS number) and optionally follow one or more of those Pointers to retrieve the record that they each point to.|
|Provider|A system that wishes to expose its Records for sharing.|
|NRLS|A system that exposes Pointers for retrieval and maintenance.|
|Spine Security Proxy (SSP)|Facilitates the retrieval of Records referenced by Pointers.|


### Provider interaction ###

<img src="images/solution/Provider_interaction_diagram.png" style="width:100%;max-width: 100%;">

### Consumer interaction ###

<img src="images/solution/Consumer_interaction_diagram.png" style="width:100%;max-width: 100%;">