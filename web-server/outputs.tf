output "url" {
   value = "http://${aws_instance.webserver.public_ip}"
}

output "webserver_name" {
  value = "${aws_instances.webserver.name}"
}

output "webserver_dns"{
  value = "${aws_instances.webserver.dns_name}"
}
