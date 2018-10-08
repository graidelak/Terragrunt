output "url" {
   value = "http://${aws_instance.webserver.public_ip}"
}

output "webserver_dns_name"{
  value = "${aws_instances.webserver.dns_name}"
}
