pkgload::load_all()
library(shiny)
library(blockr)
library(blockr.pharmaverseadam)

stack <- new_stack(
  random_cdisc_data_block,
  falcon02_gt_block
)

serve_stack(stack)
