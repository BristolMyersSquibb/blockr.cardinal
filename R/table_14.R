#' @import blockr cardinal rtables
#' @export
new_cardinal14_block <- function(
  ...,
  id_var = character(),
  arm_var = character(),
  soc_var = character(),
  saffl_var = character(),
  fmqsc_var = character(),
  fmqnam_var = character(),
  na_level = "<Missing>",
  show_colcounts = TRUE,
  prune_0 = TRUE
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    id_var = new_select_field(id_var, all_cols, title = "ID"),
    arm_var = new_select_field(arm_var, all_cols, title = "ARM"),
    soc_var = new_select_field(arm_var, all_cols, title = "SOC"),
    saffl_var = new_select_field(saffl_var, all_cols, title = "ARM"),
    fmqsc_var = new_select_field(fmqsc_var, all_cols, title = "FMQSC"),
    fmqnam_var = new_select_field(fmqnam_var, all_cols, title = "FMQNAM"),
    na_level = new_string_field(na_level, title = "Explicit NA level"),
    show_colcounts = new_switch_field(show_colcounts, title = "Show column counts"),
    prune_0 = new_switch_field(title = "Prune all zero rows")
  )

  expr <- quote({
    id_var <- get_column_default(data, .(id_var), "USUBJID")
    arm_var <- get_column_default(data, .(arm_var), "ARM")
    soc_var <- get_column_default(data, .(soc_var), "AEBODSYS")
    saffl_var <- get_column_default(data, .(saffl_var), "SAFFL")
    fmqsc_var <- get_column_default(data, .(fmqsc_var), "FMQ01SC")
    fmqnam_var <- get_column_default(data, .(fmqnam_var), "FMQ01NAM")

    rtables <- cardinal::make_table_14(
      adae = data,
      arm_var = arm_var,
      soc_var = soc_var,
      show_colcounts = .(show_colcounts),
      saffl_var = saffl_var,
      id_var = id_var,
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
    class = c("cardinal14_block", "rtables_block", "submit_block")
  )
}
