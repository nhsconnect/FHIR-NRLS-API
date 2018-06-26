---
title: API Update Interaction
keywords: structured, update, rest, documentreference
tags: [rest,fhir,documents,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: api_interaction_update.html
summary: To support the update of NRLS pointers
---

{% include custom/search.warnbanner.html %}

{% include custom/fhir.reference.nonecc.html resource="DocumentReference" resourceurl= "https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1" page="" fhirlink="[DocumentReference](https://www.hl7.org/fhir/STU3/documentreference.html)" content="User Stories" %}


## Update ##

API to support the update of NRLS pointers. This functionality is only available for providers.
The update functionality will be used in cases where a Provider wishes to deprecate the Document that the current DocumentReference points to and replace it with a new version.

The end result will be that the DocumentReference that is being superseded will have a status of "superseded" and there will be a newly created DocumetReference that points to the new version of the Document.

To perform this activity the client (Provider) will POST a new DocumentReference that points to the new document. Within that DocumentReference the relatesTo property will have been populated. 
See the [create](/api_interaction_create.html) interaction for more information about creating a pointer.

Along with creating the new DocumentReference for each element in relatesTo that targets a DocumentReference the NRLS should perform the following checks and actions -

1. Ignore any relatesTo element where the code property's value is not "replaces"
2. Ensure that the related DocumentReference exists. 
3. Ensure that the requesting party has permissions to modify the related DocumentReference.
4. Set the status on the linked DocumentReference to “superseded”
5. Calculate the versionId of the new (to be created) current DocumentReference as follows -
6. Take the value of the versionId property from the superseded DocumentReference
7. Increment the value by one
8. Use incremented value as the versionId in the new (to be created) current DocumentReference
9. Persist the change

### Ensure that the related DocumentReference exists ###

Concretely the target property within the relatesTo property will be a FHIR Identifier whose system and value properties should be non-null and not empty.
The Identifier should be interpreted as the masterIdentifier of a DocumentReference held within NRLS.

The masterIdentifier is unique within the scope of a patient.

In order to ensure that the masterIdentifer resolves to a DocumentReference the NRLS will need to pull back the DocumentReferences for the patient in question. This patient’s NHS number can be found in the subject field of the DocumentReference containing the relatesTo collection.

Once those DocumentReferences have been retrieved then the masterIdentifier value (if present) will need to be compared to the Identifier in the relatesTo collection. For the Identifier to be considered equal to the masterIdentifer of a given DocumentReference both the system and value properties should be equal. They should be interpreted as String values whose cases should match.

### Ensure that the requesting party has permissions to modify the related DocumentReference ###

Assuming that a DocumentReference has been matched (see Ensure that the related DocumentReference exists) the NRLS needs to ensure that the client making the request has permission to modify the given DocumentReference.

Extract value from the custodian property of the matched DocumentReference. Ensure that it is equal to the custodian property from the DocumentReference containing the relatesTo collection. The custodian values should be interpreted as Strings whose cases should match.

Ordering of validation - Note that it is assumed that the above check takes place after the following checking -

It has been established that the client making the request is a Provider
The ODS code associated with the value of the fromASID HTTP header matches the ODS code in the custodian field of the DocumentReference containing the relatesTo collection.


### Example of a populated relatesTo property ###
```
"relatesTo":[
{  
	"code": "replaces",
	"target":  
	{ 
		"DocumentReference":
		{
			"Identifier":   
			{ 
				"value": "305e16ba-e676-4af7-8686-4faffddcf238",
				"system": "1.3.6.1.4.1.21367.100.1"  
			}
		}
	}
}
]
```



## Response ##

See [Create Response](/api_interaction_create.html#create-response) foe the response behaviour and codes.


## relatesTo - Validation ##

The DocumentReference.relatesTo property should be supported such that a Provider can create a DocumentReference with that property set.

When a Consumer retrieves a DocumentReference if the relatesTo is set then it should be included in the returned DocumentReference.

The relatesTo property is a collection where each element must contain both of

- target - FHIR Reference instances. Within each instance the Identifier field must be populated and within the Identifier the system and value properties must be set. (see below).
   
- code - which must be one of - replaces, transforms, signs, appends

It should be possible for a Provider to add more than one element to the relatesTo property.

#### a. Mandatory Properties ####

If any of the mandatory fields listed above are missing the following response is returned to the client -

|HTTP response code |	400|
|Response body 	|OperationOutcome conforming to the https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1 profile|
|OperationOutcome.issue.severity |	error|
|OperationOutcome.issue.code |	invalid
|OperationOutcome.issue.details.coding.system |	https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1|
|OperationOutcome.issue.details.coding.code |	INVALID_RESOURCE|
|OperationOutcome.issue.details.coding.display 	Resource is invalid: relatesTo|
|OperationOutcome.issue.diagnostics| 	Both of the target and code properties must be set and the reference must be an Identifier where both the system and value properties are set.|

#### b. System and Value validation ####

The *relatesTo.target.system*  and *relatesTo.target.value* properties of the masterIdentifier are mandatory and must not be empty. If not then the response below should be returned to the client -

|HTTP response code |	400|
|Response body |	OperationOutcome conforming to the https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1 profile|
|OperationOutcome.issue.severity |	error|
|OperationOutcome.issue.code |	invalid|
|OperationOutcome.issue.details.coding.system |	https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1|
|OperationOutcome.issue.details.coding.code |	INVALID_RESOURCE|
|OperationOutcome.issue.details.coding.display |	Resource is invalid: [masterIdentifier.value\|masterIdentifier.system]|
|OperationOutcome.issue.diagnostics |	One of the Identifiers from the relatesTo field is missing one or both of the mandatory value and system properties.|

#### c. Code validation ####

The code property of the relatesTo must be set to one of the following values - 

- replaces
- transforms
- signs
- appends

Where the supplied value is outside of this set then the response below should be returned to the client -

|HTTP response code |	400|
|Response body |	OperationOutcome conforming to the https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1 profile |
|OperationOutcome.issue.severity |	error|
|OperationOutcome.issue.code |	invalid|
|OperationOutcome.issue.details.coding.system |	https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1|
|OperationOutcome.issue.details.coding.code |	INVALID_RESOURCE|
|OperationOutcome.issue.details.coding.display |	Resource is invalid: relatesTo.code|
|OperationOutcome.issue.diagnostics |	The code must be one of replaces, transforms, signs or appends|



## masterIdentifier - Validation ##

The DocumentReference.masterIdentifier property should be supported such that a Provider can create a DocumentReference with that property set.

When a Consumer retrieves a DocumentReference if the masterIdentifier is set then it should be included in the returned DocumentReference.


#### a. Mandatory properties  ####
Note that masterIdentifier is not a mandatory element but if it is supplied then the masterIdentifier.system and masterIdentifier.value properties must be set. If either one of these is not set then the following response should be returned to the client

 
|HTTP response code |	400|
|Response body |	OperationOutcome conforming to the https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1 |profile
|OperationOutcome.issue.severity 	|error|
|OperationOutcome.issue.code |	invalid|
|OperationOutcome.issue.details.coding.system |	https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1|
|OperationOutcome.issue.details.coding.code |	INVALID_RESOURCE|
|OperationOutcome.issue.details.coding.display| 	Resource is invalid: [masterIdentifier.value|masterIdentifier.system]|
|OperationOutcome.issue.diagnostics |	If the masterIdentifier is supplied then the value and system properties are mandatory|


#### b. Unique masterIdentifer ####
When the NRLS persists a DocumentReference with a masterIdentifier it should ensure that no other DocumentReference exists for that patient with the same masterIdentifier.

Two masterIdentifiers will be considered the same where the following is true of the system and value properties of the masterIdentifers - 

- system property is identical (case sensitive)
- value property is identical (case sensitive)

If this is not the case then the response below should be returned to the client -

 
|HTTP response code |400|
|Response body |	OperationOutcome conforming to the https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1 profile|
|OperationOutcome.issue.severity |	error|
|OperationOutcome.issue.code |	invalid|
|OperationOutcome.issue.details.coding.system |	https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1|
|OperationOutcome.issue.details.coding.code |	DUPLICATE_REJECTED|
|OperationOutcome.issue.details.coding.display |	Duplicate DocumentReference|
|OperationOutcome.issue.diagnostics |	Duplicate masterIdentifier value: [relatesTo.target.value] system: [relatesTo.target.system]|



## Example ##
### A DocumentReference example including the relatesTo and masterIdentifier element ###

<script src="https://gist.github.com/sufyanpat/a979b89f3cc81cf59157c68c8a866244.js"></script>