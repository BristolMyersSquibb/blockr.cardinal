devtools::document()
pkgload::load_all()
library(shiny)
library(blockr)
library(blockr.bms)
library(blockr.pharmaverseadam)

new_two_way_data_block <- function(...){
  blockr::new_block(
    name = "boxplot scatter data",
    expr = quote({
      n <- 100
      data <- data.frame(
        Subgroup_1 = factor(sample(c("Low", "Medium", "High"), n, replace = TRUE)),
        Subgroup_2 = factor(sample(c("A", "B", "C"), n, replace = TRUE)),
        Value = c(rnorm(n, mean = 10, sd = 15), rnorm(n, mean = 20, sd = 45))
      )
    }),
    fields = list(),
    class = c("two_way_data", "data_block")
  )
}
stack1 <- new_stack(
  new_two_way_data_block,
  two_way_summary_table_block,
  title = "two way summary"
)

ui <- fluidPage(
  theme = bslib::bs_theme(5L),
  generate_ui(stack1)
)

server <- function(input, output, session){
  generate_server(stack1)
}

shinyApp(ui, server)