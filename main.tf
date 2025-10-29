terraform { 
  cloud { 
    
    organization = "example-org-e34b1a" 

    workspaces { 
      name = "terra-house-ent" 
    } 
     
    hostname     = "app.terraform.io"
  }

  required_version = ">= 1.6.0"
}

module "video_game" {
  source    = "./modules/video_game"
  user_uuid = var.user_uuid
}
