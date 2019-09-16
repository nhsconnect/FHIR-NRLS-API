---
title: Solution Principles
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_principles.html
summary: Solution Principles
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRL API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


## Principles ##

<!--
### The NRL defines a controlled scope around record retrieval ###

One of the key capabilities of the NRL is to provide enough context in a Pointer to allow a Consumer to retrieve the Record that it relates to. Clearly there are a myriad of different ways that data can be exposed for consumption and providing a context model that is capable of describing all of these options is a non-trivial task.  
With this complexity in mind the NRL has taken the decision to place some control around how Providers are expected to expose their Records if they are to be described by a Pointer.  
In the first instance the NRL mandates a single access mechanism; a HTTPS GET to retrieve a Record. Over time the ambition is that NRL will support other access mechanisms but in the short term the above restriction should be seen as a tactical solution designed to allow the NRL to concentrate on delivering value based on what is known today.
Clearly issuing a GET to retrieve a record is only one part of the task. Accessing records in a secure fashion is also an important consideration. Again, just as there are many ways to expose a Record, there are many ways to securely expose a Record. Taking a similar tack, the NRL is predicated around the principle of placing a degree of control over how Providers securely expose their Records for consumption via a Pointer. The mechanism that has been selected in the first instance is mutual authentication over HTTPS. More detail can be found in the security section. Again as with the control around the mechanism of Record retrieval, the NRL sees the use of mutual authentication as the initial offering, the ambition is to increase the supported security models as more information is gathered.
-->

### The NRL supports varying levels of digital maturity ###

The NRL recognises that there will be varying levels of digital maturity across Providers and Consumers. The format of and way that a Record can be retrieved are under the control of the Provider system. At this stage 2 record retrieval scenarios are envisaged: 

- A Provider exposes a Record for direct retrieval such that using the context available in the Pointer, a Consumer is able to retrieve the Record by electronic means. 
- A Provider exposes a set of contact details that a Consumer can use to retrieve the Record. The Consumer does not retrieve the Record electronically, instead they use the contact details as an intermediate step to get to the Record e.g. by phoning a healthcare service found in the contact details, who then can relay the Record to the Consumer via another mechanism.

### Records should be exposed using National Standards ###

To enable Consumers to retreive records with minimal custom integration between Consumer and Provider systems, records should be exposed using national standards. 

The NRL defines a [Read interaction](retrieval_interaction_read.html) for retrieval of a record via the SSP, which enables a retrieval of records using a standard HTTP GET interaction for a set of specified formats and data structures. There may be exceptions where record retrieval takes place using an alternative retrieval mechanism. 

The pointer model includes a 'Record format' metadata attribute, which describes the technical structure of the record and the mechanism for retrieval. The set of supported formats for retrieval is described on the [retrieval formats page](retrieval_formats.html).

### The NRL does not guarantee that Records can be retrieved by following a Pointer ###

There are the complexities associated with retrieving data over a network that are outside of the scope of the meta data that will be captured by a Pointer. As an example, consider the need to define firewall rules to allow traffic to flow between a Consumer and a Provider. The NRL aims to facilitate record retrieval through the [SSP Read Interaction](retrieval_interaction_read.html), reducing the need for point to point integration between Consumer and Provider systems. However, Providers have a responsibility to ensure that Pointer metadata accurately reflects the retrieval mechanism and format of the referenced document/record. 

### The Consumer controls Pointer access ###

When a Consumer requests that the NRL return the Pointers that it has for a given patient (NHS number) it will return all Pointers. The NRL will not perform any filtering before sending that collection of Pointers back to the Consumer. 

Once consequence of this is that the end user on the Consumer side may be exposed to Pointers that reveal sensitive information about the Patient, for example it will be possible to infer through a Pointer that a Patient has a certain kind of record. Even though the user may not be able to retrieve the Record, knowing that it exists is in itself revealing a degree of personal information about that patient that may not be appropriate. 
With this in mind it is acknowledged that there is most likely going to be a need to filter Pointers before they are displayed to the end user. This responsibility is seen as belonging to the Consumer where local access rules will be used to judge whether or not a given user should be permitted to know that a given Pointer exists. This is in addition to the RBAC requirements for NRL (see the [Authentication & Authorisation page](integration_authentication_authorisation.html)).

The mechanism for making this decision is predicated on the [Record type](overview_data_model.html#data-model) that the Pointer references. 

### Pointers should not be removed ### 

In part the NRL is there to track the evolution of a Pointer’s content. This is important so that the NRL can support the retrieval 
of historical Pointers for medico-legal use cases. To that end the deletion of a Pointer should be avoided. 
Though the NRL does provide a delete function as in some circumstances deletion of a Pointer may be unavoidable. 
More information is provided in [Pointer maintenance page](pointer_maintenance.html).

### Caching and Storing ###

It is important that consumers of NRL pointers are able to view and make clinical decisions based on the most up to date information available. For this reason NRL recommends that pointers and referenced content returned from search and read requests should not be cached or stored. 