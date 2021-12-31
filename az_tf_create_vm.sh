
#---------------------------------------------------

# sudo scutil --set HostName lxphkglpm024.local

azenv(){
    AZ_RESOURCE_GROUP_NAME="rg-${AZ_CLUSTER_GROUP_NAME}-1"
    AZ_RESOURCE_LOCATION="westus2"
    AZ_V_NETWORK_SUBNET_NAME="${AZ_RESOURCE_GROUP_NAME}-subnet"
    AZ_V_NETWORK_IP_PUBLIC_LB_NAME="ip-pub-${AZ_RESOURCE_GROUP_NAME}-lb"
    AZ_V_NETWORK_IP_PUBLIC_LB_IPV4="${AZ_V_NETWORK_IP_PUBLIC_LB_NAME}-IpV4"
    AZ_V_NETWORK_LOAD_BALANCER_NAME=="lb-${AZ_RESOURCE_GROUP_NAME}"
    AZ_V_NETWORK_LOAD_BALANCER_POOL_ADDRESS_BACKEND_NAME=="ip-pool-${AZ_RESOURCE_GROUP_NAME}-frontend"
    AZ_V_NETWORK_LOAD_BALANCER_NIC_NAME="vnet-${AZ_RESOURCE_GROUP_NAME}-nic-lb"
    AZ_VM_AVAILABILITY_SET_NAME="avset-${AZ_RESOURCE_GROUP_NAME}"
    AZ_VIRTUAL_MACHINE_NAME="vm-${AZ_RESOURCE_GROUP_NAME}"
    AZ_DISK_MANAGED_OS_NAME="osdsk-${AZ_VM_NAME_ROOT}"
    AZ_DISK_MANAGED_DATA_NAME_NEW="osdsk-${AZ_VM_NAME_ROOT}-new"
    AZ_DISK_MANAGED_DATA_NAME_EXISTING="osdsk-${AZ_VM_NAME_ROOT}-existing"
}

azconfigmaintf(){
sed -e "s/AZ_RESOURCE_GROUP_NAME/rg-${AZ_CLUSTER_GROUP_NAME}-1/g" \
         -e "s/AZ_RESOURCE_LOCATION/westus2/g" \
         -e "s/AZ_V_NETWORK_NAME/vnet-${AZ_RESOURCE_GROUP_NAME}/g" \
         -e "s/AZ_V_NETWORK_SUBNET_NAME/vnet-${AZ_RESOURCE_GROUP_NAME}-subnet/g" \
         -e "s/AZ_V_NETWORK_IP_PUBLIC_LB_NAME/ip-pub-${AZ_RESOURCE_GROUP_NAME}-lb/g" \
         -e "s/AZ_V_NETWORK_IP_PUBLIC_LB_IPV4/${AZ_V_NETWORK_IP_PUBLIC_LB_NAME}-IpV4/g" \
         -e "s/AZ_V_NETWORK_LOAD_BALANCER_NAME/lb-${AZ_RESOURCE_GROUP_NAME}/g" \
         -e "s/AZ_V_NETWORK_LOAD_BALANCER_POOL_ADDRESS_BACKEND_NAME/ip-pool-${AZ_RESOURCE_GROUP_NAME}-frontend/g" \
         -e "s/AZ_V_NETWORK_LOAD_BALANCER_NIC_NAME/vnet-${AZ_RESOURCE_GROUP_NAME}-nic-lb/g" \
         -e "s/AZ_VM_AVAILABILITY_SET_NAME/avset-${AZ_RESOURCE_GROUP_NAME}/g" \
         -e "s/AZ_VIRTUAL_MACHINE_NAME/vm-${AZ_RESOURCE_GROUP_NAME}/g" \
         -e "s/AZ_DISK_MANAGED_OS_NAME/osdsk-${AZ_VM_NAME_ROOT}/g" \
         -e "s/AZ_DISK_MANAGED_DATA_NAME_NEW/osdsk-${AZ_VM_NAME_ROOT}-new/g" \
         -e "s/AZ_DISK_MANAGED_DATA_NAME_EXISTING/osdsk-${AZ_VM_NAME_ROOT}-existing/g" \
main.tftmpl | tee main.tf
}

