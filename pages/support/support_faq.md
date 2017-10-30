---
title: Frequently Asked Questions (FAQ)
keywords: support, faq, questions
tags: [support]
toc: false
sidebar: overview_sidebar
permalink: support_faq.html
summary: "Frequently Asked Questions (FAQ)."
---

#### Why is resource versioning included as a mandatory requirement? ####

It is a key principle of the FHIR RESTful APIs that all resources are versioned; without this support no updates to data can ever be safely performed. This is explained in the “Lost Updates” section and “Transactional Integrity” sections of the FHIR standard. Whilst we recognise that it is not necessary to persist versioned access to historical records, it is important that the latest record version can be ascertained. David Hay (Product Strategist at Orion Health) has a blog post on how systems that don’t fully support versions can handle this requirement in a simple and straight forward way.

[https://fhirblog.com/2013/11/21/fhir-versioning-with-a-non-version-capable-back-end/](https://fhirblog.com/2013/11/21/fhir-versioning-with-a-non-version-capable-back-end/)

<!--
#### Will it be necessary in all cases to use an NHS service to look up staff/organisation/location information when a supplier may have their own index of this information? ####

You are welcome to use your own ODS index (i.e. to find an organisation by name/address etc.). However, you will need to perform an SDS lookup using the ODS code to resolve the FHIR endpoint that represents that ODS code for the purpose of using the Care Connect APIs.
-->

#### Why is there to be a centrally-held list of error codes in addition to the standard HTTP response codes? ####

The list of error codes is really intended to allow consumer applications to make sense of errors that the human operator could potentially do something about. We recognise there is a cost-benefit trade-off in this space and will look to only introduce error codes (above that of the base FHIR specification) when they add sufficient value. For example a 400 - Bad Request error code in isolation doesn’t help you determine which input parameter(s) are malformed and similarly a 422 -  Unprocessable Entity doesn’t in isolation help you determine which business rule (or integrity constraint) has caused an operation to fail. 

Defining a small number of supplementary error codes to be included in the Operation Outcome entity allows sense to be made of these failing interactions.
