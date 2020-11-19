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
The script will return a tsv file of bed intervals with HGVS annotations on the 4th column. If preferred_transcripts are given, any conflict between given transcripts and those stored in the data abse will be written to file:

```
.rbed2hgvs.missing
Transcipts - irrespective of version - was not found in the DB

.rbed2hgvs.version
Transcripts were founds, but versions were conflicting
```


This script required R package Rbed2HGVS (https://github.com/cwmedway/Rbed2HGVS). Once the shared conda environment (/env/bed2hgvs.yml) is active, Rbed2HGVS can be installed:
```
devtools::install_github(repo = "cwmedway/Rbed2HGVS", dependencies = T)
```
