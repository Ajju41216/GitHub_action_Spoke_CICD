


variable "spoke_rgs" {

  type = map(object({

    name = string

    location = string
        

  })) 
}