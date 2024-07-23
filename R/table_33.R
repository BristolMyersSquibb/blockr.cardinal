#' @import blockr cardinal rtables
#' @export
new_cardinal33_block <- function(
  ...,
  id_var = character(),
  arm_var = character(),
  saffl_var = character(),
  show_colcounts = TRUE,
  prune_0 = FALSE
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    id_var = new_select_field(id_var, all_cols, title = "ID"),
    arm_var = new_select_field(arm_var, all_cols, title = "ARM"),
    saffl_var = new_select_field(saffl_var, all_cols, title = "ARM"),
    show_colcounts = new_switch_field(show_colcounts, title = "Show column counts"),
    prune_0 = new_switch_field(title = "Prune all zero rows")
  )

  expr <- quote({
    id_var <- get_column_default(data, .(id_var), "USUBJID")
    arm_var <- get_column_default(data, .(arm_var), "ARM")
    saffl_var <- get_column_default(data, .(saffl_var), "SAFFL")

    rtables <- cardinal::make_table_33(
      advs = data,
      id_var = id_var,
      arm_var = arm_var,
      show_colcounts = .(show_colcounts),
      prune_0 = .(prune_0)
    )

    list(
      rtables = rtables
    )
  })

  blockr::new_block(
    expr = expr,
    fields = fields,
    ...,
    class = c("cardinal33_block", "rtables_block", "submit_block")
  )
}
