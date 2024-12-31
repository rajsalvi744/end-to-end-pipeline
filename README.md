# Data Engineering Pipeline with Open-Source Tools  

A fully automated, scalable, and containerized data engineering pipeline built using open-source tools. This project demonstrates end-to-end data integration, transformation, governance, and visualization with seamless deployment using Docker.  

## 📓 System Architecture
![system architecture.jpg](system%20architecture.jpg)

Labels Explanations:  
1. Moving sales data from on premise to object storage which is orchestrated on airflow.
2. Moving raw data from bronze layer in object storage to Postgres Datawarehouse usind Airbyte.
3. Data Transformation is done on raw data using dbt.
4. Transformed Data is moved from data warehouse to object storage using airbyte where staging data is stored in the silver layer whereas data marts are stored in gold layer.
5. Visualtions are made using Metabase by using the data marts in gold layer.

## 🛠️ Technologies Used  
- **Airbyte**: For extracting and integrating data from various sources.  
- **MinIO S3**: As an object storage solution for staging raw data.  
- **PostgreSQL**: For serving as the central data warehouse.  
- **dbt**: To transform raw data into analytical models.  
- **OpenMetadata**: To enforce data governance, quality, and lineage. 
- **Metabase**: For creating interactive visualizations and dashboards.  
- **Docker**: To containerize the pipeline for portability and scalability.  

## 📚 Features  
- **Data Integration with Airbyte**:  
  - Seamlessly extracted data from multiple sources and staged it in MinIO S3 for further processing.  

- **Centralized Data Warehouse**:  
  - Moved raw data from MinIO S3 into PostgreSQL, providing a structured environment for analysis.  

- **Data Transformation with dbt**:  
  - Used dbt to clean, transform, and model the raw data into analytics-ready datasets.  

- **Data Governance and Quality**:  
  - Implemented OpenMetadata to ensure end-to-end data governance, maintain lineage, and monitor data quality.  

- **Interactive Dashboards**:  
  - Built dynamic visualizations and insights using Metabase, directly connected to the transformed data models.  

- **Containerized Deployment**:  
  - The entire pipeline was containerized with Docker, ensuring portability, scalability, and ease of deployment across environments.  

## 🚀 Highlights  
This project illustrates the power of open-source tools in building an efficient and scalable data engineering pipeline. It covers data ingestion, transformation, governance, and visualization in a highly modular and reproducible architecture.  


## 🔧 How to Run  
1. **Clone the Repository**:  
   ```bash  
   git clone https://github.com/your-username/data-engineering-pipeline.git  
   cd data-engineering-pipeline  
2. Set Up Docker: Ensure Docker is installed on your system. Use the following command to start all services:
   ```bash
   docker-compose up  
3. Set up airbyte using airbyte command-line tool 'abctl'. Configure Airbyte Sources: Log in to the Airbyte dashboard at http://localhost:8000. Set up data sources and destinations as per your requirements.
4. Run dbt Models: Execute dbt commands to transform raw data into analytical models:
   ```bash
   dbt run  
5. Visualize with Metabase: Access Metabase at http://localhost:3000 to create interactive dashboards based on the transformed data.



