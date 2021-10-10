variable "city_zone"{
    type = string
    description = "Specifies the city and zone the resource will be deployed to"
    default = "sfo3"

    validation {
      condition = contains(["sfo1", "sfo2", "sfo3", "nyc1", "nyc1"," nyc3"], var.city_zone)
      error_message = "The city_zone value must be in sfo1, sfo2, sfo3, nyc1, nyc1, or nyc3."
    }
}

variable "project_name" {
    type = string
    description = "Name of the project"
    default = "cryptohodl"
}

variable "db_engine" {
    type = string
    description = "Type of databse getting generated"
    default = "mongodb"

    validation {
      condition = contains(["pg", "mysql", "redis", "mongodb"], var.db_engine)
      error_message = "The db_engine value must be in pg (PostreSQL), mysql (MySQL), redis (REDIS) , or mongodb (MongoDB)."
    }
}

# variable "city_zone"{
#     type = string
#     description = "Specifies the city and zone the resource will be deployed to"
#     default = "sfo3"
#     validation {
#       condition = contains(["sfo1", "sfo2", "sfo3", "nyc1", "nyc1"," nyc3"], var.city_zone)
#       error_message = "city_zone value must be in sfo1, sfo2, sfo3, nyc1, nyc1, nyc3"
#     }
# }

locals {
  ch_db_name = "${var.db_engine}-${var.city_zone}-${var.project_name}"
}


# Variables inherited from terraform cloud (secrets)
variable "do_token" {}