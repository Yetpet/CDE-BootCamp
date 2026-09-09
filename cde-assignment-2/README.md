# CDE Assignment 2 – Linux and Git Project

## Overview

This project is part of the **CoreDataEngineers (CDE) Data Engineering Bootcamp** and demonstrates the use of Linux, Bash scripting, Cron, and Git for basic data engineering automation.

The project consists of three main tasks:

1. Building a Bash-based ETL pipeline.
2. Scheduling the ETL pipeline using Cron.
3. Creating a Bash script for moving CSV and JSON files.

---

## Project Structure

```text
cde-assignment-2/
│
├── etl.sh
├── move_csv_json.sh
├── README.md
│
├── raw/
├── Transformed/
├── Gold/
└── json_and_CSV/
```

### Files and Directories

* **`etl.sh`** – Bash ETL pipeline for extracting, transforming, and loading the dataset.
* **`move_csv_json.sh`** – Bash script for moving CSV and JSON files between directories.
* **`raw/`** – Stores the extracted source data.
* **`Transformed/`** – Stores the transformed dataset.
* **`Gold/`** – Stores the final output of the ETL process.
* **`json_and_CSV/`** – Destination directory for CSV and JSON files.
* **`README.md`** – Project documentation.

---

## Task 1: Bash ETL Pipeline

The ETL pipeline downloads the **Annual Enterprise Survey 2023 Financial Year Provisional** dataset from Statistics New Zealand.

The pipeline performs three stages:

### Extract

The dataset is downloaded using `curl` and stored in the `raw` directory. The source URL is managed through an environment variable.

### Transform

The raw CSV is processed using `awk`. The transformation:

* Renames `Variable_code` to `variable_code`.
* Retains only the required columns:

  * `year`
  * `Value`
  * `Units`
  * `variable_code`
* Handles quoted CSV fields containing commas.

The transformed file is saved as:

```text
Transformed/2023_year_finance.csv
```

### Load

The transformed dataset is copied into the `Gold` directory:

```text
Gold/2023_year_finance.csv
```

The script provides status messages and confirms the successful completion of each stage.

---

## Task 2: Cron Scheduling

The ETL pipeline is scheduled to run automatically **every day at 12:00 AM** using Cron.

The Cron job also redirects the pipeline output and errors to an `etl.log` file for monitoring and troubleshooting.

This demonstrates how a Bash ETL process can be automated without manual execution.

---

## Task 3: CSV and JSON File Movement

The `move_csv_json.sh` script automates the movement of CSV and JSON files from a specified source directory into the `json_and_CSV` directory.

The script:

* Accepts a source directory as an argument.
* Supports multiple CSV files.
* Supports multiple JSON files.
* Creates the destination directory if it does not exist.
* Counts the number of CSV and JSON files moved.

Example:

```bash
./move_csv_json.sh test_files
```

---

## How to Run

First, Make the scripts executable:

```bash
chmod +x etl.sh
chmod +x move_csv_json.sh

```

Run the ETL pipeline:
```bash
./etl.sh
```

Run the file movement script:
```
./move_csv_json.sh <source_directory>
```

## Git Version Control

Git is used to track the project and manage changes throughout development.

The project includes a `.gitignore` configuration to prevent generated data files and log files from being unnecessarily committed to the repository.

The completed project is intended for submission through GitHub.

---

## Tools Used

* **Linux / Ubuntu WSL**
* **Bash**
* **Curl**
* **Awk**
* **Cron**
* **Git**
* **GitHub**

---

## Conclusion

This project demonstrates practical Linux and Bash skills applied to a simple data movement workflow. It covers data extraction and transformation, file management, process automation with Cron, and version control using Git.
