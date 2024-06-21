#' @export
download_ui.rtables_blocks <- function(x, ns, inputs_hidden = FALSE, ...) {
  div(
    class = "btn-group block-download",
    tags$button(
      shiny::icon("download"),
      class = "btn btn-primary dropdown-toggle",
      `data-bs-toggle` = "dropdown",
      `aria-expanded` = "false"
    ),
    tags$ul(
      class = "dropdown-menu",
      tags$li(
        shiny::downloadLink(
          outputId = ns("word"),
          class = "cursor-pointer dropdown-item",
          "Word"
        )
      ),
      tags$li(
        shiny::downloadLink(
          outputId = ns("pdf"),
          class = "cursor-pointer dropdown-item",
          "PDF"
        )
      ),
      tags$li(
        shiny::downloadLink(
          outputId = ns("txt"),
          class = "cursor-pointer dropdown-item",
          "txt"
        )
      ),
      tags$li(
        shiny::downloadLink(
          outputId = ns("html"),
          class = "cursor-pointer dropdown-item",
          "HTML"
        )
      )
    )
  )
  
}

#' @export
download.rtables_blocks <- function(x, session, object, ...) {
  session$output$word <- shiny::downloadHandler(
    filename = \() {
      return("file.docx")
    },
    content = \(file) {
      rtables::export_as_docx(object(), file) 
    }
  )
  
  session$output$pdf <- shiny::downloadHandler(
    filename = \() {
      return("file.pdf")
    },
    content = \(file) {
      rtables::export_as_pdf(object(), file) 
    }
  )
  
  session$output$txt <- shiny::downloadHandler(
    filename = \() {
      return("file.txt")
    },
    content = \(file) {
      rtables::export_as_pdf(object(), file) 
    }
  )
  
  session$output$html <- shiny::downloadHandler(
    filename = \() {
      return("file.html")
    },
    content = \(file) {
      print(file)
      writeLines(
        rtables::as_html(),
        con = file
      )
    }
  )
}