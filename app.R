devtools::document()
pkgload::load_all()
library(shiny)
library(blockr)
library(blockr.pharmaverseadam)

stack1 <- new_stack(
  new_random_cdisc_data_block,
  new_relabel_block,
  new_falcon02_block,
  title = "Falcon 02"
)

stack2 <- new_stack(
  new_random_cdisc_data_block,
  new_falcon05_block,
  title = "Falcon 05"
)

ui <- fluidPage(
  theme = bslib::bs_theme(5L),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack1)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack2)
    )
  )
)

server <- function(...){
  generate_server(stack1)
  generate_server(stack2)
}

shinyApp(ui, server)
