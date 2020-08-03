---
title: Public HTTP Retrieval Interaction
keywords: structured rest documentreference
tags: [for_consumers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_http_unsecure.html
summary: Requirements and guidance for retrieval Interactions via the public web.
---

The public web retrieval interaction is intended to support a simple use case where the pointer, tells a consumer, where to go to get publically available information, currently only contact details for the provider organisation.

This serves two purposes

- to identifies that the organisation has a relationship with the patient
- to enable the consumer to contact the provider and retrieve the patient information via a human to human interaction


## Retrieval Endpoint

This retrieval interaction requires the provider to make available a publically accessible web facing endpoint, which MUST support the [HTTP(S) GET](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3) request.

The provider will include the endpoint in the NRL pointer with the appropriate format code to indicate the public web retrieval mechanism.

The endpoint **MUST NOT** require any additional parameters or headers to be passed with the request.


### Security

As the information is publically accessible over the web, the retrieval of the information **MUST NOT :**
- require any additional authentication and authorization
- required the consumer to send the request via SSP

The consumer **MUST NOT** attempt to use the SSP for this request and should use just the url in the pointer to make the request directly to the provider.


## Retrieval Formats

The publically available information **MUST** be accessible as either:

- HTML
- a PDF

The pointer to the publically available information **MUST** contain a MIME type within the `content.attachment.contentType` identifying if the information is available as HTML or PDF.

The content-type of the returned information **MUST** be in the MIME type as described on the pointer metadata, or as requested if multiple MIME types are supported.


## Example Pointer

**PDF Contact Details**

```xml
<DocumentReference xmlns="http://hl7.org/fhir">
    <id value="c037a0cb-0c77-4976-83a1-a5d2703e6aa3-23325861873450086113"/>
    <meta>
        <profile value="https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1"/>
    </meta>
    <status value="current"/>
    <type>
        <coding>
            <system value="http://snomed.info/sct"/>
            <code value="736253002"/>
            <display value="Mental health crisis plan"/>
        </coding>
    </type>
    <class>
        <coding>
            <system value="http://snomed.info/sct"/>
            <code value="734163000"/>
            <display value="Care plan"/>
        </coding>
    </class>
    <subject>
        <reference value="https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210"/>
    </subject>
    <indexed value="2016-03-08T15:26:01+01:00"/>
    <author>
        <reference value="https://directory.spineservices.nhs.uk/STU3/Organization/RGD"/>
    </author>
    <custodian>
        <reference value="https://directory.spineservices.nhs.uk/STU3/Organization/RR8"/>
    </custodian>
    <content>
        <attachment>
            <contentType value="application/pdf"/>
            <url value="https://p1.nhs.uk/ContactDetails.pdf"/>
            <creation value="2016-03-08T15:26:00+01:00"/>
        </attachment>
        <format>
            <system value="https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1"/>
            <code value="urn:nhs-ic:record-contact"/>
            <display value="Contact details (HTTP Unsecured)"/>
        </format>
        <extension url="https://fhir.nhs.uk/STU3/StructureDefinition/Extension-NRL-ContentStability-1">
            <valueCodeableConcept>
                <coding>
                    <system value="https://fhir.nhs.uk/STU3/CodeSystem/NRL-ContentStability-1"/>
                    <code value="static"/>
                    <display value="Static"/>
                </coding>
            </valueCodeableConcept>
        </extension>
    </content>
    <context>
        <period>
            <start value="2016-03-07T13:34:00+01:00"/>
        </period>
        <practiceSetting>
            <coding>
                <system value="http://snomed.info/sct"/>
                <code value="708168004"/>
                <display value="Mental health service"/>
            </coding>
        </practiceSetting>
    </context>
</DocumentReference>
```



**HTML Contact Details**

```xml
<DocumentReference xmlns="http://hl7.org/fhir">
    <id value="c037a0cb-0c77-4976-83a1-a5d2703e6aa3-23325861873450086113"/>
    <meta>
        <profile value="https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1"/>
    </meta>
    <status value="current"/>
    <type>
        <coding>
            <system value="http://snomed.info/sct"/>
            <code value="736253002"/>
            <display value="Mental health crisis plan"/>
        </coding>
    </type>
    <class>
        <coding>
            <system value="http://snomed.info/sct"/>
            <code value="734163000"/>
            <display value="Care plan"/>
        </coding>
    </class>
    <subject>
        <reference value="https://demographics.spineservices.nhs.uk/STU3/Patient/9876543210"/>
    </subject>
    <indexed value="2016-03-08T15:26:01+01:00"/>
    <author>
        <reference value="https://directory.spineservices.nhs.uk/STU3/Organization/RGD"/>
    </author>
    <custodian>
        <reference value="https://directory.spineservices.nhs.uk/STU3/Organization/RR8"/>
    </custodian>
    <content>
        <attachment>
            <contentType value="text/html"/>
            <url value="https://p1.nhs.uk/ContactDetailsHTML.html"/>
            <creation value="2016-03-08T15:26:00+01:00"/>
        </attachment>
        <format>
            <system value="https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1"/>
            <code value="urn:nhs-ic:record-contact"/>
            <display value="Contact details (HTTP Unsecured)"/>
        </format>
        <extension url="https://fhir.nhs.uk/STU3/StructureDefinition/Extension-NRL-ContentStability-1">
            <valueCodeableConcept>
                <coding>
                    <system value="https://fhir.nhs.uk/STU3/CodeSystem/NRL-ContentStability-1"/>
                    <code value="static"/>
                    <display value="Static"/>
                </coding>
            </valueCodeableConcept>
        </extension>
    </content>
    <context>
        <period>
            <start value="2016-03-07T13:34:00+01:00"/>
        </period>
        <practiceSetting>
            <coding>
                <system value="http://snomed.info/sct"/>
                <code value="708168004"/>
                <display value="Mental health service"/>
            </coding>
        </practiceSetting>
    </context>
</DocumentReference>
```

