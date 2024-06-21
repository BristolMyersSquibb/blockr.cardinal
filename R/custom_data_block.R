#' @import blockr falcon rtables
new_falcon02_block <- function(data, columns = character(),...){
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
    class = c("custom_block", "rtables_block")
  )
}

#' @export
falcon05_block <- function(data, ...){
  blockr::initialize_block(new_falcon05_block(data, ...), data)
}
