#' @import blockr
new_my_block <- function(data, ...){
  blockr::new_block(
    name = "my_block",
    expr = quote({
      knitr::kable(data)
    }),
    fields = list(),
    class = c("my_block")
  )
}

#' @export
my_block <- function(data, ...){
  blockr::initialize_block(new_my_block(data, ...), data)
}

#' @method server_output my_block
#' @export
server_output.my_block <- function (x, result, output) 
{
  shiny::renderPrint(result())
}

#' @method uiOutputBlock my_block
#' @export
uiOutputBlock.my_block <- function (x, ns) 
{
  shiny::verbatimTextOutput(ns("res"))
}

#' @method evaluate_block my_block
#' @export
evaluate_block.my_block <- function (x, data, ...) 
{
  stopifnot(...length() == 0L)
  eval(substitute(data %>% expr, list(expr = generate_code(x))), 
       list(data = data))
}

#' @method generate_server my_block
#' @export
generate_server.my_block <- function (...) 
{
  blockr:::generate_server_block(...)
}

#' @method block_combiner my_block
#' @export
block_combiner.my_block <- function (left, right, ...) 
{
  substitute(left %>% right, list(left = generate_code(left), 
                                  right = generate_code(right)))
}