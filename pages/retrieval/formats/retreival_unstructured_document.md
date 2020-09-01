---
title: Unstructured Document
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retreival_unstructured_document.html
summary: Unstructured Document format retrieval information.
---

The `Unstructured Document` retrieval format allows a provider to share information in standard formats which are generally not considered to have a machine readable structure, such as a PDF document containing a 'Mental health crisis plan'.

Support for unstructured documents is intended to share existing document and record types, without the need for consumers and providers to develop and adopt new standards, resulting in reduced development and implementation time, quicker benefits for health care services and improved care for patients.

## Pointer Retrieval `Format` Code and `MIME` Type

### Format

The NRL pointer [`format`](explore_reference.html#retrieval-format) code for this retrieval format is as follows:

|Code|Display|
|----|-------|
| urn:nhs-ic:unstructured | Unstructured Document |

### Content-Type

The content-type of the unstructured document returned SHOULD be in the [`retrieval MIME type`](explore_reference.html#retrieval-mime-type) as described on the pointer metadata. Supported MIME types for pointer types which support unstructured documents are listed on the [pointer types](supported_pointer_types.html) page.

Currently supported MIME types:

|Name|Type|
|----|----|
| PDF | application/pdf |

## Retrieval Interaction

The `Unstructured Document` retrieval format **MUST** support the [SSP Read](retrieval_ssp.html) retrieval interaction.

The endpoint URL included in the NRL pointer **MUST** require no additional/custom headers or parameters beyond those required by the SSP.

## Retrieval Response

When successfully responding to an unstructured document request, the provider **MUST** return:

- an HTTP `200` **OK** status code.
- a payload conforming to the format and MIME included in the pointer reference. The unstructured document **MUST NOT** be wrapped in a structured data model such as a [FHIR Binary](https://www.hl7.org/fhir/binary.html) resource.

## Citizen vs Health Care Professional Request

A provider may wish to return different data when the request for information is from a health care professional to when the request is from a citizen facing application.

An example of this might be:
- a provider might share some practitioner contact details with other healthcare professionals but may not wish to share those details with a citizen.
- a provider might wish to hold back information from a citizen about a sensitive result until the information has been shared with the patient by a practitioner, but that same information may be very useful to other healthcare professionals and could result in significantly improved care/life saving for the patient if they were to attend a service such as A&E before the provider has had chance to share that information with the patient.

To enable the provider to return appropriate information, all consumers wishing to retrieve data via the SSP **MUST** send the request with an appropriate JSON Web Token (JWT) identifying the intended audience. The requirements for the JWT are on the [JSON Web Token Guidance](jwt_guidance.html) page.
