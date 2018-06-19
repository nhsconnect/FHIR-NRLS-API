---
title: Pointer Lifecycle
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_pointer_lifecycle.html
summary: NRLS Pointer Lifecycle
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


## Maintaining Pointers ##

A Pointer is a reference to a Record. From the perspective of NRLS that resource is held on a remote system. It has its own lifecycle that is managed by a third-party (the Record owner). The state of the Pointer should reflect the state of the referenced Record so that Consumers are able to make informed decisions around whether or not a Pointer is worth following or given the choice of more than one Pointer which is the most appropriate to follow.


## Pointer Status ##

The Pointer has the concept of a status. The status provides a means for a Consumer to understand whether the Pointer references the “current” Record. The definition of “current” is under the control of the Provider but a Consumer should be confident that by selecting the latest Pointer they will be presented with what the Provider considers to be the most appropriate for Consumers to use. 

## Advice for Providers ##

### Creation of a new Pointer ###

The rules around when a Pointer is created will vary from Provider to Provider because different business process’ will be at play within their organisations. Having said that there is some general guidance that can be given around when creation of a new pointer is appropriate.

As discussed in the concepts section (TODO – link) the NRLS has the concept of a static and dynamic content in relation to what the Pointer is referencing. Static content will never change whereas a dynamic content is not guaranteed to be the same from one point in time to another in the future.

Static content is typically content that undergoes version control. When a change is needed rather than changing the contents directly a new version is created. This new version builds on the original and contains the modified content. Once the changes are complete this new version is then considered immutable and becomes the current version replacing the previous one.

Rather than NRLS holding one Pointer that references the current version of the contents it is recommended that Providers add a new Pointer for each version of their content. What constitutes a new version is left up to the Providers as it is difficult to prescribe a global versioning policy.

What is expected however is that there is only over one current version of a Pointer for a set of content. Therefore, a Pointer that references content that supersedes existing content then the Pointer that references that existing content must be marked as superseded using the NRLS’ update mechanism.

Dynamic content makes none of the guarantees that static content makes. With static content the consumer can be certain that the content will always be the same regardless of the time it was retrieved. Contrast this with dynamic content where the contents can vary depending upon when it was retrieved. 

Dynamic content will typically be served up via an API. It is the lifecycle of the API that can be used to decide when referenced content has changed sufficiently so as to warrant an existing Pointer being superseded.

Examples of the kinds of things that Providers should consider as triggers to cause a Pointer to be superseded are:

#### API Contract ####

Changes to the way that a Consumer would interact with the API. This can cover changes in a number of areas:

- Data model – if the model that the contents conforms to is changed then the Consumer may no longer be able to interpret the contents
- Mime type – if the format of the contents as it is delivered to the Consumer changes then then Consumer may no longer be able to render the contents
- Security – if the mechanism for accessing secured content changes then the Consumer may not be able to access the contents
- Protocol – if the way that the content is exchanged between Provider and Consumer then the Consumer may no longer be able to negotiate content retrieval

#### API Data sources ####

It is possible that the API is drawing data from multiple sources before aggregating the contents ready for the Consumer. If the aggregating system is modified to draw data from additional sources or one source is replaced with another then the contents could be considered to have changed 
to such a degree that it should be reflected by superseding the current Pointer.


#### Deletion of an existing Pointer ####

Deletion of a Pointer is an exceptional action to take. Under most circumstances a Pointer should be updated and marked as superseded. If the Provider realises that the Pointer is simply not valid then it should be updated and marked as entered in error. If the Provider does want to delete the Pointer it should be done as soon as possible after creation to limit exposure to Consumers. 
However even in this circumstance the Provider should consider marking the Pointer as entered in error.

#### Update of an existing Pointer ####

As noted in the create section typically update will be invoked on a Pointer when the Provider needs to change its status from current to one of superseded or entered in error. In general Providers should refrain from changing any of the other properties on an existing Pointer instead preferring to create a new one.










