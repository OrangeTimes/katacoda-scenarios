

# conditionals
Controliing the flow of a template's generation is a functionality there helm really shines
The first control structure we'll look at is for conditionally including blocks of text in a template. This is the if/else block.

The basic structure for a conditional looks like this


## Example with else-if
```
{{ if .Values.jenkins }}
Jenkins
{{ else if Values.azure }}
Azure
{{ else }}
Default
{{ end }}
```
In the example above if  the ```.Values.jenkins```  is set to true in ```values.yaml``` then ```Jenkins``` string is  rendered
If ```.Values.jenkins``` is empty or false but  ```.Values.azure``` is set to true the ```Azure``` string will be rendered. In case both ```.Values.jenkins``` and  ```.Values.azure``` are missing or set to false ```Default``` text
will be rendered

You can also omit else and else-if block like so
## Example with single if
```
{{ if .Values.jenkins }}
Jenkins
{{ end }}
```

# When value is considered false 

A expression inside if helm template block  is evaluated as false if the value is:
1) a boolean false
2) a numeric zero
3) an empty string
4) a nil (empty or null)
5) an empty collection (map, slice, tuple, dict, array) 

Under all other conditions, the condition is true.
# Practical task


Ok so let's learn by doing. Do next tasks in current helm chart

>**Task 1: Update the values.yaml in root folder and add enabled boolean property. Set its value to true**

>**Task 2: Update the kubernetes hpa template to support conditional rendering. The whole template should render or not depending on enabled property value**

>**Task 3: Do not make changes to indentation of template block during update. Yaml requires some initial properties to be set without any indentation to work**

**If you receive such error: mapping values are not allowed in this context it means you have wrong indentation in your yaml. Revert any indentation changes. You can test template on your own by running next command**


Render template on your own by running next each of commands

`helm template ~/chart -f ~/chart/overrides/values.yaml --set enabled="false"`{{execute}}

`helm template ~/chart -f ~/chart/overrides/values.yaml --set enabled="true"`{{execute}}

if validation fails you can view test results:

`cat /tmp/TestResult.txt`{{execute}}

<details>
  <summary>Hint 1</summary>  
    If you are stuck look again at the syntax and carefully examine the file with embedded helm templates
</details>

<details>
  <summary>Hint 2</summary>  
    Look at {{ .Values }} syntax
</details>


