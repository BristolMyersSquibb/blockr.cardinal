#' @method server_output rtables_block
#' @export
server_output.rtables_block <- function (x, result, output) {
  shiny::renderUI({
    # print(result())
    shiny::tabsetPanel(
      shiny::tabPanel(
        "HTML",
        rtables::as_html(result())
      ),
      shiny::tabPanel(
        "RTF"
      )
    )
  })
}

#' @method uiOutputBlock rtables_block
#' @export
uiOutputBlock.rtables_block <- function (x, ns) {
  shiny::uiOutput(ns("res"))
}

#' @method evaluate_block rtables_block
#' @export
evaluate_block.rtables_block <- function (x, data, ...) {
  stopifnot(...length() == 0L)
  eval(substitute(data %>% expr, list(expr = generate_code(x))), 
       list(data = data))
}

#' @method generate_server rtables_block
#' @export
generate_server.rtables_block <- function (...) {
  blockr:::generate_server_block(...)
}

#' @method block_combiner rtables_block
#' @export
block_combiner.rtables_block <- function (left, right, ...) {
  substitute(left %>% right, list(left = generate_code(left), 
                                  right = generate_code(right)))
}