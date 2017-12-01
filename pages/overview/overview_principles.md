---
title: Solution Principles
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_principles.html
summary: Solution Principles
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


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