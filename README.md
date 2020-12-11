# bed2hgvs
Annotates a BED file with HGVS-like coordinates


```
usage: bed2hgvs.R [-h] -b BEDFILE [-o OUTNAME] [-O OUTDIR] [-p PREFERRED_TX]

Annotates bedfiles with ranges in HGVS-like format

arguments:
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
Returns a TSV file of bed intervals with HGVS-like annotations on the 4th column. If a file of preferred transcripts (RefSeq) are given, any conflict between given transcripts and those stored in the internal RefSeq database will be written to file:

```
.rbed2hgvs.missing
Given RefSeq transcipts - irrespective of version - was not found in the DB

.rbed2hgvs.version
Transcripts were found, but versions were conflicting
```


This script requires R package Rbed2HGVS (https://github.com/cwmedway/Rbed2HGVS). Once the shared conda environment (/env/bed2hgvs.yml) is active, Rbed2HGVS can be installed:
```
devtools::install_github(repo = "cwmedway/Rbed2HGVS", dependencies = T)
```
