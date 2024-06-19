#' @import blockr falcon rtables
new_falcon02_block <- function(data, columns = character(),...){
  # browser()
  first_col <- function(data) colnames(data)[1]
  all_cols <- function(data) colnames(data)
  
  blockr::new_block(
    expr = quote(
      falcon::make_table_02(
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
    class = c("custom_block", "rtables_block","submit_block")
  )
}

#' @export
falcon02_block <- function(data, ...){
  blockr::initialize_block(new_falcon02_block(data, ...), data)
}
