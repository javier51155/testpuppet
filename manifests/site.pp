node "proxy" {
  notify {"This is puppet running in server 'proxy'":}
  contain ::netcentric::reverse_proxy
  contain ::netcentric::forward_proxy
}

node "client1" {
  notify {"This is puppet running in server 'client1'":}
   contain ::nginx
}

node "client2" {
  notify {"This is puppet running in server 'client2'":}
   contain ::nginx
}

node "default" {}
