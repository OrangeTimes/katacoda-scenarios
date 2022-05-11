

# range operator 
 When somebody specifies a array of properties you need to use some loop functionality to dynamically fill in the template
Many programming languages have support for looping using for loops, foreach loops, or similar functional mechanisms. 
In Helm's template language, the way to iterate through a collection is to use the range operator.
## Example
Imagine we have next 

values yaml
```
favorite:
    drink: coffee
    food: pizza
pizzaToppings:
    - mushrooms
    - cheese
    - peppers
    - onions
```
template.yaml  
```
{{- range .Values.pizzaToppings }}
+ {{ . }}
{{- end }}
```

Helm will generate next text

```
+ mushrooms
+ cheese
+ peppers
+ onions
```

Lest analyze the range function: range .Values.pizzaToppings will set the . variable to point to each ofthe individual values in .Values.pizzaToppings

{{ . }} renders the current value present in loop iteration

If . is some complex object you can access its properties as well like so: {{ .key }}


# Practical task

Ok so let's learn by doing. Do next tasks in current helm chart

>**Task 1: Update the values.yaml to add a list of hosts**
```
hosts:
  - host1.example.com
  - host2.example.com
  - host3.example.com
  - host4.example.com
  - host5.example.com
```


>**Task 2: Add new property to hpa.yaml**
```
data:
  hosts: 
    # replace this comment with range function. Indentation of all hosts should be 4 whitespaces.
```

>**Task 3: Update the hpa.yaml to use range operator in order to display all 5 hosts from values.yaml in rendered template**

>**Task 4 (Optional): Use the quote function to wrap each of the url in quotes**


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