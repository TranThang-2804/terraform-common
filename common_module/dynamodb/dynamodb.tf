resource "aws_dynamodb_table" "this" {
  name             = "${local.prefix_name}-table"
  billing_mode     = "PROVISIONED"
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  hash_key         = var.hash_key
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  dynamic "attribute" {
    for_each = var.table_attribute

    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  ttl {
    attribute_name = var.ttl_attribute_name
    enabled        = var.ttl_enabled
  }

  tags = var.tags
}