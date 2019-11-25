= BigID Deplyoment on AWS Marketplace
:source-hightlighter: pygments
:toc:


== Overview 

In an environment of record breaches of personal information and a proliferation of global privacy regulations, BigID aims to transform how enterprises protect and manage the privacy of personal data.

BigID provides purpose-built technology to help organizations track and govern customer data at scale. By bringing data science to data privacy, BigID aims to give enterprises the software to safeguard and steward the most important asset organizations manage: their customer data.

BigID’s solution facilitates a bottom-up, correlation-driven approach for discovering, indexing, and inventorying personal and private data by specific identities. BigID is designed to automatically update data inventories and flows as new data sources come online or when the underlying data changes.

BigID generates a comprehensive mapping of identities, attributes, and distribution of personal data through automated scanning of configured data sources and applications.

For more information: https://bigid.com

== Description
Use Cloudformation templates to deploy BigID Application and MongoDB Server (Dual Server)

== Contents
This repository contains a set of https://aws.amazon.com/cloudformation/[AWS CloudFormation] YAML templates that allow you to deploy BigID using your AWS account.


== Step-by-step
=== Step 1: Subscribe on the AWS Marketplace
https://docs.aws.amazon.com/marketplace/latest/buyerguide/buyer-getting-started.html[AWS Marketplace]

=== Step 2 : Configure a VPC and EC2 Key Pair (Optional)
To run the AWS CloudFormation templates in this repository, you must set up an http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Introduction.html[AWS VPC] and an http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html[EC2 Key Pair]. If these are already created, you can go directly to the next step.


If you want to setup a fresh VPC with, click the below launch button:

image:https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png[link=https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=XLJetPack-VPC&templateURL=https://s3.amazonaws.com/xl-jetpack-aws/setup-vpc.yaml]

=== Step 3 : Launch BigID CloudFormation stack
This step will provision BigID host and MongoDB Server

image:https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png[link=https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=XLJetPack-VPC&templateURL=https://bigid-aws.s3.amazonaws.com/cfn-hup.yaml]

Click on "Launch Stack" above or
In AWS Console > Services > CloudFormation > Stacks > Create stack Select “Upload a template file” and click “Choose file” and choose cfn-bigid.yaml file and click “Next”
![alt text](https://github.com/bigexchange/bigid-aws-marketplace-byol/blob/master/images/step1.png)
