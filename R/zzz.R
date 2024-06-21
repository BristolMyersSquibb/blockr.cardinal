.onLoad <- function(...){
  blockr::register_block(
    falcon02_block,
    "Falcon 02",
    "A Falcon 02 table",
    input = "data.frame",
    output = "list",
    package = "blockr.falcon",
    classes = c("falcon02_block", "rtables_block", "submit_block")
  )
  
  blockr::register_block(
    falcon05_block,
    "Falcon 05",
    "A Falcon 05 table",
    input = "data.frame",
    output = "list",
    package = "blockr.falcon",
    classes = c("falcon05_block", "rtables_block", "submit_block")
  )
  
  blockr::register_block(
    relabel_block,
    "Relabel block",
    "Change columns label attributes",
    input = "data.frame",
    output = "data.frame",
    package = "data.frame",
    classes = c("relabel_block", "transform_block", "submit_block")
  )
}