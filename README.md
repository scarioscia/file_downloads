
## Download pdf articles via pubmed search 

To get PMIDs relevant for topic of interest, execute `get_pmids.py` with usage: 
`python get_pmids.py "searchterms" <outdir>`

This will create a create a file with naming convention `search_terms_todays_date.txt` in the `outdir` directory, containing the first 100 PMIDs in response to your search. These PMIDs will be comma-separated to allow use by existing packages e.g., https://github.com/billgreenwald/Pubmed-Batch-Download (or wrapped in Python: https://github.com/ddomingof/PubMed2PDF/tree/master). 

To download the pdf for each PMID, execute `pmid_to_pmc.sh` with usage: 
`pmid_to_pmc.sh -o <outdir> -f pmids.txt` (using the output file generated above). `outdir` will specify location for PDF download; default naming convention is `pmid.pdf`. 

### Improvements: 
- Take number of resulting PMIDs as command line argument
- Send downloaded PDFs to directory created for each query 
- Figure out NCBI email requirement (ideally none)
- Write failed PMIDs to file output also to outdir 
- Better README 