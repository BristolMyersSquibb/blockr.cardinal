devtools::document()
pkgload::load_all()
library(shiny)
library(blockr)
library(blockr.pharmaverseadam)

stack <- new_stack(
  random_cdisc_data_block,
  relabel_block,
  # falcon02_block,
  falcon05_block
)
serve_stack(stack)
