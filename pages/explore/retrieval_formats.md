---
title: Retrieval Formats
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_formats.html
summary: Formats for record and document retrieval
---

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
