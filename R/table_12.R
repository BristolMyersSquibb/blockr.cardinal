#' @import blockr cardinal rtables
#' @export
new_cardinal12_block <- function(
  ...,
  id_var = character(),
  arm_var = character(),
  saffl_var = character(),
  pref_var = character(),
  show_colcounts = TRUE,
  prune_0 = TRUE
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    id_var = new_select_field(id_var, all_cols, title = "ID"),
    arm_var = new_select_field(arm_var, all_cols, title = "ARM"),
    saffl_var = new_select_field(saffl_var, all_cols, title = "ARM"),
    pref_var = new_select_field(pref_var, all_cols, title = "Pref"),
    show_colcounts = new_switch_field(show_colcounts, title = "Show column counts"),
    prune_0 = new_switch_field(title = "Prune all zero rows")
  )

  expr <- quote({
    data <- droplevels(data)

    id_var <- get_column_default(data, .(id_var), "USUBJID")
    arm_var <- get_column_default(data, .(arm_var), "ARM")
    saffl_var <- get_column_default(data, .(saffl_var), "SAFFL")
    pref_var <- get_column_default(data, .(pref_var), "AEDECOD")

    rtables <- cardinal::make_table_12(
      adae = data,
      arm_var = arm_var,
      saffl_var = saffl_var,
      id_var = id_var,
      pref_var = pref_var,
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
    class = c("cardinal09_block", "rtables_block", "submit_block")
  )
}
