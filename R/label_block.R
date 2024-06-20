
label_expr <- function(value, columns) {
 
  if (is.null(value) || value == "") {
    return(quote(formatters::var_relabel()))
  }
  stopifnot(inherits(value, "character"))
  parse_one <- function(text) {
    expr <- try(parse(text = text))
    if (inherits(expr, "try-error")) {
      expr <- expression()
    }
    expr
  }
  browser()
  exprs <- do.call(c, lapply(value, parse_one))
  bquote(
    # # formatters::var_relabel(..(exprs)),
    # eval(call(" = ", .(column), .(value))),
    # list(columns = as.name(columns), value = value)
    # # splice = TRUE
  )
}

#' Label block constructor
#'
#' Leverages the \link{keyvalue_field}
#'
#' @param value Default value.
#' @inheritParams blockr::new_block
#' @export
new_label_block <- function(value = NULL, ...) {
    first_col <- function(data) colnames(data)[1]
    all_cols <- function(data) colnames(data)
  fields <- list(
    columns = new_select_field(
              first_col,
              all_cols,
              # multiple = TRUE,
              title = "Variable Name"
            ),
    value = blockr::new_string_field(value = character(), title = "Variable Label"),
    expression = new_hidden_field(label_expr)
  )
  
  new_block(
    fields = fields,
    expr = quote(.(expression)),
    ...,
    class = c("label_block", "transform_block", "submit_block")
  )
}

# new_label_block <- function(data, columns = character(),...){
#   # browser()
#   first_col <- function(data) colnames(data)[1]
#   all_cols <- function(data) colnames(data)
#   
#   blockr::new_block(
#     expr = quote(
#       formatters::var_relabel( .(columns) = .(label))
#     ),
#     fields = list(
#       columns = new_select_field(
#         first_col, 
#         all_cols,
#         # multiple = TRUE,
#         title = "Select Columns"
#       ),
#       label = new_string_field()
#       
#     ),
#     ...,
#     class = c("label_block", "transform_block","submit_block")
#   )
# }

#' @export
label_block <- function(data, ...){
  blockr::initialize_block(new_label_block(data, ...), data)
}