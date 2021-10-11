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
    description = "Type of database getting generated"
    default = "mongodb"

    validation {
      condition = contains(["pg", "mysql", "redis", "mongodb"], var.db_engine)
      error_message = "The db_engine value must be in pg (PostreSQL), mysql (MySQL), redis (REDIS) , or mongodb (MongoDB)."
    }
}

variable "db_sku" {
    type = string
    description = "The size/sku of the given database cluster (RAM, HDD, CPU, etc.)"
    default = "db-s-1vcpu-1gb"

    validation {
      condition = contains([
                            "db-s-1vcpu-1gb", "db-s-1vcpu-2gb", "db-s-2vcpu-4gb", "db-s-4vcpu-8gb",
                            "db-s-6vcpu-16gb", "db-s-8vcpu-32gb", "db-s-16vcpu-64gb"
                            ], var.db_sku)
      error_message = "The db_engine value must be in pg (PostreSQL), mysql (MySQL), redis (REDIS) , or mongodb (MongoDB)."
    }
}


variable "node_count" {
    type = number
    description = "Amount of nodes getting generated"
    default = 1

    validation {
      condition = var.node_count == 1 || var.node_count == 3
      error_message = "Value can only be 1 or 3."
    }
}


variable "mongo_version" {
    type = string
    description = "Amount of nodes getting generated"
    default = "4"

    validation {
      condition = var.mongo_version == "4"
      error_message = "Value can only be 4 right now since this is what DO supports."
    }
}

variable "env_type" {
    type = string
    description = "Defines environment type: dev, prod, etc"
    default = "prod"
}


locals {
  prod_db_name = "${var.project_name}-${var.city_zone}-${var.env_type}-${var.db_engine}"
  prod_vpc_name = "${var.project_name}-${var.city_zone}-${var.env_type}-vpc"
}


# Variables inherited from terraform cloud (secrets)
variable "do_token" {}
variable "my_ip" {}
variable "mongodb_svc_user" {}