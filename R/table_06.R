#' FDA Table 6: Overview of Adverse Events, Safety Population, Pooled Analyses
#' @import blockr cardinal rtables
#' @export
new_cardinal06_block <- function(
  ...,
  id_var = character(),
  arm_var = character(),
  show_colcounts = FALSE,
  prune_0 = TRUE,
  saffl_var = character()
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    id_var = new_select_field(id_var, all_cols, title = "ID"),
    arm_var = new_select_field(arm_var, all_cols, title = "ARM"),
    saffl_var = new_select_field(saffl_var, all_cols, title = "Safety Flag"),
    show_colcounts = new_switch_field(show_colcounts, title = "Show column counts"),
    prune_0 = new_switch_field(title = "Prune all zero rows")
  )

  expr <- quote({
    data <- droplevels(data)

    id_var <- get_column_default(data, .(id_var), "USUBJID")
    arm_var <- get_column_default(data, .(arm_var), "ARM")
    saffl_var <- get_column_default(data, .(saffl_var), "SAFFL")

    rtables <- cardinal::make_table_06(
      adae = data,
      show_colcounts = .(show_colcounts),
      arm_var = arm_var,
      id_var = id_var,
      saffl_var = saffl_var,
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
    class = c("cardinal06_block", "rtables_block", "submit_block")
  )
}
