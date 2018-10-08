output "url" {
   value = "http://${aws_instance.webserver.public_ip}"
}

