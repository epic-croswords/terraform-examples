# install and configure httpd apache server with custom security groups and keypair logins

- main.tf : contains script that are used to create resouces in sequencial order
- userdata.yml : contains user-data that runs once the resource created ( cloud-init script )

# prerequisite 
- create your own "ssh-keygen" to do login via passwordless authentication
- install & configure aws-cli
- install terrform in ubuntu
  
# how to run

- terraform init //for initalize repo
- terraform fmt //for better & structured view 
- terraform plan //for dry run
- terrform apply //do changes
- terrafrom destroy //to delete infra

# images:

![Untitled](https://github.com/epic-croswords/terraform-examples/assets/138249606/d64df6f1-cf9d-49b8-8b60-88735bc3073b)

![Untitled-1](https://github.com/epic-croswords/terraform-examples/assets/138249606/1a36c5a0-2914-4500-aaff-2aaa1ef29b1e)

![Untitled](https://github.com/epic-croswords/terraform-examples/assets/138249606/b04d520e-c058-48e6-9c9c-a4c1df7f7748)
