# output "ec2_public_ip" {
#     value = aws_instance.myec2[*].public_ip
# }

# output "ec2_private_ip" {
#     value = aws_instance.myec2[*].private_ip
# }

# output "ec2_instance_dns_id" {
#     value = aws_instance.myec2[*].public_dns
# }

output "ec2_public_ip" {
    value = [
        for k in aws_instance.myec2 : k.public_ip
    ]
}