# Check helm

Check that Helm installed correctly

`helm version`{{execute}}

Expect to see
```shell
Version:"v3.2.2"
```

# value.yaml intro

We already have a helm deployment ready
All the configuration is stored in a special file called values.yaml
Please take some time to analyze this file

`values.yaml`{{open}}
# templates intro

Next important file it's the kubernetes template itself located in ./templates folder 
Please take some time to analyze this file

`templates/hpa.yaml`{{open}}