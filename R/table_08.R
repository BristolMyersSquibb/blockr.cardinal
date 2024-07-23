#' @import blockr cardinal rtables
#' @export
new_cardinal08_block <- function(
  ...,
  id_var = character(),
  arm_var = character(),
  saffl_var = character(),
  dth_vars = character(),
  lbl_dth_vars = character(),
  na_level = "NA"
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    id_var = new_select_field(id_var, all_cols, title = "ID"),
    arm_var = new_select_field(arm_var, all_cols, title = "ARM"),
    saffl_var = new_select_field(saffl_var, all_cols, title = "ARM"),
    dth_vars = new_select_field(dth_vars, all_cols, multiple = TRUE, title = "Death"),
    lbl_dth_vars = new_create_field(lbl_dth_vars, title = "Death labels"),
    na_level = new_string_field(na_level, title = "Explicit NA level")
  )

  expr <- quote({
    data <- droplevels(data)

    id_var <- get_column_default(data, .(id_var), "USUBJID")
    arm_var <- get_column_default(data, .(arm_var), "ARM")
    saffl_var <- get_column_default(data, .(saffl_var), "SAFFL")

    rtables <- cardinal::make_table_08(
      adae = data,
      arm_var = arm_var,
      saffl_var = saffl_var,
      id_var = id_var,
      dth_vars = .(dth_vars),
      lbl_dth_vars = .(lbl_dth_vars),
      na_level = na_level
    )

    list(
      rtables = rtables
    )
  })

  blockr::new_block(
    expr = expr,
    fields = fields,
    ...,
    class = c("cardinal08_block", "rtables_block", "submit_block")
  )
}
