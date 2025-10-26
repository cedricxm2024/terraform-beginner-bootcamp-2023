variable "user_uuid" {
  description = "The UUID for the user."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "The user_uuid must be a valid UUID (for example: 123e4567-e89b-12d3-a456-426614174000)."
  }
}
