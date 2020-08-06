---
title: Contact Details
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_contact_details.html
summary: Contact Details information format for retrieval
---

The `Contact Details` retrieval format allows the provider to share with consumers, where they can retrieve contact details to use in relation to obtaining information about a patient.

### Information Retrieval

There are three steps which this retrieval format enables:

1. Identifying a provider has information about a patient and contact details are available for the consumer to get that information
2. The information in the pointer allow the consumer to retrieve the providers contact details
3. The consumer uses the retrieved contact details, to interact with the provider to get information relating to the patient


## Pointer retrieval `Format` Code 

The NRL pointer `format` code for this retrieval format is as follows: 

| Code | Display |
| --- | --- |
| urn:nhs-ic:record-contact | Contact details (HTTP Unsecured) |


## Retrieval Mechanism  

For the “Contact Details” record format, the [Public Web](retrieval_http_unsecure.html) retrieval interaction **MUST** be supported.

The contact details may be in the form of either:

- a HTML web page
- a PDF document

