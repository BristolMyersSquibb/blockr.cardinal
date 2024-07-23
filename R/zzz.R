.onLoad <- function(libname, pkgname){
  blockr::register_block(
    new_cardinal02_block,
    "Cardinal 02",
    "A Cardinal 02 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("cardinal02_block", "rtables_block", "submit_block")
  )

  blockr::register_block(
    new_cardinal03_block,
    "Cardinal 03",
    "A Cardinal 03 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("cardinal03_block", "rtables_block", "submit_block")
  )

  blockr::register_block(
    new_cardinal05_block,
    "Cardinal 05",
    "A Cardinal 05 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("cardinal05_block", "rtables_block", "submit_block")
  )

  blockr::register_block(
    new_cardinal06_block,
    "Cardinal 06",
    "A Cardinal 06 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("cardinal06_block", "rtables_block", "submit_block")
  )

  blockr::register_block(
    new_cardinal07_block,
    "Cardinal 07",
    "A Cardinal 07 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("cardinal07_block", "rtables_block", "submit_block")
  )

  blockr::register_block(
    new_cardinal08_block,
    "Cardinal 08",
    "A Cardinal 08 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("cardinal08_block", "rtables_block", "submit_block")
  )

  blockr::register_block(
    new_cardinal09_block,
    "Cardinal 09",
    "A Cardinal 09 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("cardinal09_block", "rtables_block", "submit_block")
  )

  blockr::register_block(
    new_cardinal10_block,
    "Cardinal 10",
    "A Cardinal 10 table",
    input = "data.frame",
    output = "list",
    package = pkgname,
    classes = c("cardinal10_block", "rtables_block", "submit_block")
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
