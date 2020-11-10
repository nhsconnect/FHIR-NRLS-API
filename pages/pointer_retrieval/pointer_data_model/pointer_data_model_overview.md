---
title: Pointer Data Model
keywords: development reference
tags: [development,fhir]
sidebar: overview_sidebar
permalink: pointer_data_model_overview.html
summary: "Population guidance for the pointer data model."
---

The following diagram shows the data item categories that can be carried within a pointer. Each individual data item is described in further detail in the sections below.

<img alt="The pointer model contains: identifiers, pointer metadata, information metadata and retrieval information." src="images/pointer_retrieval/pointer_model_overview.png" style="display:block;margin:auto;width:75%;max-width: 100%;">

The [NRL-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1) resource describes the NRL pointer data model. Follow the links in the 'Data Item' column below for mapping to the FHIR profile and detail on population guidance.

## Identifiers

| Data Item | Optionality | Description |
|----------------|------------|------------|
|[Pointer Identifier](pointer_fhir_resource.html#pointer-logical-identifier)| Mandatory | Assigned by the NRL at creation time. Uniquely identifies this record within the NRL.|
|[Master Identifier](pointer_fhir_resource.html#master-identifier)| Optional | An optional identifier for the pointer as assigned by the provider. It is version specific and a new master identifier is required if the pointer is superdeded, or deleted and recreated.|
|[Patient](pointer_fhir_resource.html#patient)| Mandatory | The NHS number of the patient which the information referenced, by the pointer, relates to.|

## Pointer Metadata

| Data Item | Optionality | Description |
|----------------|------------|------------|
|[Profile](pointer_fhir_resource.html#fhir-profile)| Mandatory | The URI of the FHIR profile that the resource conforms to. Indicates the version of the pointer model.|
|[Pointer owner](pointer_fhir_resource.html#pointer-owner)| Mandatory | The entity that maintains the pointer.|
|[Pointer status](pointer_fhir_resource.html#pointer-status) | Mandatory | The status of the pointer.|
|[Pointer version](pointer_fhir_resource.html#pointer-versioning) | Auto-populated by the NRL | Assigned by the NRL at creation or update time. Used to track the current version of a pointer.|
|[Pointer indexed datetime](pointer_fhir_resource.html#pointer-versioning)| Auto-populated by the NRL | Assigned by the NRL at creation time. The date and time of pointer creation.|
|[Pointer last updated datetime](pointer_fhir_resource.html#pointer-versioning)| Auto-populated by the NRL | Assigned by the NRL at creation and update time. The date and time the pointer was last updated.|
|[Related pointer](pointer_fhir_resource.html#related-pointer)| Optional (Mandatory for the [Supersede interaction](api_interaction_supersede.html)) | Relationship referencing the previous version of the pointer, which this pointer supersedes.|

## Information Metadata

| Data Item | Optionality | Description |
|----------------|------------|------------|
|[Information category](pointer_fhir_resource.html#information-category)| Mandatory | A high-level category of the information, from a set of NRL supported categories.|
|[Information type](pointer_fhir_resource.html#information-type)| Mandatory | The clinical type of information referenced by the pointer. The clinical type will be from a controlled set of types supported by the NRL.|
|[Clinical setting](pointer_fhir_resource.html#clinical-setting)| Mandatory | Describes the clinical setting in which the information was recorded.|
|[Information owner](pointer_fhir_resource.html#information-owner)| Mandatory | The entity that maintains the information.|
|[Period](pointer_fhir_resource.html#period)| Optional | Optional information detailing the period in which the referenced record is/was active.|
|[Information creation datetime](pointer_fhir_resource.html#information-creation-date)| Optional | Optional information about the date and time (on the Provider’s system) that the information was created (for static records).|

## Retrieval Information

| Data Item | Optionality | Description |
|----------------|------------|------------|
|[Retrieval URL](pointer_fhir_resource.html#retrieval-url)| Mandatory | An absolute URL for the location of the information on the provider’s system.|
|[Retrieval format](pointer_fhir_resource.html#retrieval-format)| Mandatory | An identifier for the technical structure and rules of the information.|
|[Retrieval MIME type](pointer_fhir_resource.html#retrieval-mime-type)| Mandatory | Describes the type of data, in addition to the "Retrieval format".|
|[Information stability](pointer_fhir_resource.html#information-stability)| Mandatory | Describes whether the information shared at the time of the consumer's request is dynamically generated or static.|
