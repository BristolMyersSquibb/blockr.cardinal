devtools::document()
pkgload::load_all()
library(shiny)
library(blockr)
library(blockr.pharmaverseadam)

stack <- new_stack(
  # data_block,
  random_cdsic_data_block,
  # mutate_block,
  # label_block
  # falcon05_block
  falcon02_block
)
serve_stack(stack)
