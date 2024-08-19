#' FDA Table 5: Duration of Treatment Exposure, Safety Population, Pooled Analyses
#'
#' @param id_var ARM.
#' @param arm_var ARM.
#' @param vars Variables.
#' @param scrnfl_var Screen flag.
#' @param scrnfailfl_var Screen fail flag.
#' @param show_colcounts Display counts.
#' @param purne_0 Prune zero rows.
#'
#' @import blockr cardinal rtables
#' @export
new_cardinal05_block <- function(
  show_colcounts = character(),
  arm_var = character(),
  id_var = character(),
  saffl_var = character(),
  trtsdtm_var = character(),
  trtedtm_var = character(),
  u_trtdur = "days",
  ...
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    colcounts = blockr::new_switch_field(show_colcounts, title = "Show column counts"),
    arm = blockr::new_select_field(arm_var, all_cols, title = "ARM treatment"),
    id = blockr::new_select_field(id_var, all_cols, title = "Subject ID"),
    saffl = blockr::new_select_field(saffl_var, all_cols, title = "Safety Flag"),
    trtsdtm = blockr::new_select_field(trtsdtm_var, all_cols, title = "Treatment start"),
    trtedtm = blockr::new_select_field(trtedtm_var, all_cols, title = "Treatment end"),
    u_trtdur = blockr::new_select_field(
      u_trtdur,
      c("days", "weeks", "months", "years"),
      title = "Treatment duration"
    )
  )
  blockr::new_block(
    expr = quote({
      data <- droplevels(data)

      id_var <- get_column_default(data, .(id), "USUBJID")
      arm_var <- get_column_default(data, .(arm), "ARM")
      saffl_var <- get_column_default(data, .(saffl), "SAFFL")
      trtedtm_var <- get_column_default(data, .(trtedtm), "TRTEDTM")
      trtsdtm_var <- get_column_default(data, .(trtsdtm), "TRTSDTM")

      rtables <- cardinal::make_table_05(
        df = data,
        show_colcounts = .(colcounts),
        saffl_var = saffl_var,
        id_var = id_var,
        arm_var = arm_var,
        trtsdtm_var = trtsdtm_var,
        trtedtm_var = trtedtm_var,
        u_trtdur = .(u_trtdur)
      )

      list(
        rtables = rtables
      )
    }),
    fields = fields,
    ...,
    class = c("cardinal05_block", "rtables_block")
  )
}

#' @export
layout.cardinal05_block <- function(x, fields, ...){
  div(
    div(
      class = "row",
      div(
        class = "col-md-2",
        fields$colcounts
      ),
      div(
        class = "col-md-3",
        fields$arm
      ),
      div(
        class = "col-md-3",
        fields$id
      ),
      div(
        class = "col-md-2",
        fields$saffl
      ),
      div(
        class = "col-md-2",
        fields$u_trtdur
      )
    ),
    div(
      class = "row",
      div(
        class = "col-md-3",
        fields$trtsdtm
      ),
      div(
        class = "col-md-3",
        fields$trtedtm
      )
    )
  )
}
