# terrafor-aws
Stepts to follow:
1.  git clone https://github.com/Hrod-Land/mdeis-terraform-aws.git
2.  cd .\mdeis-terraform-aws\
3.  Modificar en el archivo main.tf:
    3.1. Establecer la region (region  = "<region>") en el archivo main.tf de acuerdo a la region en la que se quiera trabajar, ejemplo: "eu-central-1"
    3.2. Establecer el vpc_id en el main.tf de acuerdo a la region que se ha especificado >> Guardar los cambios
4.  terraform init
5.  terraform plan
6.  terraform apply
7.  access to "http://<instance_public_ip>:80
