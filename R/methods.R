#' @method server_output rtables_block
#' @export
server_output.rtables_block <- function (x, result, output) {
  shiny::renderUI({
    txt <- utils::capture.output(print(result()$rtables))
    txt <- paste0(txt, collapse = "\n")

    if(length(result()$gt) > 0){
      shiny::tabsetPanel(
        shiny::tabPanel(
          "GT",
          result()$gt
        ),
        shiny::tabPanel(
          "Text",
          tags$pre(
            tags$code(
              txt
            )
          )
        ),
        shiny::tabPanel(
          "HTML",
          rtables::as_html(result()$rtables, class_table = "table")
        )
      )
    } else {
      shiny::tabsetPanel(
        shiny::tabPanel(
          "Text",
          tags$pre(
            tags$code(
              txt
            )
          )
        ),
        shiny::tabPanel(
          "HTML",
          rtables::as_html(result()$rtables, class_table = "table")
        )
      )
    }
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
