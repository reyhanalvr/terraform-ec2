output "instance_ids" {
  value = [for idx in range(0, length(aws_instance.ubuntu)) : aws_instance.ubuntu[idx].id]  
}


output "instance_public_ips" {
  value = [for idx in range(0, length(aws_instance.ubuntu)) : aws_instance.ubuntu[idx].public_ip] 
}

