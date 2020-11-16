class netcentric::forward_proxy {
    
  nginx::resource::server { 'proxy.domain.com':
      listen_port => 8080,
      resolver    => ['8.8.8.8'],
      proxy       => 'http://$http_host$uri$is_args$args',
      format_log  => 'customised',
  }
    
  class {'nginx':
    log_format => {
      'customised'  => '[$time_local] $scheme - $remote_addr - $request_time - "$request" - $status',
    }
  }
}
