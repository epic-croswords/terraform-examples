# install and configure httpd apache server with custom security groups and keypair logins

- main.tf : contains script that are used to create resouces in sequencial order
- userdata.yml : contains user-data that runs once the resource created ( cloud-init script )

# prerequisite 
- install & configure aws-cli
- install terrform in ubuntu
  
# how to run

- terraform init //for initalize repo
- terraform plan //for dry run
- terrform apply //do changes
- terrafrom destroy //to delete infra
