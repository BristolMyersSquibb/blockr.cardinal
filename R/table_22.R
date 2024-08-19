#' @import blockr cardinal rtables
#' @export
new_cardinal22_block <- function(
  ...,
  arm_var = character(),
  vars = character(),
  denom = character(),
  saffl_var = character(),
  show_colcounts = TRUE,
  prune_0 = FALSE
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    vars = new_select_field(vars, all_cols, multiple = TRUE, title = "Variables"),
    denom = new_create_field(denom, title = "Denom"),
    arm_var = new_select_field(arm_var, all_cols, title = "ARM"),
    saffl_var = new_select_field(saffl_var, all_cols, title = "ARM"),
    show_colcounts = new_switch_field(show_colcounts, title = "Show column counts"),
    prune_0 = new_switch_field(title = "Prune all zero rows")
  )

  expr <- quote({
    arm_var <- get_column_default(data, .(arm_var), "ARM")
    saffl_var <- get_column_default(data, .(saffl_var), "SAFFL")

    rtables <- cardinal::make_table_22(
      df = data,
      arm_var = arm_var,
      show_colcounts = .(show_colcounts),
      saffl_var = saffl_var,
      prune_0 = .(prune_0),
      denom = .(denom),
      vars = .(vars)
    )

    list(
      rtables = rtables
    )
  })

  blockr::new_block(
    expr = expr,
    fields = fields,
    ...,
    class = c("cardinal22_block", "rtables_block", "submit_block")
  )
}
