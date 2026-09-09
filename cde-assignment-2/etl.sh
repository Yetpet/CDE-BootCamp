#!/bin/bash

# ============================================================
# CoreDataEngineers - CDE Assignment 2
# Bash ETL Pipeline
#
# Extract:
#   Download the Annual Enterprise Survey CSV file
#   and save it in the raw directory.
#
# Transform:
#   Rename Variable_code to variable_code.
#   Select only:
#       year, Value, Units, variable_code
#
# Load:
#   Copy the transformed file into the Gold directory.
# ============================================================


# ------------------------------------------------------------
# ENVIRONMENT VARIABLES
# ------------------------------------------------------------

CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

export CSV_URL


# ------------------------------------------------------------
# DIRECTORY AND FILE VARIABLES
# ------------------------------------------------------------

RAW_DIR="raw"
TRANSFORMED_DIR="Transformed"
GOLD_DIR="Gold"

RAW_FILE="$RAW_DIR/annual-enterprise-survey-2023-financial-year-provisional.csv"
TRANSFORMED_FILE="$TRANSFORMED_DIR/2023_year_finance.csv"
GOLD_FILE="$GOLD_DIR/2023_year_finance.csv"


# ------------------------------------------------------------
# CREATE REQUIRED DIRECTORIES
# ------------------------------------------------------------

echo "=========================================="
echo "CDE ASSIGNMENT 2 - ETL PIPELINE"
echo "=========================================="

echo ""
echo "Creating required directories..."

mkdir -p "$RAW_DIR"
mkdir -p "$TRANSFORMED_DIR"
mkdir -p "$GOLD_DIR"

echo "Directories created successfully."


# ------------------------------------------------------------
# EXTRACT
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "STEP 1: EXTRACT"
echo "=========================================="

echo "Downloading CSV file..."

if curl --ssl-no-revoke -L -f -sS "$CSV_URL" -o "$RAW_FILE"; then

    echo "Download completed successfully."

else

    echo "ERROR: Failed to download CSV file."
    exit 1

fi


# Confirm that the file exists

if [ -f "$RAW_FILE" ]; then

    echo "SUCCESS: CSV file saved in:"
    echo "$RAW_FILE"

else

    echo "ERROR: CSV file was not saved."
    exit 1

fi


# ------------------------------------------------------------
# TRANSFORM
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "STEP 2: TRANSFORM"
echo "=========================================="

echo "Transforming CSV file..."

echo "Required columns:"
echo "year, Value, Units, variable_code"

awk -F',' '
BEGIN {
    OFS=","
}

NR == 1 {

    # Find the position of each required column
    for (i = 1; i <= NF; i++) {

        if ($i == "Year")
            year_col = i

        if ($i == "Value")
            value_col = i

        if ($i == "Units")
            units_col = i

        if ($i == "Variable_code")
            variable_code_col = i
    }

    # Write the transformed header
    print "year", "Value", "Units", "variable_code"

    next
}

{
    # Write only the required columns
    print $year_col, $value_col, $units_col, $variable_code_col
}

' "$RAW_FILE" > "$TRANSFORMED_FILE"


# ------------------------------------------------------------
# CONFIRM TRANSFORMATION
# ------------------------------------------------------------

if [ -f "$TRANSFORMED_FILE" ]; then

    echo "SUCCESS: Transformation completed."
    echo "Transformed file saved in:"
    echo "$TRANSFORMED_FILE"

else

    echo "ERROR: Transformation failed."
    exit 1

fi


# ------------------------------------------------------------
# LOAD
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "STEP 3: LOAD"
echo "=========================================="

echo "Loading transformed file into Gold..."

cp "$TRANSFORMED_FILE" "$GOLD_FILE"


# ------------------------------------------------------------
# CONFIRM LOAD
# ------------------------------------------------------------

if [ -f "$GOLD_FILE" ]; then

    echo "SUCCESS: File loaded into Gold."
    echo "Gold file:"
    echo "$GOLD_FILE"

else

    echo "ERROR: Failed to load file into Gold."
    exit 1

fi


# ------------------------------------------------------------
# COMPLETION MESSAGE
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "ETL PIPELINE COMPLETED SUCCESSFULLY"
echo "=========================================="

echo "Extracted:  $RAW_FILE"
echo "Transformed: $TRANSFORMED_FILE"
echo "Loaded:     $GOLD_FILE"
