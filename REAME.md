# Infraestructura Inmutable Usando Packer, Ansible, y Terraform

## Ir a la carpeta de terraform y comentar todo excepto module "networking":
    
```bash
    terraform init    
    terraform validate    
    terraform apply
```

## Ejecutar Packer

Ingresar la subnet id creada terraform in wordpress.json

```bash
    packer build wordpress.json
```

## Ir a la carpeta de terraform y descomentar todo:

Editar aws_instance ami con el valor nuevo generado en el paso anterior
    
```bash
    terraform init    
    terraform validate    
    terraform apply
```