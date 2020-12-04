---
title: Introduction to the National Record Locator
keywords: homepage
tags: [overview]
sidebar: overview_sidebar
permalink: index.html
toc: false
summary: A brief introduction to the National Record Locator (NRL).
---

## Introduction

The National Record Locator (NRL) has been developed to, primarily, enable healthcare professionals to locate and access patient information shared by healthcare organisations, to support the direct care of those patients.

Sharing of information through the NRL empowers professionals, patients and communities, strengthens primary, secondary, and acute care, and enables efficiencies.

The NRL does not contain any patient record information itself, instead, it holds pointers to where the information can be accessed.

### Terms

In this specification, keywords '**MUST**', '**MUST NOT**', '**REQUIRED**', '**SHALL**', '**SHALL NOT**', '**SHOULD**', '**SHOULD NOT**', '**RECOMMENDED**', '**MAY**' and '**OPTIONAL**' are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

### Actors

Three actors are involved with the sharing of information via the NRL:

|Actor|Description|
|-----|-----------|
|**Provider**|Holds information about patients and wishes to share it with others.|
|**Consumer**|An individual or organisation who would benefit from having access to information shared by providers.|
|**The NRL**|Enables consumers to locate information shared by providers.|

### Information Sharing

The NRL has been built to facilitate national sharing of information, enabling consumers to:
- identify which providers hold and are sharing information.
- know how to retrieve the information, where from and in what format.
- know how to authenticate and get authorisation to access the information.

The NRL removes the need for organisations to create duplicate copies of information across systems and organisations, by facilitating access to up-to-date information directly from the source.

<!--
The National Record Locator does not support the sharing of a patient's full record in a single pointer. Instead, the NRL requires providers to share just a single section of a patient's record per pointer. This allows the shared information to be filtered to be most useful in a broad set of use cases, across a number of different care settings. It also helps avoid confusion when multiple providers share information about the same patient, as data is not needed to be 'merged'.

For example, here are a few sections of a full record that can be shared on the NRL (one pointer for each):
- A list of the patient's medications.
- A 'Mental health crisis plan' document.
- A discharge summary.

Splitting a record in this manner aids the implementation of access rules to limit visibility of certain sections to different clinicians based on their user access privilege and need to see certain aspects of a patient's full record.

{% include note.html content="The term 'Record' used throughout this specification refers to a section of a patient's full clinical record i.e. that can be pointed to by a pointer." %}
-->

### Cardinality

Some elements within FHIR resources utilised by the NRL require a more stringent cardinality than the resource permits; in such cases, the FHIR resource's cardinality will be indicated in superscript.

