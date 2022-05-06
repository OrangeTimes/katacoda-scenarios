

# tpl function
Sometimes you need to use helm templates like ```{{ .Values.prop }}``` in values.yaml itself.
This is not supported automatically as in template files.

One of the ways how to implement is via rendering tpl function which allows developers to evaluate strings as templates inside a template. This is useful to pass a template string as a value to a chart or render external configuration files. Syntax: ```{{ tpl .Values.<Some property> . }}```
The .  in the example above refers to current scope there to search for the  ```.Values.<Some property>```. Most of the time it is pointed to the ```values.yaml``` file 

Caution: . aka the scope used above is tricky one since in some loops . will refer to internal loop scope. You may need to change it to $ (special symbol that points to .Values) so it points back to global .Values

## Example

values.yaml
```
template: "{{ .Values.name }}"
name: "Tom"
```

deployment.yaml
```
{{ tpl .Values.template . }}
```
Note: inside values.yaml file the yaml property which uses helm syntax should be a string. it  will not work with anything else

In the end result helm will output a template with substituted value taken from values.yaml. So ```{{ tpl .Values.template . }}``` will  simply become

```
Hello world
```

# Global variables
Lets also talk shortly about globals
Global values are values that can be accessed from any chart or subchart (child chart) by exactly the same name. Globals require explicit declaration. You can't use an existing non-global as if it were a global.

Example of global section
values.yaml
```
favorite:
    drink: coffee
    food: pizza
global:
    salad: caesar
```
The global section will be available to all charts parent and child. This is very similar to global scope in some programming languages. So the favorite section is only visible inside chart or by its parent.

Note: Child chart cannot read favorite section (in the example above) if it was defined in some common parent chart. To handle such situation you need to use global section only
# Practical task

Ok so let's learn by doing. Do next tasks in current helm chart

>**Task 1: Add global section to .values yaml with property domain set to "justanswer.local"**

>**Task 2: Add new property 'url' to values.yaml with value set to "{{ .Values.name }}.{{.Values.global.domain }}"**

>**Task 3: Update the hpa.yaml and add new property named url inside the label property. Value of newly added property should function to support rendering of composite url property in values.yaml using tpl function**


Render template on your own by running next command

`helm template ~/chart -f ~/chart/overrides/values.yaml `{{execute}}

if validation fails you can view test results:

`cat /tmp/TestResult.txt`{{execute}}

<details>
  <summary>Hint 1</summary>  
    If you are stuck look again at the syntax and carefully examine the file with embedded helm templates
</details>

<details>
  <summary>Hint 2</summary>  
    Look at  {{ .Values }} syntax
</details>


