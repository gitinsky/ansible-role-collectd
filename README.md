# Usage

Get with

```
git clone https://github.com/gitinsky/ansible-role-collectd.git roles/collectd
```

# Setup

You have to assign your carbon host IP address to a ```carbon_host``` variable, and there’re two ways to define it:

1. Straightforward, just assign the address...
2. Use groups. Set the ```collectd_grafana_group_search_prefix``` variable and... Here’s the example of your inventory:

```
[github-grafana-hosts]
grafana.example.com

[github-collectd-hosts]
test01.example.com
test02.example.com
test03.example.com

[grafana-hosts:children]
test-grafana-hosts

[collectd-hosts:children]
test-collectd-hosts

[githubexample:children]
test-grafana-hosts
test-collectd-hosts

[collectd-hosts:vars]
collectd_grafana_group_search_prefix=github
```

And here’s the sample playbook:

```
---
- hosts: grafana-hosts
  name: Gather facts from grafana-hosts
  tasks:
    - fail: msg=""
      when: false
      tags: debug
      
- hosts: collectd-hosts
  sudo: yes
  roles:
    - role: collectd
```


Here’s how you run this:

```
ansible-playbook playbooks/collectd.yml -l githubexample
```