terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  # Credentials only needs to be set if you do not have the GOOGLE_CREDENTIALS set
  #credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}



resource "google_storage_bucket" "demo-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location

  # Optional, but recommended settings:
  storage_class               = var.gcs_storage_class
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 // days
    }
  }

  force_destroy = true
}

resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = var.bq_dataset_name
  project    = var.project
  location   = var.location
}