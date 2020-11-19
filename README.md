# bed2hgvs
Annotates a BED file with HGVS-like coordinates


```
usage: bed2hgvs.R [-h] -b BEDFILE [-o OUTNAME] [-O OUTDIR] [-p PREFERRED_TX]

Adds HGVS-like annotation to a bedfile

optional arguments:
  -h, --help            show this help message and exit
  -b BEDFILE, --bedfile BEDFILE
                        path to BED file (REQUIRED)
  -o OUTNAME, --outname OUTNAME
                        output file name
  -O OUTDIR, --outdir OUTDIR
                        output file directory
  -p PREFERRED_TX, --preferred_tx PREFERRED_TX
                        path to tsv file of preferred transcripts <GENENAME>
                        <REFSEQID>. One REFSEQID per row

```

This script required R package Rbed2HGVS (https://github.com/cwmedway/Rbed2HGVS). This package uses an internal RefSeq database compiled from UCSC. 


