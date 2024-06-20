devtools::document()
pkgload::load_all()
library(shiny)
library(blockr)
library(blockr.pharmaverseadam)

stack1 <- new_stack(
  random_cdisc_data_block,
  falcon02_block
)
serve_stack(stack1)
