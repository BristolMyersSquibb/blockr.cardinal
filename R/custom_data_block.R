#' @import blockr falcon rtables
new_custom_block<- function(columns = character(),...){
  # browser()
  all_cols <- function(data) colnames(data)
  blockr::new_block(
    name = "boxplot scatter data",
    expr = quote({
      adsl <- random.cdisc.data::cadsl
      data <- falcon::make_table_02(
        df = adsl,
        vars = c("SEX", "AGE", "RACE"),
        lbl_vars = c("Sex", "Age, years", "Race")
      )
      data
    }),
    fields = list(columns = new_select_field(columns, all_cols,
                                             # multiple = TRUE,
                                             title = "Columns"
    )),
    class = c("custom_block", "rtables_block", "transform_block")
  )
}
#' @export
custom_block <- function(data, ...){
  blockr::initialize_block(new_custom_block(data, ...), data)
}
