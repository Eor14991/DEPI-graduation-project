# 🚦 Smart Radar Traffic Monitoring System

## 📘 Project Overview
The **Smart Radar Traffic Monitoring System** is a cloud-native solution designed to simulate radar sensors deployed across a city to monitor and analyze vehicle traffic. The system is built using **Lambda Architecture** on Microsoft Azure, enabling both real-time processing and historical analytics.

The system handles data through two processing layers:

### 🔥 Speed Layer (Hot Path)
- Real-time violation detection
- Live alerting via Power BI Streaming Dataset

### 🧊 Batch Layer (Cold Path)
- Long-term data storage
- Deep historical analysis using Azure Synapse

Each simulated radar generates live data including:
- License Plate
- Speed
- Location
- Seat belt usage
- Phone usage

---

## 🎯 Project Objectives

- Develop a **containerized vehicle data simulator** using Python and Docker deployed on Azure Container Instances (ACI).
- Implement a **scalable ingestion layer** using Azure Event Hubs.
- Build a **stream processing engine** with Azure Stream Analytics.
- Construct a **Modern Data Warehouse** using Azure Synapse Analytics (Spark & SQL Pools).
- Design a **Power BI dashboard** combining real-time streaming and historical analytics.

---

## 👥 Team Members & Roles

| Member Name | Role | Responsibilities |
|-------------|------|------------------|
| **Hala Farouk Mohamed Mutawa** | Team Leader & Lead Data Engineer | Manage architecture design and integration between Hot & Cold paths |
| Marev Wasim | Data Engineer (Ingestion & Simulation) | Build simulator, Dockerization, Event Hubs integration |
| Mohamed Farrag | Data Engineer (Batch Processing) | Build batch pipeline & manage Data Lake |
| Mera Sameh | Data Engineer (Streaming Processing) | Configure Azure Stream Analytics |
| **Yossef Ahmed** | Cloud & DevOps Engineer | Azure setup, Docker, Security |
| David Bahaa | BI Developer & Analyst | Power BI dashboard implementation |

---

## 🧰 Tools & Technologies

| Category | Technologies |
|----------|--------------|
| Data Ingestion | Python (Faker), Docker, ACI, Azure Event Hubs |
| Stream Processing | Azure Stream Analytics |
| Batch Processing | Azure Synapse (Spark Pool - PySpark) |
| Storage | Azure Data Lake Gen2 |
| Data Warehouse | Azure Synapse SQL Pool |
| Visualization | Power BI |
| Container Registry | Azure Container Registry (ACR) |

---

## 📆 Milestones & Deadlines

| Milestone | Key Deliverables | Deadline |
|-----------|------------------|----------|
| M1: Simulation & Ingestion | Docker image, ACI, Event Hubs | Oct 19, 2025 |
| M2: Batch Layer | Synapse Spark, Data Lake | Nov 2, 2025 |
| Exam Period | --- | Nov 7–14, 2025 |
| M3: Speed Layer | Stream Analytics + Power BI Streaming | Nov 23, 2025 |
| M4: Dashboard | SQL DW + Power BI | Dec 3, 2025 |
| Final Submission | Code + Report + Presentation | Dec 5, 2025 |

---

## 📊 Key Performance Indicators (KPIs)

### Architecture Performance
- Ingestion Throughput: High-velocity handling via Event Hubs
- Hot Path Latency: < 3 seconds
- Data Consistency: 100% match between Raw & SQL tables

### Data Processing
- Real-time violation filtering using Azure Stream Analytics
- Data cleaning and transformation using Azure Synapse (Spark & SQL)
- Structured loading into Synapse SQL Pool tables

### Visualization
- Hybrid Power BI dashboard combining streaming and warehouse data

---

## 🗄️ Data Architecture (Lakehouse Design)

### Storage Layers

#### 🥉 Bronze Layer (Raw)
- Raw JSON data in Azure Data Lake Gen2

#### 🥈 Silver Layer (Clean)
- Cleaned & structured Parquet files from Spark

#### 🥇 Gold Layer (Serving)
- Analytics-ready tables in Synapse SQL Pool

---

### Main Tables (Synapse SQL)

| Table Name | Description |
|------------|-------------|
| Dim_Vehicles | Vehicle master data |
| Dim_Radars | Radar metadata |
| Dim_Locations | Geographic location details |
| Dim_Time | Time dimension for analytics |
| Fact_Violations | Traffic violations |
| Fact_Traffic | All traffic events |
| Fact_Alerts | Real-time alert history |


---

## 🧭 System Architecture (Lambda Architecture)

### 1. Ingestion Layer
- Python simulator inside Docker on ACI
- Azure Event Hubs receives streaming data

### 2. Stream Processing Layer (The Split)

#### Path A – Hot Path
- Filter violations in real-time
- Push alerts to Power BI Streaming Dataset

#### Path B – Cold Path
- Store raw data into Azure Data Lake Gen2

---

### 3. Batch Processing & Serving
- Azure Synapse Spark for data cleaning and transformation
- Azure Synapse SQL Pool for warehouse tables

---

### 4. Visualization Layer
- Power BI Streaming Dataset for live violations
- Power BI connected to Synapse SQL Pool for historical analysis
- Unified dashboard combining Hot & Cold insights

---

## ⚙️ Setup & Run Instructions

### Prerequisites
- Azure Subscription
- Docker Desktop
- Power BI Desktop

---

### Deployment

```bash
# Clone Repository
git clone https://github.com/Eor14991/smart-radar-traffic-monitoring.git

# Build Docker Image
docker build -t smart-radar-sim .
