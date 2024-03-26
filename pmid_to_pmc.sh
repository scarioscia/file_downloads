#!/usr/bin/env bash

# Usage: ./pmid_to_pmc.sh -o downloads/ -f ./downloads/ovule_count_flower_2024-03-26.txt 
# or: ./script.sh -o <output_directory> -p "38471747,38470466,38470000"

# Function to display usage information
usage() {
    echo "Usage: $0 -o <output_directory> [-f <input_file> | -p <pmid_list>]"
    echo "Options:"
    echo "  -o <output_directory>: Specify the output directory for saving PDF files."
    echo "  -f <input_file>: Specify the input file containing comma-separated PMIDs."
    echo "  -p <pmid_list>: Specify a comma-separated list of PMIDs directly on the command line."
    exit 1
}

# Parse command-line arguments
while getopts ":o:f:p:" opt; do
    case $opt in
        o) output_dir="$OPTARG" ;;
        f) input_file="$OPTARG" ;;
        p) pmid_list="$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2
            usage ;;
        :) echo "Option -$OPTARG requires an argument." >&2
            usage ;;
    esac
done

# Check if output directory is provided
if [ -z "$output_dir" ]; then
    echo "Error: Output directory must be specified."
    usage
fi

# Check if both input file and pmid list are provided
if [ -n "$input_file" ] && [ -n "$pmid_list" ]; then
    echo "Error: Both input file and pmid list cannot be specified simultaneously."
    usage
fi

# If input file is provided, read the PMIDs from the file
if [ -n "$input_file" ]; then
    IFS=',' read -r -a ID < "$input_file"
fi

# If pmid list is provided, split it into an array
if [ -n "$pmid_list" ]; then
    IFS=',' read -r -a ID <<< "$pmid_list"
fi

# Create the output directory if it does not exist
mkdir -p "$output_dir"

Link="http://www.ncbi.nlm.nih.gov/pubmed/"
PMCLink="http://www.ncbi.nlm.nih.gov/pmc/articles/"

# Loop through each PMID
for f in "${ID[@]}"; do
    PMCID=$(wget --user-agent="Mozilla/5.0 (Windows NT 5.2; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" \
        -l1 --no-parent "${Link}${f}" -O - 2>/dev/null | grep -o 'PMC[0-9]\+' | head -n 1)
    if [ "$PMCID" ]; then
        wget --user-agent="Mozilla/5.0 (Windows NT 5.2; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" \
            -l1 --no-parent -A.pdf "${PMCLink}${PMCID}/pdf/" -O "${output_dir}/${f}.pdf" 2>/dev/null
    else
        echo "No PMC ID for $f"
    fi
done

