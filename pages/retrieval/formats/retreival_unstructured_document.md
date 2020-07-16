---
title: Unstructured Document
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retreival_unstructured_document.html
summary: Unstructured Document information format for retrieval
---

An unstructured document, such as a PDF. The content-type of the document returned SHOULD be in the MIME type as described on the pointer metadata (`DocumentReference.content[x].attachment.contentType`).<br><br>For unstructured documents, Consumers and Providers SHOULD support PDF as a minimum.<br><br>An example API endpoint for handling unstructured documents can be seen in the [CareConnect GET Binary specification ("Query 1 - Default Query" in section 1.1)](https://nhsconnect.github.io/CareConnectAPI/api_documents_binary.html#readresponse).  

Please see the [format code value set](https://fhir.nhs.uk/STU3/ValueSet/NRL-FormatCode-1) for the list of codes to use. 
