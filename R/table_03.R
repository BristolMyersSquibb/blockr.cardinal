#' @import blockr cardinal rtables
#' @export
new_cardinal03_block <- function(
  ...,
  id_var = character(),
  arm_var = character(),
  scrnfl_var = character(),
  scrnfail_var = character(),
  scrnfailfl_var = character(),
  show_colcounts = FALSE,
  prune_0 = TRUE
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    id_var = new_select_field(id_var, all_cols, title = "ID"),
    arm_var = new_select_field(arm_var, all_cols, title = "ARM"),
    scrnfl_var = new_select_field(scrnfl_var, all_cols, title = "Screening flag"),
    scrnfailfl_var = new_select_field(scrnfailfl_var, all_cols, title = "Screening fail"),
    scrnfail_var = new_select_field(scrnfail_var, all_cols, title = "Screening fail reason"),
    show_colcounts = new_switch_field(show_colcounts, title = "Show column counts"),
    prune_0 = new_switch_field(title = "Prune all zero rows")
  )

  expr <- quote({
    data <- droplevels(data)

    id_var <- get_column_default(data, .(id_var), "USUBJID")
    arm_var <- get_column_default(data, .(arm_var), "ARM")

    rtables <- cardinal::make_table_03(
      df = data,
      show_colcounts = .(show_colcounts),
      arm_var = arm_var,
      id_var = id_var,
      scrnfl_var = .(scrnfl_var),
      scrnfailfl_var = .(scrnfailfl_var),
      scrnfail_var = .(scrnfail_var),
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
    class = c("cardinal03_block", "rtables_block", "submit_block")
  )
}
