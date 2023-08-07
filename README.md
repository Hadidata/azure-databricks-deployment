# Azure Databricks Simple Deployment #

This repository contains code to create an Azure Databricks workspace with supporting infrastructure to allow the creation of ELT workflows. For a more detalied breakdown of how to code works and its implentation: [link]

The following are created in addition to the Databricks workspace. 
- A Databricks cluster autenticated to a storage account
- App registration to allow the storage account and the workspace to communicate securly 
- A keyvault to store the app credentials
- A storage account with the medallion architecture (represented with different containers)

The repository also contains a databricks notebook to build an demo data pipeline 


