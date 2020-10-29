if(!require(magrittr)){
  install.packages("magrittr")
  library(magrittr)
}

if(!require(devtools)){
  install.packages("devtools")
  library(Rbed2HGVS)
}

if(!require(Rbed2HGVS)){
  devtools::install_github(repo = "cwmedway/Rbed2HGVS", dependencies = T)
  library(Rbed2HGVS)
}

parseCmdArgs <- function() {

  parser <- argparse::ArgumentParser(description="Adds HGVS-like annotation to a bedfile")

  parser$add_argument(
    "-b",
    "--bedfile",
    help="path to BED file (REQUIRED)",
    required=T,
    type="character"
    )

  parser$add_argument(
    "-o",
    "--outname",
    help="output file name",
    default="hgvs",
    type="character"
    )

  parser$add_argument(
    "-O",
    "--outdir",
    default="./",
    help="output file directory",
    type="character"
    )

  parser$add_argument(
    "-p",
    "--preferred_tx",
    help="path to tsv file of preferred transcripts <GENENAME>\t<REFSEQID>. One REFSEQID per row",
    type="character"
    )

  parser$add_argument(
    "-d",
    "--refseqdb",
    help="path to sqlite database of REFSEQ transcripts",
    required=T,
    type="character"
    )

  parser$parse_args() %>%
    return()
}

# get command line arguments
args <- parseCmdArgs()

# run main function
out <- Rbed2HGVS::Rbed2HGVS(bedfile = args$bedfile, db = args$refseqdb, preferred_tx = args$preferred_tx)

if (!is.na(out)) {

  # reformat HGVS column
  out$hgvs$tx <- paste0(out$hgvs$gene, "(", out$hgvs$tx,")",":c.", out$hgvs$hgvs_start,"_", out$hgvs$hgvs_end)

  # write out annotated BED
  write.table(
    x = out$hgvs[,1:4],
    sep = "\t" ,
    file = paste0(args$outdir, "/", args$outname, ".gaps"),
    quote = F,
    row.names = F,
    col.names = F
    )

  # write out any missing or inconsistent preferred REFSEQ transcripts
  if (!is.null(args$preferred_tx)) {

    write.table(
      x = out[['missing']],
      sep = "\t",
      file = paste0(args$outdir, "/", args$outname, ".rbed2hgvs.missing"),
      quote = F,
      row.names = F,
      col.names = F
      )

    write.table(
      x = out[['version']],
      sep = "\t",
      file = paste0(args$outdir, "/", args$outname, ".rbed2hgvs.version"),
      quote = F,
      row.names = F,
      col.names = F
    )
  }
}
