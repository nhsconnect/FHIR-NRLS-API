---
title: Pointer Maintenance
keywords: engage, about
tags: [pointer]
sidebar: overview_sidebar
permalink: pointer_maintenance.html
summary: NRL Pointer Maintenance
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRL API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}

{% include warning.html content="
The current version of the NRL API does not give Providers the ability to update the properties of an existing Pointer. 
The only property that can be modified is the status and that is done in a very specific way only allowing a Provider to replace one 
pointer with another [Managing Pointers](pointer_maintenance.html#managing-pointers-to-static-content).
<br/>
This means that a number of scenarios outlined below around updating a Pointer can not yet be achieved though the NRL intends to support these features in a future release. 
<br/>
Specifically the NRL API does not currently support- <br/>

- The following status property transitions:<br/>

	&emsp; o **current** to **entered-in-error**<br/>
	&emsp; o **entered-in-error** to **current**<br/>
	&emsp; o **current** to **superseded** where the current Pointer is not being replaced.<br/>
	
- Modification of other properties<br/>
" %}

## Pointer Maintenance ##

The NRL allows a Provider to perform three actions in relation to Pointers –
- Create – results in the storage of a brand new Pointer in NRL
- Update – modify the content of an existing Pointer in NRL
- Delete – remove an existing Pointer from NRL. This Pointer will no longer appear in search results

A Pointer’s main role is to refer to another entity; some kind of content (static or dynamic). 
So when considering Pointer maintenance we should really think in terms of the maintenance of two entities -

1.	Changes to the Pointer’s data – the referenced content has not changed but one or more of the data items captured on the Pointer needs to be modified. In this case an update of the existing resource is appropriate but will be discussed in more detail below
2.	Changes to the referenced content – in this instance Providers should create a new Pointer which references the modified content


## Creation of a new Pointer ##

The rules around when a Pointer is created will vary from Provider to Provider because different business process’ 
will be at play within their organisations. Having said that there is some general guidance that can be given around when creation 
of a new pointer is appropriate.
As discussed in the [concepts section](overview_concepts.html) the NRL has the concept of a static and dynamic content in relation to what the 
Pointer is referencing. Static content will never change whereas a dynamic content is not guaranteed to be the same from one point in 
time to another in the future.

#### Static content ####

Static content is typically content that undergoes version control. When a change is needed rather than changing the contents directly 
a new version is created. This new version builds on the original and contains the modified content. Once the changes are complete this new version is then considered immutable and becomes the current version replacing the previous one.
Rather than NRL holding one Pointer that references the current version of the contents it is recommended that Providers add a new Pointer for each version of their content. 
What constitutes a new version is left up to the Providers as it is difficult to prescribe a global versioning policy.
What is expected however is that there is only over one current version of a Pointer for a set of content. 


<img src="images/pointers/pointer_maintenance1.png">

***Figure 1: how different versions of static content are reflected in NRL. For each new version of static content a new
 Pointer is created with a status of current and the previous version moves from current to superseded.***

#### Dynamic content ####

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

It is possible that the API is drawing data from multiple sources before aggregating the contents ready for the Consumer. 
If the aggregating system is modified to draw data from additional sources or one source is replaced with another then the contents could be considered to have changed to such a degree that it should be reflected by superseding the current Pointer.

#### API address & deprecation ####
If the location of the API changes or the API becomes deprecated then a new Pointer should be created and the old one marked as superseded 
to prevent Consumers from attempting to retrieve contents from a non-existent or non-current location.


## Deletion of an existing Pointer ##

Deletion of a Pointer is an exceptional action to take. Under most circumstances a Pointer should be updated and marked as superseded. 
If the Provider realises that the Pointer is simply not valid then it should be updated and marked as entered in error. 
If the Provider does want to delete the Pointer it should be done as soon as possible after creation to limit exposure to Consumers. 
However even in this circumstance the Provider should consider marking the Pointer as entered in error.

## Update of an existing Pointer ##

As noted in the create section typically update will be invoked on a Pointer when the Provider needs to change its status from 
current to one of superseded or entered in error. In general Providers should refrain from changing any of the other properties on an 
existing Pointer instead preferring to create a new one. 

## Managing Pointers to static content ##

As noted in the create section where a new version of static content is created the NRL prefers that a new Pointer be created to 
reference that static content. This is as opposed to the existing Pointer being modified to reflect the new content.
For more detail see figure 2 but in brief each time a new version of a Pointer is created the existing one should be marked as superseded 
and the new Pointer becomes current.
The way that this is achieved is through the combined use of three properties on the Pointer – 

1.	Status
2.	Master Identifier
3.	Related Pointers

<img src="images/pointers/pointer_maintenance2.png">

***Figure 2: How Pointers versions are maintained in NRL. Each time a new Pointer version is needed the create message should 
reference the master identifier of the Pointer that is to be superceded***

When the first version of a Pointer is created the Provider supplies it’s status as current and it assigns a master identifier 
value (value is 1 in figure 2). Note that master identifier is optional however if Provider’s wish to use the NRL to maintain a chain of 
Pointer versions then master identifier will be required. In this first version of the Pointer the related pointers collection will be empty.

The end result of asking the NRL to create that Pointer is illustrated on the left-hand side of figure 2 above – a Pointer has been persisted with a Provider issued master identifier and a status of current.

At some point in the future the Provider determines that a new version of the Pointer should be created perhaps because the static content that the original Pointer references has changed. In this case the Provider wants the end state to be that a new Pointer is created to reference the new static content and that the existing Pointer is marked as superseded.

The NRL supports the transition to the end state above by leveraging the related pointers property in conjunction with master identifier and status. The Provider creates a new Pointer where the status is marked as current, it has a master identifier value (value is 2 in figure 2) that is different from the existing Pointer’s master identifier (see Pointer identity for more detail) and the related pointers collection is populated with the master identifier of the existing Pointer (value is 1 in figure 2). 

Upon receipt of this Pointer the NRL takes the resolves the related Pointer and sets its status to superseded. Once this has been successfully completed the NRL persists the new pointer. The end result is that the NRL is now in the state described above; two Pointers exist where one has been superseded by the other. This pattern of superseding can be repeated indefinitely by a Provider leading to multiple superseded versions of a Pointer but there is only ever one current version.


## Pointer lineage ##
A consequence of creating a relationship between Pointers where one superseded another is that a lineage of Pointers is created. 

In this context lineage is used to describe the line of descendants of an original Pointer. This line in effect describes each of the different versions of the content that each Pointer references. It’s a view of the evolution of the content with the oldest content being replaced by newer content.

The related Pointer element of a given Pointer can be used to find its direct ancestor and once that ancestor is found if it has a related Pointer element then that relationship can be resolved and so on until the entire lineage is built up.

<img src="images/pointers/pointer_lineage.png">

<b>Figure 3: Pointer lineage.</b> As soon as a Pointer is replaced (superseded) by another one then a linage of related Pointers is created. 

Figure 3 above illustrates the lineage concept. Three Pointers exists in NRL (1,2 & 3). Pointer 1 was the original and references content in the Provider’s system. After Pointer 1 was published a new version of the content that it references was created. This triggered the Provider to publish a new Pointer (2) that superseded the Pointer 1. Finally, the process was repeated with Pointer 3 which references the newest version of the content.


