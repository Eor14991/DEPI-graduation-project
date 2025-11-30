# 🚦 Smart Radar Traffic Monitoring System

## 📘 Project Overview
The **Smart Radar Traffic Monitoring System** simulates radar sensors deployed across a city to monitor and analyze vehicle traffic. Each radar generates live data such as:
- Vehicle license plate  
- Speed  
- Color  
- Location  
- Seat belt usage  
- Phone usage  

The project leverages **data engineering tools** and **cloud technologies** to process information in both **batch** and **streaming** modes — enabling **real-time insights** and **historical analysis**.

---

## 🎯 Objectives
1. Develop a realistic vehicle data simulator using **Python** and **Apache Kafka** for real-time data ingestion.  
2. Build a **batch processing pipeline** with **Apache Spark (PySpark)** and **Azure Data Lake** for historical analysis.  
3. Implement a **streaming pipeline** for real-time violation detection and alerts.  
4. Create an **interactive Power BI dashboard** for visualization and decision-making.  
5. Deliver **complete system documentation** detailing architecture, data flow, and implementation.

---

## 👥 Team Members & Roles

| Member Name | Role | Responsibilities |
|--------------|------|------------------|
| **Hala Farouk** | Team Leader & Lead Data Engineer | Manage project progress, oversee pipeline design, ensure integration between modules |
| **Marev Wasim** | Data Engineer (Ingestion & Simulation) | Milestone 1: Build and run data simulation script, connect to Kafka |
| **Mohamed Farrag** | Data Engineer (Batch Processing) | Milestone 2: Build batch pipeline using PySpark and manage Data Lake |
| **Mera Sameh** | Data Engineer (Streaming Processing) | Milestone 3: Build streaming pipeline and develop instant alert system |
| **Yossef Ahmed** | Cloud & DevOps Engineer | Set up and manage Azure resources, Docker setup, database management |
| **David Bahaa** | BI Developer & Data Analyst | Milestone 4: Power BI dashboard development and data analysis |

**Team Leader:** *Hala Farouk Mohamed Mutawa*

---

## 🧰 Tools & Technologies

| Category | Technologies |
|-----------|---------------|
| **Data Ingestion & Streaming** | Python, Apache Kafka |
| **Data Processing** | Apache Spark (PySpark) |
| **Data Storage** | Azure Blob Storage (Data Lake - Parquet), PostgreSQL (Data Warehouse) |
| **Orchestration** | Azure Data Factory |
| **Visualization & Dashboard** | Power BI |
| **Containerization** | Docker |

---

## 📆 Milestones & Deadlines

| Milestone | Key Deliverables | Deadline |
|------------|------------------|-----------|
| **M1: Data Simulation & Ingestion** | Python generator script, Kafka topic setup, Dockerfile | **Oct 19, 2025** |
| **M2: Batch ELT Pipeline** | PySpark script, Data Lake (Parquet), SQL DWH schema | **Nov 2, 2025** |
| **Exam Period (No Deliverables)** | — | **Nov 7–14, 2025** |
| **M3: Streaming Pipeline & Alerts** | Real-time processing code, alert system integration (Slack/Email) | **Nov 23, 2025** |
| **M4: Dashboard & Final Report** | Power BI dashboard, final report with diagrams | **Dec 3, 2025** |
| **Final Submission** | All code, documentation, presentation slides | **Dec 5, 2025** |

---

## 📊 Key Performance Indicators (KPIs)

### 1. Data Processing & Pipeline Performance
- **Data Quality:** 100% of records with invalid plate numbers or negative speed are cleaned or filtered.  
- **Batch Job Efficiency:** 1M records processed in ≤15 minutes.  
- **Stream Latency:** <5 seconds from data generation to alert trigger.

### 2. SQL & Data Warehouse Integration
- **Query Accuracy:** Dashboard aggregation queries verified 100%.  
- **Query Performance:** Average query time <2 seconds.

### 3. Visualization
- **Dashboard Load Time:** <5 seconds.  
- **Data Representation:** 100% of KPIs and visuals (violation trends, heatmaps, live map) accurately displayed.

### 4. Presentation & Documentation
- **Report Completeness:** 100% of sections, including system architecture and data flow.  
- **Stakeholder Feedback:** ≥4/5 clarity and satisfaction from evaluators.

---

## 🧑‍💼 Stakeholder Analysis

| Stakeholder | Role | Interest / Expectation | Impact | Communication |
|--------------|------|------------------------|---------|----------------|
| **DEPI / Ministry Evaluators** | Project Reviewers | Complete, functional documentation and code | High | Milestone-based |
| **Project Team Members** | Developers | Clear responsibilities and working pipelines | High | Weekly sync |
| **End Users (Traffic Authorities)** | Potential Users | Reliable insights for traffic violations | Medium | Project demonstration |

---

## 🗄️ Database Design

### Schema Overview
The system uses two main storage layers:

1. **Azure Data Lake (Raw + Processed Data)**  
   Stores Parquet files from batch and streaming pipelines.  

2. **PostgreSQL (Data Warehouse)**  
   Optimized for reporting and Power BI queries.  

### Main Tables

| Table | Description | Key Fields |
|--------|--------------|------------|
| **vehicles** | Stores all detected vehicle data | plate_number, color, speed, location, timestamp |
| **violations** | Logs detected violations | violation_id, plate_number, type, timestamp, location |
| **alerts** | Contains real-time alerts triggered from the stream | alert_id, message, severity, sent_time |

**Relationships:**
- One vehicle → many violations  
- One violation → may trigger one alert

---

## 🧭 System Architecture Summary

### Workflow
1. **Data Generation:** Python simulator produces synthetic radar data.  
2. **Ingestion:** Data flows into Apache Kafka topics in real time.  
3. **Batch Processing:** PySpark jobs process data stored in Azure Data Lake.  
4. **Streaming Processing:** Spark Streaming consumes Kafka data to detect violations and send alerts.  
5. **Storage:** Cleaned and aggregated data is stored in PostgreSQL.  
6. **Visualization:** Power BI connects to PostgreSQL for dashboards and analytics.

---

## 🧠 UI/UX Design Justification
This project focuses primarily on **backend data engineering**, **cloud pipelines**, and **analytics**.  
The **Power BI dashboard** serves as the main user-facing visualization tool — intuitive, interactive, and capable of displaying live and historical traffic data.

> No dedicated UI/UX module was implemented beyond Power BI, as visualization requirements were fully met through dashboard design.

---

## ⚙️ Setup & Run Instructions

### 1. Clone Repository
```bash
git clone https://github.com/your-username/smart-radar-traffic-monitoring.git
cd smart-radar-traffic-monitoring
