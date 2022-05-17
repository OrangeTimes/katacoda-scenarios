# using overiddes

We often need to specify overrides for some specific environment

Helm provides multiple level of specificity in order to give ability to user to override required values if needed using:

1. The values.yaml file in the chart   
2. If this is a subchart (child chart referenced in parent), the values.yaml file of a parent chart   
3. A values file if passed into ```helm install``` or ```helm upgrade``` , ```helm template``` with the -f flag
4. Individual parameters passed with ```--set``` (such as ```helm install --set foo=bar ./mychart```)

The list above is in order of specificity: values.yaml is the default, which can be overridden by a parent chart's values.yaml, which can in turn be overridden by a user-supplied values file, which can in turn be overridden by --set parameters.
Most often we will use -f flag during running some of the helm commands

# Practical task

Ok so let's learn by doing. Do next tasks in current helm chart

>**Task 1: Create new values.yaml file inside in ~/chart/overrides folder**

>**Task 2: Update the values.yaml located in ./overrides folder to change application name to workshop**

>**Task 3: Update the values.yaml located in ./overrides folder so max replicas should be set 2 in the end result**
  
You can create create new values.yaml by running next commands 

`mkdir ~/chart/overrides && touch ~/chart/overrides/values.yaml `{{execute}}
>you may need to refresh the editor after this


Render template on your own by running next command

`helm template ~/chart -f ~/chart/overrides/values.yaml `{{execute}}

if validation fails you can view test results:

`cat /tmp/TestResult.txt`{{execute}}

<details>
  <summary>Hint 1</summary>  
    You can just copy the needed properties from values.yaml and put inside the values.yaml in /overrides/ folder.
</details>