azureinstall(){
    brew update && brew install azure-cli
    az login
}

terraforminstall(){
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    terraform init
}

gitreclone(){
    cd ../
    rm -fr terraform_azure_cluster
    git clone https://github.com/karlring-devops/terraform_azure_cluster.git
    cd terraform_azure_cluster
}

tfgo(){
    AZ_CLUSTER_GROUP_NAME=azclsrke2
    azenv
    azconfigmaintf
    terraform init
    terraform plan -out main.tfplan
    terraform apply "main.tfplan1"
}


# function azenv(){
#     __MSG_BANNER__ "${1}"
#     # AZ_CLUSTER_GROUP_NAME=azclsrke2
#     # AZ_RESOURCE_GROUP_NAME="rg-${AZ_CLUSTER_GROUP_NAME}-1"
#     # AZ_RESOURCE_LOCATION="westus2"
#     # AZ_PUBLIC_IP="ip-pub-${AZ_RESOURCE_GROUP_NAME}-lb"
#     AZ_PUBLIC_IP_VM_NAME_1="ip-pub-${AZ_RESOURCE_GROUP_NAME}-vm-1"
#     AZ_PUBLIC_IP_VM_NAME_2="ip-pub-${AZ_RESOURCE_GROUP_NAME}-vm-2"
#     AZ_PUBLIC_IP_VM_NAME_3="ip-pub-${AZ_RESOURCE_GROUP_NAME}-vm-3"
#     # AZ_LOADBALANCER="lb-${AZ_RESOURCE_GROUP_NAME}"
#     AZ_IP_POOL_FRONTEND="ip-pool-${AZ_RESOURCE_GROUP_NAME}-frontend"
#     AZ_IP_POOL_BACKEND="ip-pool-${AZ_RESOURCE_GROUP_NAME}-backend"
#     AZ_VM_NET_PRIMARY="vnet-${AZ_RESOURCE_GROUP_NAME}"
#     AZ_LOADBALANCER_PROBE="${AZ_RESOURCE_GROUP_NAME}-probe-health"
#     AZ_LOADBALANCER_RULE="${AZ_RESOURCE_GROUP_NAME}-rule"
#     # AZ_VM_NET_SUBNET="${AZ_RESOURCE_GROUP_NAME}-subnet"
#     AZ_NET_SEC_GROUP="nsg-${AZ_RESOURCE_GROUP_NAME}"
#     AZ_NET_SEC_GROUP_RULE="${AZ_NET_SEC_GROUP}-rule"
#     # AZ_VM_AVAIL_SET="avset-${AZ_RESOURCE_GROUP_NAME}"
#     AZ_VM_NAME_ROOT="vm-${AZ_RESOURCE_GROUP_NAME}"
#     AZ_VM_NET_PRIMARY_NIC="${AZ_VM_NET_PRIMARY}-nic"
#     AZ_VM_NET_PRIMARY_NIC_1="${AZ_VM_NET_PRIMARY_NIC}-1"
#     AZ_VM_NET_PRIMARY_NIC_2="${AZ_VM_NET_PRIMARY_NIC}-2"
#     AZ_VM_NET_PRIMARY_NIC_3="${AZ_VM_NET_PRIMARY_NIC}-3"
#     AZ_VM_NAME_ROOT_1="${AZ_VM_NAME_ROOT}-1"
#     AZ_VM_NAME_ROOT_2="${AZ_VM_NAME_ROOT}-2"
#     AZ_VM_NAME_ROOT_3="${AZ_VM_NAME_ROOT}-3"
#     AZ_OSDISK="osdsk-${AZ_VM_NAME_ROOT}"
#     AZ_OSDISK_1="${AZ_OSDISK}-1"
#     AZ_OSDISK_2="${AZ_OSDISK}-2"
#     AZ_OSDISK_3="${AZ_OSDISK}-3"
#     # AZ_RESOURCE_GROUP_STORAGE_ACCOUNT="storageAccount-${AZ_RESOURCE_GROUP_NAME}"
#     # getenv 'AZ_'
#     set | grep AZ_ | grep '=' | egrep -v '\(\)|;|\$'
# }

