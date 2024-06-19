devtools::document()
pkgload::load_all()
library(shiny)
# library(blockr)
# library(blockr.bms)
library(blockr.pharmaverseadam)

stack1 <- new_stack(
  adam_block,
  # arrange_block,
  custom_block
  # my_bloc
)
serve_stack(stack1)
# ui <- fluidPage(
#   theme = bslib::bs_theme(5L),
#   generate_ui(stack1)
# )
# 
# server <- function(input, output, session){
#   generate_server(stack1)
# }

# shinyApp(ui, server)
