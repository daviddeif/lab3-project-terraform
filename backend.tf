terraform {

  backend "s3" {
    bucket = "bucket-for-statefile-david"
    key    = "tfstatefile"
    region = "us-east-1"
    
  }

}