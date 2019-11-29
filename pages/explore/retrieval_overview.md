---
title: Retrieval Overview
keywords: structured rest documentreference
tags: [record_retrieval,for_consumers,for_providers]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_overview.html
summary: Solution overview of record and document retrieval
---

## Retrieval

Documents and records can be retrieved directly from the Providers that hold the documents/records. This is achieved by using the location information (record URL/endpoint) stored on a pointer (obtained from a pointer search) and sending a request to this location over HTTP(S) via the Spine Secure Proxy (SSP).

The process of retrieving a document or record from a provider in this way may be manually triggered by the end user. Retrieval could also be an automated process triggered after a successful patient match from PDS, for example.  The latter example would be transparent to the end user.

## Spine Secure Proxy (SSP)

The SSP is a content agnostic forward proxy, which is used to control and protect access to health systems. It provides a single security point for both authentication and authorisation for systems. See the [SSP specification]( https://developer.nhs.uk/apis/spine-core/ssp_overview.html) for more details.

## Retrieval solution end-to-end

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

   {% include note.html content="The URL property should be [percent encoded per RFC 3986](https://tools.ietf.org/html/rfc3986#section-2.1) to prevent any possibility of parsing errors." %}

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
