terraform { 
  cloud { 
    
    organization = "example-org-e34b1a" 

    workspaces { 
      name = "terra-house-ent" 
    } 
  } 
}

module "video_game" {
  source    = "./modules/video_game"
  user_uuid = var.user_uuid
}
