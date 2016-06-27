# DigitalOcean Image

### Requirements

Download and install __[Packer](https://www.packer.io/downloads.html)__ to generate images.

#### `do.json`

Create a file in the __`digitalocean/packer`__ directory named `do.json` and enter your service details:

```json
{
  "do_token": "<DIGITALOCEAN_API_TOKEN>"
}
```

> TIP: Don't commit the `do.json` file to version control!

#### `variables.json`

Customize the installation options in the `variables.json` file:

```json
{
  "do_host_name": "your.aluxa.server",
  "do_size": "512mb",
  "do_region": "tor1",
}
```

__Properties__

|Key|Value|Default|
|----|-----|-------|
|`do_host_name`|Your host domain name (FQDN).|null|
|`do_region`|The region this image will reside in.|tor1|
|`do_size`|The size of the DigitalOcean resource.|512mb|

## Generate Droplet Image

_To create the Droplet Image..._

  1. Navigate to the `digitalocean/packer` folder using a terminal program.
  1. Enter and run the following:
    ```
    packer validate -var-file=do.json -var-file=variables.json aluxa.json
    ```
    If the `.json` files "validate" then continue, if not, fix em up.
  1. Once "valid", run the following:
    ```
    packer build -var-file=do.json -var-file=variables.json aluxa.json
    ```

__The image should become available within 10 minutes in the "snapshots" area.__
