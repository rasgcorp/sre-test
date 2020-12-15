output "instance_target_ids" {
  value = aws_instance.web.*.id
}