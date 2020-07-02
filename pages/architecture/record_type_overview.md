---
title: Record Type Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: record_type_overview.html
summary: A overview of patient record types that can be made available via NRL
---

## Types of Data

Observations/vaccinations/Contact details/etc.

A Record exists on a remote system and collects together related data into a logical grouping. 

### Static/Dynamic

The NRL also acknowledges that there is a difference to be drawn between how the contents of a Record can change over time (see the [Record creation datetime](overview_data_model.html#data-model) field on Pointer). To the NRL a **static** Record is one whose contents will never change whereas a **dynamic** Record’s contents are not guaranteed to be the same from one point in time to another in the future.


## Retrieval Types

Un-structured/ Structured

Records come in a variety of formats but the NRL broadly makes a distinction based on the notion of **structured** and **unstructured** Records. Structured Records are made up of clearly defined data types whose composition makes them relatively easy to manipulate. Contrast this with unstructured Records which crudely could be said to be “everything else” and are comprised of data that is usually not as easy to manipulate.


### Retrieval Formats

FHIR / PDF / HTML web page



## ------------------------

## From other pages to incorporate

## Principles

### The NRL supports varying levels of digital maturity

The NRL recognises that there exist varying levels of digital maturity across Providers and Consumers. The format and method of retrieval for a Record are under the control of the Provider system. Currently, two record retrieval scenarios are envisaged:

- A Provider exposes a Record for direct retrieval, such that using the context available in the Pointer, a Consumer can retrieve the Record electronically. 
- A Provider exposes a set of contact details that a Consumer can use to retrieve the Record. The Consumer does not retrieve the Record electronically. Instead, they use the contact details as an intermediate step to get to the Record, such as by phoning a healthcare service found in the contact details, who can then relay the Record to the Consumer by other means.

### Records should be exposed using national standards

To enable Consumers to retrieve records with minimal custom integration between Consumer and Provider systems, records should be exposed using national standards. 

The NRL defines a [Read interaction](retrieval_interaction_read.html) for retrieval of a record via the SSP, which enables a retrieval of records using a standard HTTP GET interaction for a set of specified formats and data structures. There may be exceptions where record retrieval takes place using an alternative retrieval mechanism. 

The pointer model includes a 'Record format' metadata attribute, which describes the technical structure of the record and the mechanism for retrieval. The set of supported formats for retrieval is described on the [retrieval formats page](retrieval_formats.html).

### The NRL does not guarantee that Records can be retrieved by following a Pointer

There are complexities associated with retrieving data over a network that are outside of the scope of the metadata captured by a Pointer. As an example, consider the need to define firewall rules to allow traffic to flow between a Consumer and a Provider. The NRL aims to facilitate record retrieval through the [SSP Read Interaction](retrieval_interaction_read.html), reducing the need for point-to-point integration between Consumer and Provider systems. However, Providers have a responsibility to ensure that Pointer metadata accurately reflects the retrieval mechanism and format of the referenced document/record.

### The Consumer controls Pointer access

When a Consumer requests that the NRL return the Pointers that it has for a given patient (NHS number) it will return all Pointers. The NRL will not perform any filtering before sending that collection of Pointers back to the Consumer. 

Once consequence of this is that the end user on the Consumer side may be exposed to Pointers that reveal sensitive information about the Patient, for example it will be possible to infer through a Pointer that a Patient has a certain kind of record. Even though the user may not be able to retrieve the Record, knowing that it exists is in itself revealing a degree of personal information about that patient that may not be appropriate.

With this in mind, there will most likely be a need to filter Pointers before they are displayed to the end user. This responsibility belongs to the Consumer and should be implemented using local access rules to judge whether a given user should be permitted to know that a given Pointer exists. This is in addition to the RBAC requirements for NRL (see the [Authentication & Authorisation page](integration_authentication_authorisation.html)).

The mechanism for making this decision is predicated on the [Record type](overview_data_model.html#data-model) that the Pointer references.

### Pointers should not be removed

In part, the NRL is there to track the evolution of a Pointer’s content. This is important so that the NRL can support the retrieval 
of historical Pointers for medico-legal use cases. To that end, the deletion of a Pointer should be avoided, 
though the NRL does provide a delete function to cover circumstances in which deletion of a Pointer may be unavoidable. 
More information is provided on the [Pointer maintenance page](pointer_maintenance.html).

### Caching and Storing

It is important that consumers of NRL Pointers can view and make clinical decisions based on the most up-to-date information available. For this reason, NRL recommends that Pointers and referenced content returned from search and read requests not be cached or stored.
