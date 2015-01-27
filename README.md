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
```
