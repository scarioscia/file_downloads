#!/usr/bin/env python3

import sys
import os
import datetime
from Bio import Entrez

# Usage: python get_pmids.py "ovule count flower" ./downloads

# Provide your email address to comply with NCBI's usage policy
Entrez.email = "saracarioscia@gmail.com"

def search_pubmed(query):
    handle = Entrez.esearch(db="pubmed", term=query, retmax=100)  # Adjust retmax as needed
    record = Entrez.read(handle)
    handle.close()
    return record["IdList"]

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <search_query> <output_directory>")
        sys.exit(1)

    query = sys.argv[1]
    output_directory = sys.argv[2]

    if not os.path.exists(output_directory):
        os.makedirs(output_directory)

    query_filename = query.replace(" ", "_")
    today = datetime.date.today().strftime("%Y-%m-%d")
    output_filename = os.path.join(output_directory, f"{query_filename}_{today}.txt")

    paper_ids = search_pubmed(query)
    if paper_ids:
        with open(output_filename, "w") as f:
            f.write(",".join(paper_ids))
        print(f"PMIDs relevant to the search have been saved to {output_filename}")
    else:
        print("No papers found for the given query.")

