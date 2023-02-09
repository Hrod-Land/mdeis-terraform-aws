# terrafor-aws
Stepts to follow:
1. git clone https://github.com/Hrod-Land/mdeis-terraform-aws.git
2. cd .\mdeis-terraform-aws\
3. Establecer la region (region  = "<region>") en el archivo main.tf de acuerdo a la region en la que se quiera trabajar, ejemplo: "eu-central-1"
4. Establecer el vpc_id en el main.tf de acuerdo a la region que se ha especificado >> Guardar los cambios
5. terraform init
6. terraform plan
7. terraform apply
8. access to "http://<instance_public_ip>:80
