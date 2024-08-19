#' FDA Table 2: Baseline Demographic and Clinical Characteristics, Safety Population, Pooled Analyses
#'
#' @param arm_var ARM.
#' @param vars Variables.
#' @param saffl_var Safety flag.
#'
#' @import blockr cardinal rtables
#' @export
new_cardinal02_block <- function(
  ...,
  arm_var = character(),
  vars = character(),
  saffl_var = character(),
  lbl_overall = "Total Population"
) {
  all_cols <- function(data) colnames(data)

  fields <- list(
    saffl_var = new_select_field(saffl_var, all_cols, title = "SAFFL"),
    arm_var = new_select_field(arm_var, all_cols, title = "ARM"),
    vars = new_select_field(vars, all_cols, multiple = TRUE, title = "Variables"),
    lbl_overall = new_string_field(lbl_overall, title = "Label Overall")
  )

  expr <- quote({
    vars <- get_column_default(data, .(vars), "SEX")
    arm_var <- get_column_default(data, .(arm_var), "ARM")
    saffl_var <- get_column_default(data, .(saffl_var), "SAFFL")

    rtables <- cardinal::make_table_02_tplyr(
      df = data,
      vars = vars,
      saffl_var = saffl_var,
      lbl_overall = .(lbl_overall)
    )

    gt <- cardinal::make_table_02_gtsum(
      df = data,
      vars = vars,
      saffl_var = saffl_var,
      lbl_overall = .(lbl_overall)
    )

    list(
      #rtables = rtables,
      gt = gt
    )
  })

  blockr::new_block(
    expr = expr,
    fields = fields,
    ...,
    class = c("cardinal02_block", "rtables_block", "submit_block")
  )
}
