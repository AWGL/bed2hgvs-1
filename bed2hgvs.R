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

  parser$parse_args() %>%
    return()
}

# get command line arguments
args <- parseCmdArgs()

# load bedfile
bedfile <- rtracklayer::import(con = args$bedfile, format = 'bed')

# run main function
output <- Rbed2HGVS::Rbed2HGVS(bedfile = bedfile, preferred_tx = args$preferred_tx)

if (!is.null(output$hgvs)) {

  # reformat HGVS column
  output$hgvs$hgvs <- paste0(
    output$hgvs$gene,
    "(", output$hgvs$tx,")",
    ":c.", output$hgvs$hgvs_start,"_", output$hgvs$hgvs_end
    )

  # write out annotated BED
  data.frame(
    GenomicRanges::seqnames(output$hgvs) %>% as.character(),
    GenomicRanges::start(output$hgvs) - 1,
    GenomicRanges::end(output$hgvs),
    output$hgvs$hgvs,
    stringsAsFactors = F
  ) %>%
    write.table(
      x = .,
      sep = "\t" ,
      file = paste0(args$outdir, "/", args$outname, ".gaps"),
      quote = F,
      row.names = F,
      col.names = F
      )

  # write out any missing or inconsistent preferred REFSEQ transcripts
  if (!is.null(args$preferred_tx)) {

    write.table(
      x = output[['missing']],
      sep = "\t",
      file = paste0(args$outdir, "/", args$outname, ".rbed2hgvs.missing"),
      quote = F,
      row.names = F,
      col.names = F
      )

    write.table(
      x = output[['version']],
      sep = "\t",
      file = paste0(args$outdir, "/", args$outname, ".rbed2hgvs.version"),
      quote = F,
      row.names = F,
      col.names = F
    )
  }
}
