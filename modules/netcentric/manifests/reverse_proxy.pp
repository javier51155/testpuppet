class netcentric::reverse_proxy {
    
  nginx::resource::server { 'domain.com':
        ssl      => true,
        ssl_port => 443,
        ssl_cert => '/etc/pki/tls/certs/cert.pem',
        ssl_key  => '/etc/pki/tls/private/key.pem',
        proxy    =>  'http://10.10.10.10'      
  }

  nginx::resource::location { 'resource2':
        ssl       => true,
        server    => 'domain.com',
        location  => '~ ^/resource2',
        proxy     => 'http://20.20.20.20'         
  }

  file { 'domain.com certificate':
        path         => '/etc/pki/tls/certs/cert.pem',
        ensure       => present,
        owner        =>  'root',
        group        =>  'root',  
        mode         =>  '644',
        source       => 'puppet:///modules/netcentric/cert.pem',
  }

  file { 'domain.com key':
        path         => '/etc/pki/tls/private/key.pem',
        ensure       => present,
        owner        =>  'root',
        group        =>  'root',  
        mode         =>  '644',
        source       =>  'puppet:///modules/netcentric/key.pem',
  }
}
