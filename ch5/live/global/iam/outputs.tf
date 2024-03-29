#output "neo_arn" {
#  value       = aws_iam_user.example[0].arn
#  description = "The ARN for user Neo"
#}

#output "all_arns" {
#  value       = aws_iam_user.example[*].arn
#  description = "The ARNs for all users"
#}

output "all_users" {
  value = aws_iam_user.example
}

output "all_arns" {
  value = values(aws_iam_user.example)[*].arn
}

output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
  value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }
}

output "for_directive" {
  value = <<EOF
    %{for name in var.user_names}
      ${name}
    %{endfor}
  EOF
}

output "for_directive_strip_marker" {
  value = <<EOF
    %{for name in var.user_names~}
      ${name}
    %{endfor~}
  EOF
}
