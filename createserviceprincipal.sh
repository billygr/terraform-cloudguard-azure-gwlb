#!/bin/sh
echo "Authenticating to Azure using a Service Principal and a Client Secret"
echo "run it only once in shell.azure.com it creates a appName=ServicePrincipalDemo1"
echo "and display the password which you need to replace in your azure-client-secret"

subscriptioniD=`az account show --query id --output tsv`
appName="ServicePrincipalDemo1"
spPassword="ServicePrincipalDemo1"

createprincipal()
{
  echo "Creating principal"
 
  az ad app create \
  --display-name $appName

  az ad sp create-for-rbac \
  --name "$appName" --role contributor \
  --scope /subscriptions/$subscriptioniD | grep "password"

  appId=$(az ad app list --display-name $appName --query [].appId -o tsv)
  echo "azure-client-id     =" \"$appId\"
  echo "azure-client-secret =" \"----\"
  echo "azure-subscription  =" \"$subscriptioniD\"
  echo "azure-tenant        = "`az account show --query tenantId`
}

while true; do
    read -p "Do you wish to create a new Service Principal ? " yn
    case $yn in
        [Yy]* ) createprincipal; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done 

