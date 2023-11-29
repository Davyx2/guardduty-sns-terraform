variable "name-sns" {
  default = "sns-guardduty"
}
variable "fifo" {
  default = false
  type = bool
}

variable "deduplication" {
  type    = bool
  default = false
}
variable "target_id" {
  type    = string
  default = "SendToSNS"
}

variable "email-notification" {
  default = ""
}
#Cloudwatch Variables
variable "event_name" {
  type    = string
  default = "CW-Guardduty-event-rule"
}

variable "description" {
  type    = string
  default = "Event Rule to capture Guard duty findings from a severity > 6"
}

variable "enabled" {
  type    = bool
  default = true
}