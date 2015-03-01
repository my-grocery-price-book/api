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
  bundle exec cap production deploy  # can also do 'bundle exec cap development deploy' to deploy to vagrant
```

# Conventions

* Each api endpoint calls only one one command or query class
* We aim for 100 percent coverage
* We aim for 100 mutant coverage for non IO classes
* We aim to please rubocop  (`rake rubocop:auto_correct` helps with this)
* Integration spec files are named after the end point they hit
* Integration specs are black box specs
