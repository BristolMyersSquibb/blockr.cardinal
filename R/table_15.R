#' @import blockr cardinal rtables
#' @export
new_cardinal15_block <- function(
  ...,
  id_var = character(),
  arm_var = character(),
  saffl_var = character(),
  fmqsc_var = character(),
  fmqnam_var = character(),
  fmq_scope = "NARROW",
  pref_var = character(),
  sex_scope = character(),
  na_level = "<Missing>",
  show_colcounts = TRUE,
  prune_0 = TRUE
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    id_var = new_select_field(id_var, all_cols, title = "ID"),
    arm_var = new_select_field(arm_var, all_cols, title = "ARM"),
    saffl_var = new_select_field(saffl_var, all_cols, title = "ARM"),
    fmqsc_var = new_select_field(fmqsc_var, all_cols, title = "FMQSC"),
    fmqnam_var = new_select_field(fmqnam_var, all_cols, title = "FMQNAM"),
    pref_var = new_select_field(pref_var, all_cols, title = "PREF"),
    sex_scope = new_string_field(sex_scope, title = "Sex Scope"),
    na_level = new_string_field(na_level, title = "Explicit NA level"),
    show_colcounts = new_switch_field(show_colcounts, title = "Show column counts"),
    fmq_scope = new_select_field(fmq_scope, c("NARROW", "BROAD"), title = "FMQ Scope"),
    prune_0 = new_switch_field(title = "Prune all zero rows")
  )

  expr <- quote({
    id_var <- get_column_default(data, .(id_var), "USUBJID")
    arm_var <- get_column_default(data, .(arm_var), "ARM")
    pref_var <- get_column_default(data, .(pref_var), "AEDECOD")
    saffl_var <- get_column_default(data, .(saffl_var), "SAFFL")
    fmqsc_var <- get_column_default(data, .(fmqsc_var), "FMQ01SC")
    fmqnam_var <- get_column_default(data, .(fmqnam_var), "FMQ01NAM")

    rtables <- cardinal::make_table_15(
      adae = data,
      arm_var = arm_var,
      show_colcounts = .(show_colcounts),
      saffl_var = saffl_var,
      id_var = id_var,
      sex_scope = .(sex_scope),
      pref_var = pref_var,
      fmq_scope = .(fmq_scope),
      fmqsc_var = fmqsc_var,
      fmqnam_var = fmqnam_var,
      na_level = .(na_level),
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
    class = c("cardinal15_block", "rtables_block", "submit_block")
  )
}
