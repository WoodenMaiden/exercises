# Get token from fly.io

```bash
fly auth login
```

This will open a browser window asking you to connect

then you can get a token for terraform this way: 

```bash
export FLY_API_TOKEN=$(fly auth token)

# ou 

echo "flyio_token=\"$(fly auth token)\"" >> terraform.tfvars
```
