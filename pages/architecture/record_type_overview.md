---
title: Record Type Overview
keywords: engage about
tags: [overview]
sidebar: overview_sidebar
permalink: record_type_overview.html
summary: A overview of patient record types that can be made available via NRL
---

{% include warning.html content="NEW PAGE" %}

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