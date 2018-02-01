---
title: Solution Data Model
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_data_model.html
summary: Solution Data Model
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


## Data model ##

In order to support the Consumer and Provider interactions with the NRLS the Pointer has been distilled into a data model. The data model is purposefully lean, each property has a clear reason to exist and it directly supports the activities of the Consumer and/or Provider.


| Property | Cardinality | Description | 
|-----------|----------------|------------|
|Identifier|0..1|Assigned by the NRLS at creation time. Uniquely identifies this record within an instance of the NRLS. Used by Providers to update or delete.|
|Version |0..1|Assigned by the NRLS at creation or update time. Used to track the current version of a Pointer.|
|Patient|1..1|The Patient that the record referenced by this Pointer relates to. Supports Pointer retrieval scenarios.|
|Pointer owner|1..1|The entity who maintains the Pointer. Used to control which systems can modify the Pointer|
|Record owner|1..1|The entity who maintains the Record. Used to provide the Consumer with context around who they will be interacting with if retrieving the Record.|
|Record creation datetime|0..1|The date and time (on the Provider’s system) that the record was created. Note that this is an optional field and is meant to convey the concept of a static record.|
|Record type|1..1|The clinical type of the record. Used to support searching to allow Consumers to make sense of large result sets of Pointers. The clinical type will be one of a controlled set. It will not be possible to create a pointer with a type that does not exist within this controlled set.|
|Record URL|1..1|The location of the record on the Provider’s system|
|Record mime type|1..1|Describes the format of the record such that the Consumer can pick an appropriate mechanism to handle the record. Without it the Consumer would be in the dark as to how to deal with the Record|
|Record retrieval mode|1..1|Whether or not this Pointer facilitates direct or indirect Record retrieval. Used to give the Consumer a cue as to what following the Pointer will return.|