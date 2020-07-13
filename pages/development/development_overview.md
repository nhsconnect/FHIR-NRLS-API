---
title: Development Overview
keywords: getcarerecord structured rest resource
tags: [development,for_providers,for_consumers]
sidebar: foundations_sidebar
permalink: development_overview.html
summary: "Overview of the Development section"
---


# Purpose

This implementation guide is intended for use by software developers looking to build a conformant NRL API interface using the FHIR&reg; standard, with a focus on general API implementation guidance.

### Notational Conventions

The keywords ‘**MUST**’, ‘**MUST NOT**’, ‘**REQUIRED**’, ‘**SHALL**’, ‘**SHALL NOT**’, ‘**SHOULD**’, ‘**SHOULD NOT**’, ‘**RECOMMENDED**’, ‘**MAY**’, and ‘**OPTIONAL**’ in this implementation guide are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## RESTful API

### Content Types

- The NRL Server MUST support both formal [MIME-types](https://www.hl7.org/fhir/STU3/http.html#mime-type) for FHIR resources:
  - XML: `application/fhir+xml`
  - JSON: `application/fhir+json`
  
- The NRL Server MUST also support DSTU2 [MIME-types](https://www.hl7.org/fhir/DSTU2/http.html#mime-type) for backwards compatibility:
  - XML: `application/xml+fhir`
  - JSON: `application/json+fhir`
  
- The NRL Server MUST also gracefully handle generic XML and JSON MIME types:
  - XML: `application/xml`
  - JSON: `application/json`
  - JSON: `text/json`
  
- The NRL Server MUST support the optional `_format` parameter in order to allow the client to specify the response format by its MIME type. If both are present, the `_format` parameter overrides the `Accept` header value in the request.

- If neither the `Accept` header nor the `_format` parameter are supplied by the client system, the NRL Server MUST return data in the default format of `application/fhir+xml`.


## 1. NRL API Overview

The NRL API supports the following operations as detailed in the [Solution Interactions](overview_interactions.html) section of this implementation guide:

|Interaction|HTTP Verb|Actor|Description|
| ------------- | ------------- | ------------- | ------------- | ------------- | 
|[Read](api_interaction_read.html)|GET|Consumer|Retrieve a single pointer by Logical ID|
|[Search](api_interaction_search.html)|GET|Consumer|Parameterised search for pointers on the NRL|
|[Create](api_interaction_create.html)|POST|Provider|Create a pointer on NRL|
|[Create (Supersede)](api_interaction_supersede.html)|POST|Provider|Replace an NRL pointer, changing the status of the replaced pointer to "superseded"|
|[Update](api_interaction_update.html)|PATCH|Provider|Update an NRL pointer to change the status to "entered-in-error"|
|[Delete](api_interaction_delete.html)|DELETE|Provider|Delete an NRL pointer|

A system can be assured to perform both Consumer and Provider interactions, provided that all relevant prerequisites and requirements are met. 

## 2. Prerequisites for NRL API

### 2.1 NRL Server API Conformance

- MUST support HL7 FHIR STU3 version 3.0.1.

- MUST implement REST behavior according to the [FHIR specification](http://www.hl7.org/fhir/STU3/http.html).

- MUST support XML **or** JSON formats for all API interactions.

### 2.2 NRL Client API Conformance

- MUST support HL7 FHIR STU3 version 3.0.1.

- MUST support XML **or** JSON formats for all API interactions.

- SHOULD support the NRL Service RESTful interactions and search parameters.

### 2.3 Spine Services

The NRL API is accessed through the NHS Spine. Providers and consumers of the NRL API are required to integrate with the following Spine services as a pre-requisite to calling the NRL API:

|National Service|Description|
| ------------- | ------------- |
|Personal Demographics Service (PDS)|National database of NHS patients containing details such as name, address, date of birth, and NHS Number (known as demographic information).|

#### Detailed Spine Services Prerequisites

To use this API, both Provider and Consumer systems:

- MUST have been accredited and received an endpoint certificate and associated ASID (Accredited System ID) for the client system.
- MUST pass the system/organisation's information in a JSON web token - see [Access Tokens (JWT)](integration_access_tokens_JWT.html) for details.
- MUST have previously traced the patient's NHS Number using PDS or an equivalent service.

In addition, Consumer systems:

- MUST have authenticated the user using NHS Identity or national smartcard authentication and obtained a the user's UUID and associated RBAC role.
- MUST pass the user's information in the JSON web token.

### 2.4 NHS Number

NHS Numbers used with FHIR API profiles MUST be verified. NHS Numbers can be verified using a full PDS Spine-compliant system (HL7v3), a [Spine Mini Services Provider (HL7v3)](https://nhsconnect.github.io/spine-smsp/), or a [Demographics Batch Service (DBS)](https://developer.nhs.uk/library/systems/demographic-batch-service-dbs/) batch-traced record (CSV). 

The option of using a DBS service is for Provider systems only. Consumers performing a search operation MUST use either a full PDS Spine compliant system or a Spine Mini Services Provider.

{% include note.html content="A verified NHS Number exists on PDS, is still in use, and the demographic data supplied results in the correct degree of demographic matching as per PDS matching rules.<br/><br/>The NHS NUMBER is 10 numeric digits in length. The tenth digit is a check digit used to confirm its validity. The check digit MUST be validated using the Modulus 11 algorithm." %}

## 3. Explore the NRL

You can explore and test the NRL GET, POST, and DELETE commands and responses using Swagger in the [NRL API Reference Implementation](https://data.developer.nhs.uk/nrls-ri/index.html).



## Retrieval Formats

The NRL may support retrieval of records and documents in a range of formats, including both unstructured documents and structured data.

The format of the referenced record is detailed in two metadata fields:
- Record format — describes the technical structure and the rules of the record.
- Record MIME type — describes the data type of the record.

See [FHIR Resources & References](explore_reference.html) for more details on the data model. 

The combination of these two metadata fields describes to a Consumer system the type and structure of the content that will be returned. This gives the Consumer system the information it needs to know to render the referenced record. For example, the referenced content could be a publicly accessible web page containing contact details, an unstructured PDF document, or a specific FHIR profile. See below for more details and the list of currently supported formats.

## Supported Formats

The following table describes the formats that are currently supported:

| Format | Description |
|-----------|----------------|
|Contact Details (HTTP Unsecured)|A publicly accessible HTML web page or PDF detailing contact details for retrieving a record.<br><br>Note that retrieval requests for contact details should be made directly and not via the SSP.|
|Unstructured Document|An unstructured document, such as a PDF. The content-type of the document returned SHOULD be in the MIME type as described on the pointer metadata (`DocumentReference.content[x].attachment.contentType`).<br><br>For unstructured documents, Consumers and Providers SHOULD support PDF as a minimum.<br><br>An example API endpoint for handling unstructured documents can be seen in the [CareConnect GET Binary specification ("Query 1 - Default Query" in section 1.1)](https://nhsconnect.github.io/CareConnectAPI/api_documents_binary.html#readresponse).  | 

Please see the [format code value set](https://fhir.nhs.uk/STU3/ValueSet/NRL-FormatCode-1) for the list of codes to use. 

{% include note.html content="Format codes related to profiles that support structured data are not currently listed in the above referenced valueset and table. These will be added at a later date." %}

Note that the NRL supports referencing multiple formats of a record document on a single Pointer. See below for details. 

## Multiple Formats

Multiple formats of a record or document can be made available through a single Pointer on the NRL. For example, a Pointer can contain a reference to retrieve a record in PDF format and as a structured FHIR resource. Each format must be detailed in a separate content element on the DocumentReference (Pointer).

### Multiple Format Example

The following examples show a pointer for a Mental Health Crisis Plan that can be retrieved over the phone (using the contact details listed on the referenced HTML web page) and directly as a PDF document.

#### XML

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/retrieval_multiple_formats.xml %}
{% endhighlight %}
</div>

#### JSON

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/retrieval_multiple_formats.json %}
{% endhighlight %}
</div>
