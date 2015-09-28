# REQUIREMENTS

 * vagrant (at least 1.7.2)
 * anisible (at least 1.9.0)
 
# Development Setup with Vagrant
```
  vagrant up
  vagrant ssh
  cd project
  ./run.sh
```

# Running Tests

[![Build Status](https://semaphoreci.com/api/v1/projects/8d7a296a-6d4c-4c09-8d7a-07a4ad73b14a/548903/badge.svg)](https://semaphoreci.com/my-grocery-price-book/api-my-grocery-price-book-co-za)

```
  RACK_ENV=test bundle exec rake db:create
  bundle exec rake # runs specs and mutant specs
```

# Deployment
```
  vagrant ssh
  cd /vagrant
  bundle exec cap za deploy  # deploy south african servers
  bundle exec cap vagrant deploy # deploy to vagrant
```

# Conventions

* Each api endpoint calls only one one command or query class
* We aim for 100 percent coverage
* We aim for 100 mutant coverage for non IO classes
* We aim to please rubocop  (`rake rubocop:auto_correct` helps with this)
* Integration spec files are named after the end point they hit
* Integration specs are black box specs

# ZA Provisioning and Deployment

provisioning: Your key needs to be added to the servers and you need the vault_pass.txt

```
  cd ansible
  ansible-playbook -vv site.yml -i hosts/za --vault-password-file vault_pass.txt
```
