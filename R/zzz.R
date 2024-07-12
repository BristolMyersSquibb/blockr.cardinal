.onLoad <- function(libname, pkgname){
  blockr::register_block(
    new_falcon02_block,
    "Falcon 02",
    "A Falcon 02 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("falcon02_block", "rtables_block", "submit_block")
  )

  blockr::register_block(
    new_falcon05_block,
    "Falcon 05",
    "A Falcon 05 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("falcon05_block", "rtables_block", "submit_block")
  )

  blockr::register_block(
    new_relabel_block,
    "Relabel block",
    "Change columns label attributes",
    input = "data.frame",
    output = "data.frame",
    package = pkgname,
    classes = c("relabel_block", "transform_block", "submit_block")
  )

  blockr::register_block(
    new_random_cdisc_data_block,
    "Random CDISC data",
    "Use random CDISC datasets",
    input = NA_character_,
    output = "data.frame",
    package = pkgname,
    classes = c("random_cdisc_block", "data_block")
  )
}
