#!/bin/bash

# 1 - Access the environment variables
TOTAL_COVERAGE_THRESHOLD=${TOTAL_COVERAGE_THRESHOLD}
INDIVIDUAL_COVERAGE_THRESHOLD=${INDIVIDUAL_COVERAGE_THRESHOLD}
GITHUB_WORKSPACE_PATH=${GITHUB_WORKSPACE_PATH}

# 2 - Define Coverage Report File Names
coverage_report_file_full="$GITHUB_WORKSPACE_PATH/coverage_report_full.txt"
coverage_report_file_filtered="$GITHUB_WORKSPACE_PATH/coverage_report_filtered.txt"
coverage_report_status="$GITHUB_WORKSPACE_PATH/coverage_status.txt"

# 3 - Check Total Coverage
total_coverage=$(grep 'TOTAL' "$coverage_report_file_full" | awk '{print $4}' | sed 's/%//')
if [[ $total_coverage -lt $TOTAL_COVERAGE_THRESHOLD ]]; then
    echo "Total coverage is below $TOTAL_COVERAGE_THRESHOLD%"
    echo "TOTAL_COVERAGE_PASSED=false" >>"$coverage_report_status"
else
    echo "Total coverage is above $TOTAL_COVERAGE_THRESHOLD%"
    echo "TOTAL_COVERAGE_PASSED=true" >>"$coverage_report_status"
fi

# 4 - Check Individual Coverage
# initialize the individual coverage passed flag
individual_coverage_passed=true

# read the file contents into an array
# this coverage report has filtered out lines for the titles and end of the file
mapfile -t lines <"$coverage_report_file_filtered"

# for every file with the tests check its coverage
for line in "${lines[@]}"; do
    file_coverage=$(echo "$line" | awk '{print $2}' | sed 's/%//')
    file_name=$(echo "$line" | awk '{print $1}')
    if [[ $file_coverage -lt $INDIVIDUAL_COVERAGE_THRESHOLD ]]; then
        echo "Coverage for $file_name is $file_coverage% which is below $INDIVIDUAL_COVERAGE_THRESHOLD%"
        individual_coverage_passed=false
    fi
done

# save the outcome to the txt file
# (if at least one individual failed, INDIVIDUAL_COVERAGE_PASSED=false)
if [[ $individual_coverage_passed = true ]]; then
    echo "Coverage for all files is above $INDIVIDUAL_COVERAGE_THRESHOLD%"
    echo "INDIVIDUAL_COVERAGE_PASSED=true" >>"$coverage_report_status"
else
    echo "Coverage for one or more files is below $INDIVIDUAL_COVERAGE_THRESHOLD%"
    echo "INDIVIDUAL_COVERAGE_PASSED=false" >>"$coverage_report_status"
fi
