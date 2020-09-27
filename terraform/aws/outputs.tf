output "linux_node_ip" {
  value = "${aws_instance.linux-node.public_ip}"
}

output "consul_ui" {
  value = "http://${aws_instance.linux-node.public_ip}:8500/ui"
}

output "vault_ui" {
  value = "http://${aws_instance.linux-node.public_ip}:8200/ui"
}
