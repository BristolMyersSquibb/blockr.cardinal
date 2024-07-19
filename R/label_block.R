#' @export
new_relabel_block <- function(
  columns = colnames(data)[1L],
  values = character(),
  ...
) {
  sub_fields <- function(data, columns) {
    determine_field <- function(x) {
      blockr::string_field
    }

    field_args <- function(x) {
      list()
    }

    cols <- data[, columns, drop = FALSE]

    ctor <- lapply(cols, determine_field)
    args <- lapply(cols, field_args)

    Map(do.call, ctor, args)
  }

  filter_exps <- function(data, values) {
    for(i in seq_along(values)){
      nm <- names(values)[i]
      attr(data[[nm]], "label") <- values[i] |> unlist() |> unname()
    }

    data
  }

  col_choices <- function(data) colnames(data)

  fields <- list(
    columns = new_select_field(columns, col_choices, multiple = TRUE, title = "Columns"),
    values = new_list_field(values, sub_fields, title = "Value"),
    expression = new_hidden_field(filter_exps)
  )

  expr <- quote({
    .(expression)
  })

  new_block(
    fields = fields,
    expr = expr,
    ...,
    class = c("relabel_block", "transform_block", "submit_block")
  )
}
