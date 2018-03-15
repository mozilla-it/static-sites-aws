# S3 website hosting

### Summary

This `s3_website` Terraform module allows us to quickly build and manage our
websites that are hosted in S3.

### Usage

Deploying a new website requires six steps:

1. Copy the template folder and rename the folder to the domain of the website
you are deploying
   * An example might be: `cp -r template/ release.mozilla.org/`
2. Create an ACM certificate and make a note of the ARN
   * Login to the AWS account where you will deploy this website
   * Select the `us-east-1` region
   * Access the Amazon certificate manager
   * Request the certificate. Once it is approved, capture the ARN
3. Work with our team to get a GitHub user access token and make a note of it
4. Write a `buildspec.yml` file in the new directory that you created
   * For our team, we can help each other to write a valid file. The contents
     will depend on the website we are deploying. If it’s a Jekyll blog, we will
want to run the `jekyll build` command. If it’s a simple static website with no
build process, we can just run `aws s3 sync` to the relevant S3 bucket
5. Open the `variables.tf` file in the directory that you created and provide a
relevant value for each variable
6. Open the `terraform.tf` file, make sure the S3 bucket exists in the account
you are deploying to and update the key so you are no overwriting another
website’s state file

### Contributions

We are more than happy to receive GitHub Issues, pull requests, questions,
concerns or feedback about how this module can be improved.

