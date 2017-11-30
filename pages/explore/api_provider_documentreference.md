---
title: Provider API
keywords: getcarerecord, structured, rest, documentreference
tags: [rest,fhir,documents,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_provider_documentreference.html
summary: A Provider has a read-write view of Pointers within the NRLS. A Provider can only view and modify the Pointers that they own.
---

<!--
summary: A DocumentReference resource is used to describe a document that is made available to a healthcare system. A document is some sequence of bytes that is identifiable, establishes its own context (e.g., what subject, author, etc. can be displayed to the user), and has defined update management. The DocumentReference resource can be used with any document format that has a recognized mime type and that conforms to this definition.
-->


{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}

<!--[SKETCH profile. Not official]-->



<!--
## 1. Read Operation ##

<div markdown="span" class="alert alert-success" role="alert">
GET [baseUrl]/DocumentReference/[id]</div>

{% include custom/read.response.html resource="DocumentReference" content="" %}
-->



## 1. Create Operation ##

<div markdown="span" class="alert alert-success" role="alert">
POST [baseUrl]/DocumentReference</div>

{% include custom/create.response.html resource="DocumentReference" content="" %}

## 2. Update Operation ##

<div markdown="span" class="alert alert-success" role="alert">
PUT [baseUrl]/DocumentReference/[id]</div>

{% include custom/update.response.html resource="DocumentReference" content="" %}

## 3. Delete Operation ##

<div markdown="span" class="alert alert-success" role="alert">
DELETE [baseUrl]/DocumentReference/[id]</div>

{% include custom/delete.response.html resource="DocumentReference" content="" %}



