# bed2hgvs
Annotates a BED file with HGVS-like coordinates

# run-Rbed2hgvs

```
usage: bed2hgvs.R [-h] -b BEDFILE [-o OUTNAME] [-O OUTDIR]
                       [-p PREFERRED_TX] -d REFSEQDB

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
  -d REFSEQDB, --refseqdb REFSEQDB
                        path to sqlite database of REFSEQ transcripts

```

### RefSeq DB

`-d / --refseqDB` points to a .sqlite DB of RefSeq transcripts. This can be downloaded from UCSC using the GenomicFeatures package in R:

```
# download from UCSC
ucsc_hg19_ncbiRefSeq <- GenomicFeatures::makeTxDbFromUCSC(genome = "hg19", tablename = "ncbiRefSeq")

# save local sqlite DB
AnnotationDbi::saveDb(x = ucsc_hg19_ncbiRefSeq, file = 'ucsc_hg19_ncbiRefSeq.sqlite')
```
