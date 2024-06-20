#' @method server_output rtables_block
#' @export
server_output.rtables_block <- function (x, result, output) {
  shiny::renderUI({
    shiny::tabsetPanel(
      shiny::tabPanel(
        "HTML",
        rtables::as_html(result())
      ),
      shiny::tabPanel(
        "Text",
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

#' @export
download_ui.rtables_block <- function(x, ns, inputs_hidden = FALSE, ...) {
  id <- ns("download")
  
  downloadLink(
    outputId = id,
    class = sprintf("cursor-pointer text-decoration-none block-download %s", inputs_hidden),
    shiny::icon("download")
  )
}

#' @export
download.rtables_block <- function(x, session, object, ...) {
  session$output$download <- downloadHandler(
    filename = \() {
      "file.pdf" 
    },
    content = \(file) {
      print(object())
      rtables::export_as_pdf(object(), file) 
    }
  )
}