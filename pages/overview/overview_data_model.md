---
title: Solution Data Model
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_data_model.html
summary: Solution Data Model
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRL API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


## Data model ##

In order to support the Consumer and Provider interactions with the NRL the Pointer has been distilled into a data model. The data model is purposefully lean, each property has a clear reason to exist and it directly supports the activities of the Consumer and/or Provider.


| Property | Cardinality | Description | 
|-----------|----------------|------------|
|[Identifier](pointer_identity.html)|0..1|Assigned by the NRL at creation time. Uniquely identifies this record within the NRL. Used by Providers to update or delete.|
|Version |0..1|Assigned by the NRL at creation or update time. Used to track the current version of a Pointer.|
|[Master Identifier](pointer_identity.html)|0..1|The masterIdentifier is the identifier of the document as assigned by the source of the document. It is version specific – i.e. a new one is required if the document is updated. It is an optional field, providers do not have to supply a value.|
|[Pointer Status](pointer_lifecycle.html)|1..1|The status of the pointer|
|Patient|1..1|The Patient that the record referenced by this Pointer relates to. Supports Pointer retrieval scenarios.|
|Pointer owner|1..1|The entity who maintains the Pointer. Used to control which systems can modify the Pointer|
|Pointer reference|1..*|The record that is being referenced|
|Record owner|1..1|The entity who maintains the Record. Used to provide the Consumer with context around who they will be interacting with if retrieving the Record.|
|Record creation datetime|0..1|The date and time (on the Provider’s system) that the record was created. Note that this is an optional field and is meant to convey the concept of a static record.|
|Record type|1..1|The clinical type of the record. Used to support searching to allow Consumers to make sense of large result sets of Pointers. The clinical type will be one of a controlled set. It will not be possible to create a pointer with a type that does not exist within this controlled set.|
|Record class|1..1|A high-level category of the record. The category will be one of a controlled set. It will not be possible to create a pointer with a category that does not exist within this controlled set|
|Record URL|1..1|The location of the record on the Provider’s system|
|Record mime type|1..1|Describes the format of the record such that the Consumer can pick an appropriate mechanism to handle the record. Without it the Consumer would be in the dark as to how to deal with the Record|
|[Related Documents](pointer_maintenance.html)|0..1|Relationship to other documents|
|Record format|1..1|Describes the technical structure and rules of the record and it’s retrieval route|
|Record stability|1..1|Describes whether the record content at the time of the request is dynamically generated or is static|
|Record creation clinical setting|1..1|Describes where the content was created, in what clinical setting|
|Period of care|0..1|Details the time at which the documented care is relevant|


You can explore an in-depth view of the lean data model and the full NRL DocumentReference profile in the [FHIR Resources and References section](explore_reference.html).