For example, the cardinality of the [`Parameters`](https://www.hl7.org/fhir/STU3/parameters.html) resource used for the `update` interaction is described as follows:

|Element|Cardinality|
|-------|-----------|
|`parameter`|1..1<sup>\[0..*\]</sup>|
|`parameter.name`|1..1|
|`parameter.part`|3..3<sup>\[0..*\]</sup>|

In this case, the `parameter.name` cardinality matches the FHIR resource, but the other two elements do not.

{% include important.html content="The `parameter` element has a `1..1` cardinality for the NRL, however, because this cardinality is based on the FHIR resource's `0..*` cardinality, the element **MUST** be treated as an array with a single element (when using JSON) i.e.
`\"parameter\": [{...}]`" %}

In all cases, the NRL's cardinality requirement takes precedence.

## How The NRL Works

The NRL is a national [index](architecture_overview.html) of [pointers](architecture_pointers.html) to information held by providers. Each pointer contains details of:
- information [type](supported_pointer_types.html).
- information [retrieval format](information_retrieval_overview.html#supported-retrieval-formats).
- how to [retrieve](information_retrieval_overview.html#supported-retrieval-interactions) the information.
- authentication method required to get the information.

### 1. Providers Create Pointers

Providers create and manage [pointers](architecture_pointers.html) on the NRL:

<div align="center">
  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="618px" height="200px" viewBox="-0.5 -0.5 618 200" style="background-color: rgb(255, 255, 255);"><defs/><g><rect x="275.4" y="10.2" width="331.5" height="178.5" rx="12.5" ry="12.5" fill="#dae8fc" stroke="#6c8ebf" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.85)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="118%" height="118%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 388px; height: 1px; padding-top: 34px; margin-left: 325px;"><div style="box-sizing: border-box; font-size: 0; text-align: center; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; word-wrap: normal; ">NRL</div></div></div></foreignObject><text x="519" y="52" fill="#000000" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">NRL</text></switch></g><rect x="10.2" y="61.2" width="187" height="110.5" rx="8.84" ry="8.84" fill="#f5f5f5" stroke="#666666" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.85)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="118%" height="118%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 218px; height: 1px; padding-top: 99px; margin-left: 13px;"><div style="box-sizing: border-box; font-size: 0; text-align: center; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #333333; line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; word-wrap: normal; ">Provider</div></div></div></foreignObject><text x="122" y="117" fill="#333333" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Provider</text></switch></g><rect x="298.35" y="61.2" width="283.05" height="110.5" fill="#fff2cc" stroke="#d6b656" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.85)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="118%" height="118%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 331px; height: 1px; padding-top: 140px; margin-left: 352px;"><div style="box-sizing: border-box; font-size: 0; text-align: center; "><div style="display: inline-block; font-size: 16px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events: all; white-space: normal; word-wrap: normal; "><b style="font-size: 16px">Pointer(s)</b><br style="font-size: 16px" /><div style="text-align: left ; font-size: 16px"><ul style="font-size: 16px"><li style="font-size: 16px"><span style="font-size: 16px">Data Type</span></li><li style="font-size: 16px"><span style="font-size: 16px">Endpoint to retrieve information from</span></li><li style="font-size: 16px"><span style="font-size: 16px">What format you can retrieve it in</span></li></ul></div></div></div></div></foreignObject><text x="518" y="144" fill="#000000" font-family="Helvetica" font-size="16px" text-anchor="middle">Pointer(s)...</text></switch></g><path d="M 197.2 116.45 L 289.76 116.45" fill="none" stroke="#82b366" stroke-width="2.55" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 295.5 116.45 L 287.85 120.27 L 289.76 116.45 L 287.85 112.63 Z" fill="#82b366" stroke="#82b366" stroke-width="2.55" stroke-miterlimit="10" pointer-events="all"/><rect x="44.2" y="133.45" width="161.5" height="29.75" rx="4.46" ry="4.46" fill="#d5e8d4" stroke="#82b366" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.85)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="118%" height="118%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 188px; height: 1px; padding-top: 175px; margin-left: 53px;"><div style="box-sizing: border-box; font-size: 0; text-align: center; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events: all; white-space: normal; word-wrap: normal; ">Information Endpoint</div></div></div></foreignObject><text x="147" y="180" fill="#000000" font-family="Helvetica" font-size="18px" text-anchor="middle">Information Endpoint</text></switch></g></g><switch><g requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"/><a transform="translate(0,-5)" xlink:href="https://desk.draw.io/support/solutions/articles/16000042487" target="_blank"><text text-anchor="middle" font-size="10px" x="50%" y="100%">Viewer does not support full SVG 1.1</text></a></switch></svg>
</div>

### 2. Consumers Find And Use Pointers

When a consumer would benefit from having information shared by other organisations about a patient, they can search the NRL and retrieve all known pointers related to that patient. From the information within the pointers, the consumer can decide if any of the types of information being shared by the providers may be of interest. They can then use the information in the pointers to retrieve the patient's information from the associated provider.

<div align="center">
  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="761px" height="336px" viewBox="-0.5 -0.5 761 336" style="background-color: rgb(255, 255, 255);"><defs/><g><path d="M 214.12 295.37 L 564.38 224.43" fill="none" stroke="#82b366" stroke-width="2.55" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 208.49 296.51 L 215.23 291.24 L 214.12 295.37 L 216.75 298.74 Z" fill="#82b366" stroke="#82b366" stroke-width="2.55" stroke-miterlimit="10" pointer-events="all"/><rect x="562.7" y="146.2" width="187" height="110.5" rx="8.84" ry="8.84" fill="#f5f5f5" stroke="#666666" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.85)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="118%" height="118%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 218px; height: 1px; padding-top: 237px; margin-left: 663px;"><div style="box-sizing: border-box; font-size: 0; text-align: center; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #333333; line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; word-wrap: normal; ">Consumer</div></div></div></foreignObject><text x="772" y="242" fill="#333333" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Consumer</text></switch></g><rect x="173.4" y="10.2" width="331.5" height="178.5" rx="12.5" ry="12.5" fill="#dae8fc" stroke="#6c8ebf" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.85)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="118%" height="118%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 388px; height: 1px; padding-top: 34px; margin-left: 205px;"><div style="box-sizing: border-box; font-size: 0; text-align: center; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; word-wrap: normal; ">NRL</div></div></div></foreignObject><text x="399" y="52" fill="#000000" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">NRL</text></switch></g><rect x="10.2" y="214.2" width="187" height="110.5" rx="6.63" ry="6.63" fill="#f5f5f5" stroke="#666666" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.85)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="118%" height="118%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 218px; height: 1px; padding-top: 279px; margin-left: 13px;"><div style="box-sizing: border-box; font-size: 0; text-align: center; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #333333; line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; word-wrap: normal; ">Provider</div></div></div></foreignObject><text x="122" y="297" fill="#333333" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Provider</text></switch></g><rect x="196.35" y="61.2" width="283.05" height="110.5" fill="#fff2cc" stroke="#d6b656" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.85)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="118%" height="118%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 331px; height: 1px; padding-top: 140px; margin-left: 232px;"><div style="box-sizing: border-box; font-size: 0; text-align: center; "><div style="display: inline-block; font-size: 16px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events: all; white-space: normal; word-wrap: normal; "><b style="font-size: 16px">Pointer(s)</b><br style="font-size: 16px" /><div style="text-align: left ; font-size: 16px"><ul style="font-size: 16px"><li style="font-size: 16px"><span style="font-size: 16px">Data Type</span></li><li style="font-size: 16px"><span style="font-size: 16px">Endpoint to retrieve information from</span></li><li style="font-size: 16px"><span style="font-size: 16px">What format you can retrieve it in</span></li></ul></div></div></div></div></foreignObject><text x="398" y="144" fill="#000000" font-family="Helvetica" font-size="16px" text-anchor="middle">Pointer(s)...</text></switch></g><path d="M 562.7 173.82 L 486.47 121.32" fill="none" stroke="#82b366" stroke-width="2.55" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 481.75 118.07 L 490.22 119.26 L 486.47 121.32 L 485.88 125.56 Z" fill="#82b366" stroke="#82b366" stroke-width="2.55" stroke-miterlimit="10" pointer-events="all"/><rect x="44.2" y="282.2" width="161.5" height="29.75" rx="4.46" ry="4.46" fill="#d5e8d4" stroke="#82b366" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.85)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="118%" height="118%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 188px; height: 1px; padding-top: 350px; margin-left: 53px;"><div style="box-sizing: border-box; font-size: 0; text-align: center; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events: all; white-space: normal; word-wrap: normal; ">Information Endpoint</div></div></div></foreignObject><text x="147" y="355" fill="#000000" font-family="Helvetica" font-size="18px" text-anchor="middle">Information Endpoint</text></switch></g></g><switch><g requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"/><a transform="translate(0,-5)" xlink:href="https://desk.draw.io/support/solutions/articles/16000042487" target="_blank"><text text-anchor="middle" font-size="10px" x="50%" y="100%">Viewer does not support full SVG 1.1</text></a></switch></svg>
</div>

More details about how to interact with the NRL can be found on the [Architectural Overview](architecture_overview.html) page.
