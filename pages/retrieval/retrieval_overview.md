---
title: Retrieval Overview
keywords: structured rest documentreference
tags: [record_retrieval,for_consumers,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_overview.html
summary: Solution overview of record and document retrieval
---

## The Consumer controls Pointer access

When a Consumer requests that the NRL return the Pointers that it has for a given patient (NHS number) it will return all Pointers. The NRL will not perform any filtering before sending that collection of Pointers back to the Consumer. 

Once consequence of this is that the end user on the Consumer side may be exposed to Pointers that reveal sensitive information about the Patient, for example it will be possible to infer through a Pointer that a Patient has a certain kind of record. Even though the user may not be able to retrieve the Record, knowing that it exists is in itself revealing a degree of personal information about that patient that may not be appropriate.

With this in mind, there will most likely be a need to filter Pointers before they are displayed to the end user. This responsibility belongs to the Consumer and should be implemented using local access rules to judge whether a given user should be permitted to know that a given Pointer exists. This is in addition to the RBAC requirements for NRL (see the [Authentication & Authorisation page](integration_authentication_authorisation.html)).

The mechanism for making this decision is predicated on the [Record type](overview_data_model.html#data-model) that the Pointer references.


## The NRL does not guarantee that Records can be retrieved by following a Pointer

There are complexities associated with retrieving data over a network that are outside of the scope of the metadata captured by a Pointer. As an example, consider the need to define firewall rules to allow traffic to flow between a Consumer and a Provider. The NRL aims to facilitate record retrieval through the [SSP Read Interaction](retrieval_interaction_read.html), reducing the need for point-to-point integration between Consumer and Provider systems. However, Providers have a responsibility to ensure that Pointer metadata accurately reflects the retrieval mechanism and format of the referenced document/record.

## Caching and Storing

It is important that consumers of NRL Pointers can view and make clinical decisions based on the most up-to-date information available. For this reason, NRL recommends that Pointers and referenced content returned from search and read requests not be cached or stored.



## Retrieval

Documents and records can be retrieved directly from the Providers that hold the documents/records. This is achieved by using the location information (record URL/endpoint) stored on a pointer (obtained from a pointer search) and sending a request to this location over HTTP(S) via the Spine Secure Proxy (SSP).

The process of retrieving a document or record from a provider in this way may be manually triggered by the end user. Retrieval could also be an automated process triggered after a successful patient match from PDS, for example.  The latter example would be transparent to the end user.

## Spine Secure Proxy (SSP)

The SSP is a content agnostic forward proxy, which is used to control and protect access to health systems. It provides a single security point for both authentication and authorisation for systems. See the [SSP specification]( https://developer.nhs.uk/apis/spine-core/ssp_overview.html) for more details.

## End-to-End Retrieval Solution

The following diagram describes how record retrieval is facilitated through the SSP using the Record URL stored on the pointer.

[
    ![Retrieval solution end-to-end](images/retrieval/retrieval_concept_diagram.png)<br><br>
    Click to view the diagram at full size.
](images/retrieval/retrieval_concept_diagram.png){:target="_blank"}

As the diagram depicts, the step-by-step process end-to-end for retrieving a record or document is as follows: 
1. Consumer system queries the NRL to see if any Pointers exist for the patient under their care.
2. Consumer system finds a Pointer that references a record which could be of value for the provision of care.
3. Consumer system takes the URL property value (see [Pointer Data Model](overview_data_model.html) for details) from the Pointer that was found and uses this value to create a request to the Provider system that holds the record.

   The URL property is prefixed with the URL to the SSP, which will ensure that the request goes via the SSP and that all necessary security checks are performed on the request. The SSP base url prefix is added by the Consumer system. For more details, see the [Retrieval Read](retrieval_interaction_read.html#retrieval-via-the-ssp) interaction page.

   {% include note.html content="The URL property should be fully [percent encoded per RFC 3986](https://tools.ietf.org/html/rfc3986#section-2.1) to prevent any possibility of parsing errors." %}

   An example SSP-prefixed URL:

   ```
   https://testspineproxy.nhs.uk/https%3A%2F%2Fprovider.thirdparty.nhs.uk%2FAB1%2FStatic%2Fc1cd026e-e06b-4121-bb08-a3cb8f53c58b
   ```

4. Consumer [system] sends the request to the Provider system.
5. Request sent by the Consumer goes through the SSP, where security checks are performed.
6. Request is then sent onto the Provider system that holds the record once security checks are passed.
7. Provider system receives and validates the request.
8. Provider system sends the requested record back to the Consumer, via the SSP.
9. Consumer [system] receives the record and processes it ready to display to the end user.

For more details on requirements for facilitating retrieval, see the [retrieval read interaction](retrieval_interaction_read.html).



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