# function azconfigmaintf(){
#     sed -e "s/AZ_RESOURCE_GROUP_NAME/${AZ_RESOURCE_GROUP_NAME}/g" \
#          -e "s/AZ_VM_NET_SUBNET/${AZ_VM_NET_SUBNET}/g" \
#          -e "s/AZ_PUBLIC_IP_VM_NAME_1/${AZ_PUBLIC_IP_VM_NAME_1}/g" \
#          -e "s/AZ_PUBLIC_IP_VM_NAME_2/${AZ_PUBLIC_IP_VM_NAME_2}/g" \
#          -e "s/AZ_PUBLIC_IP_VM_NAME_3/${AZ_PUBLIC_IP_VM_NAME_3}/g" \
#          -e "s/AZ_NET_SEC_GROUP_RULE/${AZ_NET_SEC_GROUP_RULE}/g" \
#          -e "s/AZ_NET_SEC_GROUP/${AZ_NET_SEC_GROUP}/g" \
#          -e "s/AZ_VM_NET_PRIMARY_NIC_1/${AZ_VM_NET_PRIMARY_NIC}-1/g" \
#          -e "s/AZ_VM_NET_PRIMARY_NIC_2/${AZ_VM_NET_PRIMARY_NIC}-2/g" \
#          -e "s/AZ_VM_NET_PRIMARY_NIC_3/${AZ_VM_NET_PRIMARY_NIC}-3/g" \
#          -e "s/AZ_VM_NET_PRIMARY/${AZ_VM_NET_PRIMARY}/g" \
#          -e "s/AZ_VM_NET_PRIMARY_NIC/${AZ_VM_NET_PRIMARY_NIC}/g" \
#          -e "s/AZ_VM_NET_PRIMARY_NIC_NAME/${AZ_VM_NET_PRIMARY_NIC_NAME}/g" \
#          -e "s/AZ_VM_NAME_ROOT_1/${AZ_VM_NAME_ROOT_1}/g" \
#          -e "s/AZ_VM_NAME_ROOT_2/${AZ_VM_NAME_ROOT_2}/g" \
#          -e "s/AZ_VM_NAME_ROOT_3/${AZ_VM_NAME_ROOT_3}/g" \
#          -e "s/AZ_RESOURCE_LOCATION/${AZ_RESOURCE_LOCATION}/g" \
#          -e "s/AZ_OSDISK_1/${AZ_OSDISK_1}/g" \
#          -e "s/AZ_OSDISK_2/${AZ_OSDISK_2}/g" \
#          -e "s/AZ_OSDISK_3/${AZ_OSDISK_3}/g" \
#          -e "s/AZ_STORAGE_ACCOUNT_NAME/${AZ_STORAGE_ACCOUNT_NAME}/g" \
#      main.tf.tmpl4 | tee main.tf
# }


# terraform plan -out main.tfplan
# terraform apply main.tfplan

# azurerm_network_interface_security_group_association
# AZ_NET_IF_SEC_GROUP_ASSOC

# publicIPAddresses/ip-pub-rg-azclsrke2-1-vm
# terraform output -raw publicIPAddresses

# function az_tf_get_TLSKey(){
#     terraform output -raw tls_private_key > ${AZ_VM_NAME_ROOT_1}
# }

# cat <<EOF| sudo tee -a /etc/hosts
# 20.114.32.82 vm-rg-azclsrke2-1-1 
# EOF

# ssh azureuser@vm-rg-azclsrke2-1-1 -i vm-rg-azclsrke2-1-1  date

