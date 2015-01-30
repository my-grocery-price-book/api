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

[![wercker status](https://app.wercker.com/status/1d3464fefb6fd3a9bf559e302e47ed14/m "wercker status")](https://app.wercker.com/project/bykey/1d3464fefb6fd3a9bf559e302e47ed14)

```
  bundle exec rake
```

# Deployment
```
  vagrant ssh
  cd /vagrant
  bin/cap production deploy  # can also do bin/cap development deploy
```
