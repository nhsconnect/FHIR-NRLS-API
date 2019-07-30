---
title: Retrieval Formats
keywords: structured, rest, documentreference
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_formats.html
summary: Support formats for record and document retrieval
---

{% include custom/search.warnbanner.html %}


## Retrieval Formats ##


The NRL may support retrieval of records and documents in a range of formats, this could include both unstructured documents and structured data.

The format of the referenced document/record is detailed in two meta-data fields:
 - Record format - describes the technical structure and the rules of the document/record
 - Record mime type - describes the data type of the document/record

See [FHIR Resources & References](explore_reference.html) for further detail on the data model. 

The combination of these two meta-data fields describes to a Consumer system the type and structure of the content that will be returned. This gives the Consumer system the information it needs to know to render the referenced record. For example, whether the referenced content is a publicly accessible web page of contact details, an unstructured PDF document or specific FHIR profile. See below for further detail and the list of currently supported formats. 

## Supported Formats ##

The table below describes the formats that are currently supported:

| Format | Description |
|-----------|----------------|
|Contact Details (HTTP Unsecured)|A publicly accessible HTML web page or PDF detailing contact details for retrieving a record. <br> Note that retrieval requests for contact details should be made directly and not via the SSP.| 
|Unstructured Document|An unstructured document e.g. PDF. The document  SHOULD be returned in the format described in the mime-type on the pointer metadata. <br> For guidance see the [CareConnect GET Binary specification](https://nhsconnect.github.io/CareConnectAPI/api_documents_binary.html). <br> For unstructed documents, Consumers and Providers SHOULD support PDF as a minimum. | 

Please see the [format code value set](https://fhir.nhs.uk/STU3/ValueSet/NRL-FormatCode-1) for the list of codes to use. 

{% include note.html content="Format codes related to profiles that support structured data are not currently listed in the above referenced valueset and table. These will be added in due course." %}

Note that the NRL supports referencing multiple formats of a record document on a single pointer, see below for details. 

## Multiple Formats ##

Multiple formats of a record or document can be made available through a single pointer on the NRL. For example a pointer can contain a reference to retrieve a record in PDF format and as a structured FHIR resource. Each format must be detailed in a separate content element on the DocumentReference (pointer).

### Multiple Format Example ###
The example below shows a pointer for a Mental Health Crisis Plan that can be retrieved over the phone (using the contact details listed on the referenced HTML web page) and directly as a PDF document.

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/retrieval_multiple_formats.xml %}
{% endhighlight %}
</div>
