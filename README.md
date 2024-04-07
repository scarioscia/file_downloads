
## Download pdf articles via pubmed search 

This directory contains two scripts to support querying PubMed and downloading resulting files. 

First, `get_pmids.py` gathers PMIDs resulting from each search, with usage:

        `python get_pmids.py "searchterms" <outdir>`

This will create a create a file with naming convention `search_terms_todays_date.txt` in the `outdir` directory. Replace `outdir` with your preferred destination for this file. By default it will download include the first 100 PMIDs in response to your search; you can modify the script directly to change this number. These PMIDs will be comma-separated to allow use by existing packages (e.g., [this](https://github.com/billgreenwald/Pubmed-Batch-Download) program or [this](https://github.com/ddomingof/PubMed2PDF/tree/master) Python wrapper). 

Second, `pmid_to_pmc.sh` downloads the `.pdf` file for each PMID, with usage: 

        `pmid_to_pmc.sh -o <outdir> -f <search_terms_todays_date.txt>`

The `-o` flag specifies the destination (directory) to download the pdf files; the `-f` flag is the file containing the PMIDs created in the first step. The resulting pdfs are named with the convention `pmid.pdf`. 

### Example 

For example, executing 

		`python get_pmids.py "flower ovule count" /Users/myuser/labwork/` 
on April 6, 2024 would yield a file `flower_ovule_count_04062024.txt` in the `/Users/myuser/labwork/` directory. 

If that .txt file contains PMIDs 1234, 5313, and 2424, executing 
		`pmid_to_pmc.sh -o /Users/myuser/labwork/downloads -f flower_ovule_count_04062024.txt`
will yield files `1234.pdf`, `5313.pdf`, and `2424.pdf` in the `/Users/myuser/labwork/download` directory.

## Code status

This code has been adapted for a pull request in the `PubMed2PDF` Python package: https://github.com/ddomingof/PubMed2PDF/pulls. If merged, this update will allow the user to directly search PubMed and then automatically download the resulting papers, all within one step in the `PubMed2PDF` package. If it is not merged, I will consider repackaging the code here to achieve that, possibly also addressing the below opportunities for improvement. 

### Improvements
- Take number of resulting PMIDs as command line argument
- Create new directory based on each search term and use this as default destination for PDFs 
- Take NCBI email as argument for each user (or find other workaround)
- Write PMIDs that failed to download to file 
- Create option to rename the `pmids.txt` file with custom name (command line args)

