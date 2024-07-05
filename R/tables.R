#' @import blockr cardinal rtables
#' @export
new_falcon02_block <- function(
  ...,
  selected = character()
){
  all_cols <- function(data) colnames(data)

  fields <- list(
    columns = new_select_field(selected, all_cols, multiple = TRUE, title = "Columns")
  )

  expr <- quote({
    data <- droplevels(data)

    cols <- .(columns)

    if(length(cols) == 0)
      cols <- names(data)[1]

    rtables <- cardinal::make_table_02(
      df = data,
      vars = cols
    )

    gt <- cardinal::make_table_02_gtsum(
      df = data,
      vars = cols
    )

    list(
      rtables = rtables,
      gt = gt
    )
  })

  blockr::new_block(
    expr = expr,
    fields = fields,
    ...,
    class = c("falcon02_block", "rtables_block", "submit_block")
  )
}

#' @import blockr falcon rtables
#' @export
new_falcon05_block <- function(columns = character(), ...){
  all_cols <- function(data) colnames(data)

  fields <- list(
    colcounts = blockr::new_switch_field(TRUE, title = "Show column counts"),
    arm = blockr::new_select_field("ARM", all_cols, title = "ARM treatment"),
    id = blockr::new_select_field("USUBJID", all_cols, title = "Subject ID"),
    saffl = blockr::new_select_field("SAFFL", all_cols, title = "Safety Flag"),
    trtsdtm = blockr::new_select_field("TRTSDTM", all_cols, title = "Treatment start"),
    trtedtm = blockr::new_select_field("TRTEDTM", all_cols, title = "Treatment end"),
    u_trtdur = blockr::new_select_field(
      "days",
      c("days", "weeks", "months", "years"),
      title = "Treatment duration"
    )
  )

  blockr::new_block(
    expr = quote({
      rtables <- cardinal::make_table_05(
        df = data,
        show_colcounts = .(colcounts),
        saffl_var = .(saffl),
        id_var = .(id),
        arm_var = .(arm),
        trtsdtm_var = .(trtsdtm),
        trtedtm_var = .(trtedtm),
        u_trtdur = .(u_trtdur)
      )

      list(
        rtables = rtables
      )
    }),
    fields = fields,
    ...,
    class = c("falcon05_block", "rtables_block")
  )
}

#' @export
layout.falcon05_block <- function(x, fields, ...){
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
