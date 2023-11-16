locals {
  lambdas = merge([for f in fileset(path.module, "./resources/${terraform.workspace}/lambda/*.yaml") : yamldecode(file("${path.module}/${f}"))]...)
  buckets = merge([for f in fileset(path.module, "./resources/${terraform.workspace}/s3/*.yaml") : yamldecode(file("${path.module}/${f}"))]...)
}