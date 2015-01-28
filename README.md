# REQUIREMENTS

 * vagrant
 * anisible

# Development Setup
```
  vagrant up
  ssh-add ~/.vagrant.d/insecure_private_key
  ansible-playbook site.yml
```

# Development
```
  vagrant ssh
  cd /vagrant
  bundle install --path vendor/bundle
  bin/shotgun -o 0.0.0.0 # open browser and visit http://localhost:9393 or through ngnix http://localhost:8181
```

# Running Tests
```
 bin/bacon spec/*
```

# Development Deploy
```
  vagrant ssh
  cd /vagrant
  bin/cap development deploy
  bin/shotgun -o 0.0.0.0 # open browser and visit http://localhost:9393 or through ngnix http://localhost:8181
```
