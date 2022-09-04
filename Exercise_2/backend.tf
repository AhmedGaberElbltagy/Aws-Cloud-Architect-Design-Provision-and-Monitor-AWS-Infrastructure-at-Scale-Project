terraform {
    backend "s3" {
        bucket = "terraformstateversioning"
        key = "tterraform.tfstate" 
        region = "us-east-1"
    }
}