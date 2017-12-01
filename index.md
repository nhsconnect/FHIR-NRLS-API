---
title: Introduction to NRLS FHIR&reg; API
keywords: homepage
tags: [overview]
sidebar: overview_sidebar
permalink: index.html
toc: false
summary: A brief introduction to getting started with the NRLS FHIR&reg; API.
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the National Record Locator API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}

{% include warning.html content="This site is provided for information only and is intended for those engaged with NHS Digital on the development of the NRLS API. It is advised not to develop against these specifications until a formal announcement has been made." %}

# Introduction #

The NRLS RESTful FHIR&reg; API within this site has been developed collaboratively by NHS Digital and the community. This API aims to better support the delivery of care by enabling the creation of a National Record Locator Service that would act as a national index to be able to find out what records exist for a patient across local and national care record solutions (such as SCR). 

What this proposes is a strategic direction, for the creation of a fundamental data sharing component within the health and care architecture to support the delivery of a paperless NHS.

<!--delivery of care by opening up information and data held across different clinical care settings through the use of nationally defined INTEROPen FHIR® resources.

The INTEROPen vision is to create a library of nationally defined HL7® FHIR® resources and interaction patterns that implementers can adopt to simplify integration and interoperability within UK health and social care.-->

Find out more on the [NHS Developer Network](https://developer.nhs.uk/library/systems/national-record-locator-service/).

<!--
# Using this guide #

This guide has been created to support the adoption of NRLS FHIR&reg; profiles and resources. As such the site is structured around NRLS stakeholders including API users, developers and architects.  

{% include custom/api_overview.svg %}

The above steps outline a complete API journey from imagination and exploring to developing local APIs using NRLS FHIR&reg; profiles all the way to deploying a live API.
-->

<!--{% include custom/contribute.html content="If you want to get involved in any part of this then please get in touch with careconnect@interopen.org "%}-->
<!--
# NRLS Focus #

The current site focuses on a typical API Developer's Journey as highlighted by the green boxes below in the developer journey:

<img src="images/roadmap/guide-focus.png" style="width:100%;max-width: 100%;">

NHS Digital is contributing to progressing the profile development, the testing process and invitations are open for the community to get involved and progress the wider developer ecosystem.

Please see the explanation of the complete development roadmap.
-->


<!--{% include custom/contribute.html content="Please contact [careconnect@interopen.org] to get involved." %}-->


<!--
# Resource Roadmap #

The example [API journey](overview_api_journey.html) outlines the development roadmap for the RESTful API outlined within this site.

<img src="images/roadmap/roadmap-online.png" style="width:100%;max-width: 100%;">

The above roadmap illustrates the steps necessary to create, test and verify the profiles as well as some of the supporting tooling which might be necessary to build to provide viable APIs. The roadmap is not intended to be complete but to promote discussion, extension and engagement from the community.
-->
<!--{% include custom/contribute.html content="To get involved in any parts of the roadmap or to discuss the other elements please get in touch with careconnect@interopen.org "%}-->

<!--
# Solution #

## Concepts ##

The NRLS is based on the [Registry-Repository] (https://developer.nhs.uk/library/architecture/integration-patterns/registry-repository/) pattern which separates the storage and retrieval of a record from data that describes its location. 

[TBA - Diagram 6]


### Actors ###

The NRLS is acting as a registry with the repository function carried out by so-called Providers. Providers are systems external to the NRLS that expose records for retrieval via metadata or so-called Pointers that are stored in the NRLS. 
Pointers are really at the core of the NRLS. The NRLS can be thought of as a collection of Pointers. Each Pointer describes how to retrieve a particular record from the Provider’s system or repository. It is key to the success of the NRLS that Pointers are accurate. It is the responsibility of Providers to create and manage Pointers on the NRLS in order to maintain this accuracy. 
Accuracy is important from the perspective of those systems who wish to understand what records are available and from there may wish to retrieve records from the Provider. This category of actor is known as a Consumer. Without accurate Pointer data the Consumer’s life is made harder as they cannot be assured that a given Pointer describes what is purports to.

### Record ###

A Record exists on a remote system and collects together related data into a logical grouping that makes sense in some consuming context.
Records come in a variety of formats but the NRLS broadly makes a distinction based on the notion of structured and unstructured Records. Structured Records are made up of clearly defined data types whose composition makes them easily searchable. Contrast this with unstructured Records which crudely could be said to be “everything else” and are comprised of data that is usually not as easily searchable. 
The NRLS also acknowledges that there is a difference to be drawn between the how the contents of a Record can change over time. To the NRLS a static Record is one whose contents will never change whereas a dynamic Record’s contents is not guaranteed to be the same from one point in time to another in the future.

### Pointer ###

Pointers are associated with a Record. As noted a Record exists in a remote system, one of the roles of the Pointer is to provide enough context to allow a Consumer to retrieve that Record from the remote system and display it.  
The NRLS has two kinds of Pointer which are differentiated by the way they facilitate Record retrieval. A direct Pointer can be followed, and the expectation of the Consumer should be that the Record will be returned to them. An indirect Pointer is different. Following this kind of Pointer will not return the Record, instead it will present the Consumer with a further set of instructions that must be followed in order to retrieve the Record. Typically, this will be a set of contact details that must be used to request the Record, for example it might be the phone number of a healthcare service which can relay a Record’s contents over the phone.

## Behaviour ##

The NRLS has been designed around the Pointer being the unit of currency. Both Providers and Consumers deal exclusively with Pointers. However the roles of Provider and Consumer have different capabilities when it comes to Pointer manipulation. 
A Provider can be thought of as a system that has write access to the NRLS with some limited read-access that is designed to support Pointer maintenance. 
A Consumer can be thought of as a system that has read-access though the way that Pointers can be retrieved from the system is different from the read-access that a Provider has. The read access that a Consumer has is designed to facilitate the retrieval of Pointers that are of interest to the Consuming system.

[TODO Diagram 5]

### Identity on the NRLS ###

The NRLS has two roles of user – Provider and Consumer. The ODS code is used as a means to identify a user. The NRLS maintains a mapping of ODS code to role; Provider, Consumer role or in some cases both. In order to categorise client systems, the NRLS it must have a means of reliably determining the ODS code of that system. This will be discussed in more detail in the security section (TODO).

### Pointer maintenance by Providers ###

If a client system is in the Provider role then they are permitted to create new Pointers, delete and update existing Pointers. Note that when it comes to the modification of existing Pointers the Provider is only permitted to change the Pointers that it owns. The concept of ownership is carried on the Pointer itself and is again cantered around the ODS code. So long as the ODS code of the client system puts the client in the Provider role and so long as the ODS code of that client matches the owner’s ODS code found on the Pointer in question then the client can modify that Pointer.
In order to manipulate a Pointer a Provider must know the logical identifier of that Pointer. The logical identifier is an NRLS generated value that uniquely identifies a Pointer across an instance of the NRLS. 
The NRLS provides a number of query mechanisms that are only available to Providers which are designed to support resolution of Pointer logical identifier.

### Pointer retrieval by Consumers ###

A Consumer is a read-only client of the NRLS. All interaction with the NRLS is predicated on the Consumer having a verified NHS number prior to retrieving Pointers. How this NHS number is retrieved is not the concern of the NRLS.
Once the Consumer has a verified NHS number the NRLS can be asked to retrieve a collection of Pointers that relate to that number. The NRLS looks for Pointer’s whose Patient property matches the NHS number query parameter. On this basis the NRLS will return a collection of zero or more matching Pointers.
Note that in order to execute this kind of query a client must have been assigned the Consumer role. A Provider is not authorised to query the NRLS in this way unless they have also been placed in the Consumer role.

### Record retrieval by Consumers ###

TODO

## Data model ##

In order to support the Consumer and Provider interactions with the NRLS the Pointer has been rarefied into a data model. The data model is purposefully lean, each property has a clear reason to exist and it directly supports the activities of the Consumer and/or Provider.

[TODO – diagram]




| Property | Cardinality | Description | 
|-----------|----------------|------------|
|Identifier|0..1|Assigned by the NRLS at creation time. Uniquely identifies this record within an instance of the NRLS. Used by Providers to update or delete.|
|Version |0..1|Assigned by the NRLS at creation or update time. Used to track the current version of a Pointer to support optimistic locking when performing updates or deletes.|
|Patient|1..1|The Patient that the record referenced by this Pointer relates to. Supports Pointer retrieval scenarios.|
|Pointer owner|1..1|The entity who maintains the Pointer. Used to control which systems can modify the Pointer|
|Record owner|1..1|The entity who maintains the Record. Used to provide the Consumer with context around who they will be interacting with if retrieving the Record.|
|Record creation datetime|0..1|The date and time (on the Provider’s system) that the record was created. Note that this is an optional field and is meant to convey the concept of a static record.|
|Record type|1..1|The clinical type of the record. Used to support searching to allow Consumers to make sense of large result sets of Pointers.|
|Record URL|1..1|The location of the record on the Provider’s system|
|Record mime type|1..1|Describes the format of the record such that the Consumer can pick an appropriate mechanism to handle the record. Without it the Consumer would be in the dark as to how to deal with the Record|
|Record retrieval mode|1..1|Whether or not this Pointer facilitates direct or indirect Record retrieval. Used to give the Consumer a que as to what following the Pointer will return.|


## Principles ##

### The NRLS defines a controlled scope around record retrieval ###

One of the key capabilities of the NRLS is to provide enough context in a Pointer to allow a Consumer to retrieve the Record that it relates to. Clearly there are a myriad of different ways that data can be exposed for consumption and providing a context model that is capable of describing all of these options is a non-trivial task.  
With this complexity in mind the NRLS has taken the decision to place some control around how Providers are expected to expose their Records if they are to be described by a Pointer.  
In the first instance the NRLS mandates a single access mechanism; a HTTPS GET to retrieve a Record. Over time the ambition is that NRLS will support other access mechanisms but in the short term the above restriction should be seen as a tactical solution designed to allow the NRLS to concentrate on delivering value based on what is known today.
Clearly issuing a GET to retrieve a record is only one part of the task. Accessing records in a secure fashion is also an important consideration. Again, just as there are many ways to expose a Record, there are many ways to securely expose a Record. Taking a similar tack, the NRLS is predicated around the principle of placing a degree of control over how Providers securely expose their Records for consumption via a Pointer. The mechanism that has been selected in the first instance is mutual authentication over HTTPS. More detail can be found in the security section. Again as with the control around the mechanism of Record retrieval, the NRLS sees the use of mutual authentication as the initial offering, the ambition is to increase the supported security models as more information is gathered.

### The NRLS supports varying levels of digital maturity ###

The NRLS recognises that there will be varying levels of digital maturity across Providers and Consumers. To accommodate this the NRLS has the concept of direct and indirect Pointers which have been discussed above.
The purpose of an indirect Pointer is to provide a lower maturity Provider with a means to surface Records to  Consumers without the need to expose them digitally. An indirect Pointer could point to a set of contact details for a service that can be called to relay a Record over the phone. Similarly if a Consumer does not have the capability to integrate a digital Record into their system an indirect Pointer gives them another mechanism to allow their users to access Records.

### The Consumer controls Pointer access ###

When a Consumer requests that the NRLS return the Pointers that it has for a given patient it will return all Pointers. The NRLS will not perform any filtering before sending that collection of Pointers back to the Consumer. 
Once consequence of this is that the end user on the Consumer side may be exposed to Pointers that reveal sensitive information about the Patient, for example it will be possible to infer through a Pointer that a Patient has a certain kind of record. Even though the user may not be able to retrieve the Record, knowing that it exists is in itself revealing a degree of personal information about that patient that may not be appropriate. 
With this in mind it is acknowledged that there is most likely going to be a need to filter Pointers before they are displayed to the end user. This responsibility is seen as belonging to the Consumer where local access rules will be used to judge whether or not a given user should be permitted to know that a given Pointer exists.
The mechanism for making this decision is predicated on the type of Record that the Pointer references. 

[TODO Diagram 4]

### The Provider controls Record format ###

The NRLS takes the stance that it is for the Provider to determine what format its Records should be delivered in. Whether or not the Consumer can handle that format is not the concern of the Provider and nor is it the concern of the NRLS. The NRLS expects that a Provider will create a Pointer with additional contextual information (i.e. mime type) to help the Consumer determine the appropriate way to handle the Record.

## Interactions ##

In the overall solution for NRLS broadly speaking there are four main systems that need to integrate in order for systems to share data. Diagram 1


| System | Role in NRLS solution | 
|-----------|----------------|
|Consumer|A system that wishes to retrieve Pointers related to a given patient (NHS number) and optionally follow one or more of those Pointers to retrieve the record that they each point to.|
|Provider|A system that wishes to expose its Records for sharing.|
|NRLS|A system that exposes Pointers for retrieval and maintenance.|
|Spine Security Proxy (SSP)|Facilitates the retrieval of Records referenced by Pointers.|


### Provider interaction ###

[Diagram 3]

### Consumer interaction ###

[Diagram 2]
-->