#' @import blockr falcon rtables
new_falcon02_block <- function(
    data,
    columns = colnames(data)[1L],
    values = character(),
    ...){
  sub_fields <- function(data, columns) {
    determine_field <- function(x) {
      string_field
    }
    
    field_args <- function(x) {
      list(x)
    }
    
    cols <- data[, columns, drop = FALSE]
    
    ctor <- lapply(cols, determine_field)
    args <- lapply(names(cols), field_args)
    
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
    falcon::make_table_02(
      df = .(expression),
      vars = c("SEX", "AGE", "RACE"),
      lbl_vars = c("Sex", "Age, years", "Race")
    )
  })
  
  blockr::new_block(
    expr = expr,
    fields = fields,
    ...,
    class = c("falcon02_block", "rtables_block", "submit_block")
  )
}

#' @export
falcon02_block <- function(data, ...){
  blockr::initialize_block(new_falcon02_block(data, ...), data)
}

#' @import blockr falcon rtables tern gt
new_falcon02_gt_block <- function(data, columns = character(),...){
  first_col <- function(data) colnames(data)[1]
  all_cols <- function(data) colnames(data)
  blockr::new_block(
    expr = quote(
      make_table_02_gtsum(
          vars = .(columns)
      )
    ),
    fields = list(
      columns = new_select_field(
        first_col, 
        all_cols,
        multiple = TRUE,
        title = "Select Columns"
      )
    ),
    ...,
    class = c("falcon02_gt_block", "rtables_block","submit_block")
  )
}

#' @export
falcon02_gt_block <- function(data, ...){
  blockr::initialize_block(new_falcon02_gt_block(data, ...), data)
}

#' @import blockr falcon rtables tern
new_falcon05_block <- function(data, columns = character(),...){
  blockr::new_block(
    
    expr = quote(
      falcon::make_table_05(
        risk_diff = list(arm_x = "B: Placebo",
                         arm_y = "A: Drug X")
        )
    ),
    fields = list(),
    ...,
    class = c("falcon05_block", "rtables_block")
  )
}

#' @export
falcon05_block <- function(data, ...){
  blockr::initialize_block(new_falcon05_block(data, ...), data)
}
