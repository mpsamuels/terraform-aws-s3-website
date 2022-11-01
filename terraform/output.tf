output "aws_route53_zone" {
  description = "Friendly FQDN within Route 53 hosted zone to invoke API Gateway "
  value       = aws_route53_zone.r53_zone.id
}

output "aws_acm_certificate" {
  value = aws_acm_certificate.ssl_certificate.arn
}