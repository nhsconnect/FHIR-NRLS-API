---
title: Connection Code
keywords: structured, rest
tags: [rest,fhir,api,noccprofile]
sidebar: accessrecord_rest_sidebar
permalink: connectioncode_example.html
summary: Connection code Examples
---

{% include custom/search.warnbanner.html %}

## Common NRLS Connection Code Examples ##

### Connecting with C# ###

The following code samples are taken from the NRLS Demonstrator application which has both Consumer and Provider client implementations built in. More information about the design solution can be found
on the [NRLS Demonstrator Wiki](https://github.com/nhsconnect/nrls-reference-implementation/wiki)

To start we create a base command request model that defines the type of request we want to make (GET, POST or DELETE) and then sets the required attributes.
Within the model the full url to the NRLS API is constructed including appending any required parameter values passed in.

At this point we also generate our JWT using the ASID, ODS Code and User Role Profile ID values that are passed in.

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.NRLSAdapter/DocumentReferences/DocumentReferenceServices.cs#L91-L112 %}
{% highlight csharp %}
{% github_sample /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.NRLSAdapter/DocumentReferences/DocumentReferenceServices.cs 90 111 %}
{% endhighlight %}
</div>

Once we have our command request model we call the FhirConnector service to start the actual call to the NRLS.
We first build our HTTP message. At this point we also add in our NRLS specific headers that are held in our base request model and add in our DocumentReference model (http content) if we are performing a create (POST).

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.NRLSAdapter/Helpers/FhirConnector.cs#L115-L144 %}
{% highlight csharp %}
{% github_sample /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.NRLSAdapter/Helpers/FhirConnector.cs 114 143 %}
{% endhighlight %}
</div>

Then we add in our certificate handling for mutual authentication:

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.NRLSAdapter/Helpers/FhirConnector.cs#L100-L111 %}
{% highlight csharp %}
{% github_sample /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.NRLSAdapter/Helpers/FhirConnector.cs 99 110 %}
{% endhighlight %}
</div>


Next we make the call to the NRLS API and then parse the response.
Here we are expecting either a FHIR Bundle or a FHIR OperationOutcome both of which inherit from a FHIR Resource.
There is a check here to see if we have a success type HTTP response code. If not then we immediately raise an error.

<div class="github-sample-wrapper">
{% github_sample_ref /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.NRLSAdapter/Helpers/FhirConnector.cs#L48-L92 %}
{% highlight csharp %}
{% github_sample /nhsconnect/nrls-reference-implementation/blob/master/Demonstrator/Demonstrator.NRLSAdapter/Helpers/FhirConnector.cs 47 91 %}
{% endhighlight %}
</div>

{% include note.html content="The code in these examples is standard C# v7.2 taken direct from the [NRLS Demonstrator](https://nrls.digital.nhs.uk) code.<br /><br />The official <b>[.NET FHIR Library](https://ewoutkramer.github.io/fhir-net-api/)</b> is utilised to construct, test, parse and serialize FHIR models with ease." %}
