# Amazon EC2 AMI

### Requirements

Download and install __[Packer](https://www.packer.io/downloads.html)__ to generate images.

#### `aws.json`

Create a file in the __`amazon_ec2/packer`__ directory named `aws.json` and enter your service details:

```json
{
  "aws_access_key": "<AWS_ACCESS_KEY>",
  "aws_secret_key": "<AWS_SECRECT_KEY>",
}
```

> TIP: Don't commit the `aws.json` file to version control!

#### `variables.json`

Customize the installation options in the `variables.json` file:

```json
{
  "aws_host_name": "your.aluxa.server",
  "aws_source_ami": "ami-fce3c696",
  "aws_region": "us-east-1",
  "aws_instance_type": "t2.micro"
}
```

|Key|Value|Default|
|----|-----|-------|
|`aws_host_name`|Your host domain name (FQDN).|null|
|`aws_source_ami`|Must be Ubuntu 14.04. ID varies by region|ami-fce3c696 (us-east-1)|
|`aws_region`|The EC2 region this AMI will reside in.|us-east-1|
|`aws_instance_type`|The size of the AMI resource.|t2.micro|

## Generate AMI

_To create the AMI..._

Navigate to the `amazon_ec2/packer` folder using a terminal program.

Enter and run the following:

```shell
packer validate -var-file=aws.json -var-file=variables.json aluxa.json
```
___If the `.json` files "validate" then continue, if not, fix em up.___

Once "valid", run the following:
```shell
packer build -var-file=aws.json -var-file=variables.json aluxa.json
```

__The AMI should become available within 10 minutes, and is marked `private`.__
