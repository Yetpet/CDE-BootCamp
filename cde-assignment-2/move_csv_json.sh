#!/bin/bash

# ============================================================
# CoreDataEngineers - CDE Assignment 2
# CSV and JSON File Movement Script
#
# Purpose:
#   Move all CSV and JSON files from a source directory
#   into the json_and_CSV directory.
#
# Usage:
#   ./move_csv_json.sh <source_directory>
#
# Example:
#   ./move_csv_json.sh raw
# ============================================================


# ------------------------------------------------------------
# CHECK SOURCE DIRECTORY
# ------------------------------------------------------------

SOURCE_DIR="$1"
DESTINATION_DIR="json_and_CSV"


if [ -z "$SOURCE_DIR" ]; then

    echo "ERROR: Please provide a source directory."

    echo "Usage:"
    echo "./move_csv_json.sh <source_directory>"

    exit 1

fi


if [ ! -d "$SOURCE_DIR" ]; then

    echo "ERROR: Source directory does not exist:"
    echo "$SOURCE_DIR"

    exit 1

fi


# ------------------------------------------------------------
# CREATE DESTINATION DIRECTORY
# ------------------------------------------------------------

mkdir -p "$DESTINATION_DIR"


echo "=========================================="
echo "CSV AND JSON FILE MOVEMENT"
echo "=========================================="

echo ""
echo "Source directory:"
echo "$SOURCE_DIR"

echo ""
echo "Destination directory:"
echo "$DESTINATION_DIR"


# ------------------------------------------------------------
# MOVE CSV FILES
# ------------------------------------------------------------

CSV_COUNT=0

for FILE in "$SOURCE_DIR"/*.csv; do

    if [ -f "$FILE" ]; then

        mv "$FILE" "$DESTINATION_DIR/"

        echo "Moved CSV:"
        echo "$FILE"

        CSV_COUNT=$((CSV_COUNT + 1))

    fi

done


# ------------------------------------------------------------
# MOVE JSON FILES
# ------------------------------------------------------------

JSON_COUNT=0

for FILE in "$SOURCE_DIR"/*.json; do

    if [ -f "$FILE" ]; then

        mv "$FILE" "$DESTINATION_DIR/"

        echo "Moved JSON:"
        echo "$FILE"

        JSON_COUNT=$((JSON_COUNT + 1))

    fi

done


# ------------------------------------------------------------
# SUMMARY
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "FILE MOVEMENT COMPLETED"
echo "=========================================="

echo "CSV files moved: $CSV_COUNT"
echo "JSON files moved: $JSON_COUNT"
