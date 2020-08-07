---
title: Unstructured Document
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retreival_unstructured_document.html
summary: Unstructured Document information format for retrieval
---


The `Unsecured Document` retrieval format allows the provider to share information in standard formats which are generally not considered to have a machine readable structure, such as a PDF document containing a Mental Health Crisis plan.

Support for un-structured documents is intended to be used to share existing document and record types, without the need for consumers and providers to develop and adopt new standards, meaning quicker benefits for health care services and improve care for the patients.


## Pointer retrieval `Format` Code and `MIME` type

### Format

The NRL pointer `format` code for this retrieval format is as follows: 

| Code | Display |
| --- | --- |
| urn:nhs-ic:unstructured | Unstructured Document |


### Content-Type

The content-type of the unstructured document returned SHOULD be in the MIME type as described on the pointer metadata `DocumentReference.content[x].attachment.contentType` element. Supported MIME types for pointer types which support unstructured documents is listed on the [pointer types](supported_pointer_types.html) page.

Currently supported MIME types:

| Name | Type |
| --- | --- |
| PDF | application/pdf |


## Retrieval Mechanism  

For the “Unstructured Document” retrieval format, the [SSP Read](retrieval_ssp.html) retrieval interaction **MUST** be supported.

The provider defines the endpoint URL that is included in the NRL pointer, but when a consumer requests the information using the pointer no additional headers or parameters should be needed beyond those required by the SSP.


## Retrieval Response 

When successfully responding to the request the provider MUST return: 

- a HTTP status code of 200
- a payload conforming to the Format and MIME included in the pointer reference.


## Citizen vs Health Care Professional request

A provider may wish to return different data when the request for information is from a health care professional to when the request is from a citizen facing application.

An example of this might be:
- a provider might share some practitioner contact details with other healthcare professionals but may not wish to share those details with a citizen
- a provider might wish to hold back information from a citizen about a sensitive result until the information has been shared with the patient by a practitioner, but that same information may be very useful to other healthcare professionals and could result in significantly improved care/life saving for the patient if they were to attend as service such as A&E before the provider has had chance to share that information with the patient.

To enable this control within the provider, all consumers which wishes to retrieve data via the SSP must send the request with an appropriate JSON Web Token (JWT), which identifies if the request if for a healthcare professional or for citizen access. The requirements for the JWT are on the [Development Overview](development_overview.html#json-web-token) page.

