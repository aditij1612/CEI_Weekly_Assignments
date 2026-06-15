# Azure Data Factory End-to-End Data Pipeline

## Overview
This project demonstrates an end-to-end data pipeline using **Azure Blob Storage** and **Azure Data Factory (ADF)**. A CSV file stored in a source Blob container is validated using the **Get Metadata** activity and copied to a destination container using the **Copy Data** activity.

## Technologies Used
- Microsoft Azure
- Azure Blob Storage
- Azure Data Factory
- CSV Files

## Pipeline Flow

Source CSV File → Get Metadata → Copy Data → Destination Blob Container

## Resources Used
- Resource Group
- Storage Account
- Source and Destination Blob Containers
- Azure Data Factory
- Linked Service
- Source and Destination Datasets
- Get Metadata Activity
- Copy Data Activity

## Execution Steps
1. Uploaded the CSV file to the source container.
2. Created Linked Service and datasets in ADF.
3. Built a pipeline with Get Metadata and Copy Data activities.
4. Published and executed the pipeline.
5. Monitored the execution and verified the copied file in the destination container.

## Result
The pipeline executed successfully, validated the source file metadata, and copied the CSV file from the source Blob container to the destination Blob container.

## Author
**Name:**Aditi Jain  
