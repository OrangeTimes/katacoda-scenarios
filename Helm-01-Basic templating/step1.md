# Check helm

Check that Helm installed correctly

`helm version`{{execute}}

Expect to see
```shell
Version:"v3.8.0"
```

# value.yaml

We already have a helm deployment ready
All the configuration is stored in a special file called values.yaml
Please take some time to analyze this file

`charts/chart01/values.yaml`{{open}}
# templates folder

Next important file it's the kubernetes template itself located in ./templates folder 
Please take some time to analyze this file

`charts/chart01/templates/hpa.yaml`{{open}}

# templating engine
It has embedded template function. You can spot them since they use ```{{ }}``` notation
You can use values from values.yaml in the template like so
```{{ .Values.property1.property2 }}```

values.yaml
```
property1:
    property2: "Hello world"
```

In the end result helm with output a template with substituted value taken from values.yaml. So ```{{ .Values.property1.property2 }}``` will become  simply

```
Hello world
```
# utility templating functions

You can use utility templating functions by using pipes notation | like so: 
```{{ .Values.property1 | trim }}```
You can use multiple templating functions at the same time like so: 
```{{ .Values.property1 | trim | upper | quote}} ```

Since indentation is important in yaml there are also functions that handle this aspect, and prepend whitespace to property after rendering: 
```{{ .Values.property1 | indent 2 }}```

Full list of supported functions is available here: https://helm.sh/docs/chart_template_guide/function_list/

# task

Ok so let's learn by doing. Fix next issues in current helm chart

>**Issue 1: Fix template to reference the application name correctly**

>**Issue 2: Fix template to reference limits correctly**
  


You can render template on your own by running next command

`helm template ~/charts/chart01`{{execute}}
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


