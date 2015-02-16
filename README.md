# REQUIREMENTS

 * vagrant
 * anisible
 
# Development Setup with Vagrant
```
  vagrant up
  ssh-add ~/.vagrant.d/insecure_private_key
  cd ansible && ansible-playbook site.yml
  vagrant ssh
  cd /vagrant
  bundle install --path vendor/bundle
  bundle exec shotgun -o 0.0.0.0 -s webrick # open browser and visit http://localhost:9191 or through ngnix http://localhost:8181
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
  bundle exec cap production deploy  # can also do 'bin/cap development deploy' to deploy to vagrant
```
