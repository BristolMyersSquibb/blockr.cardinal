devtools::document()
pkgload::load_all()
library(shiny)
library(blockr)
library(blockr.pharmaverseadam)

new_dat_block <- function(
  data,
  ...
) {
  blockr::new_block(
    name = "Cheat data",
    expr = quote(.(data)),
    fields = list(
      data = new_hidden_field(data)
    ),
    ...,
    class = c("dat_block", "data_block")
  )
}

stack1 <- new_stack(
  new_random_cdisc_data_block,
  new_cardinal02_block,
  title = "Cardinal 02"
)

# cardinal 03
c3data <- random.cdisc.data::cadsl
c3data$RANDDT[sample(seq_len(nrow(c3data)), 100)] <- NA
fail_lvls <- c("criteria not met", "non-compliance", "consent withdrawn", "other")

c3data <- c3data |>
  dplyr::mutate(
    ENRLDT = RANDDT,
    SCRNFL = "Y",
    SCRNFRS = factor(sample(fail_lvls, nrow(c3data), replace = TRUE), levels = fail_lvls),
    SCRNFAILFL = ifelse(is.na(ENRLDT), "Y", "N")
  )
c3data$SCRNFRS[c3data$SCRNFL == "N" | !is.na(c3data$ENRLDT)] <- NA

stack3 <- new_stack(
  data = new_dat_block(data = c3data),
  table = new_cardinal03_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    scrnfl_var = "SCRNFL",
    scrnfailfl_var = "SCRNFAILFL",
    scrnfail_var = "SCRNFRS"
  ),
  title = "Cardinal 03"
)

# cardinal 04
c4data <- random.cdisc.data::cadsl %>%
  dplyr::mutate(test = rbinom(400, 1, 0.5)) %>%
  dplyr::mutate(
    RANDFL = ifelse(test == 0, "N", "Y"),
    PPROTFL = ifelse(test == 0, "N", "Y"),
    DCSREAS = dplyr::if_else(DCSREAS %in% c(
      "ADVERSE EVENT", "LACK OF EFFICACY", "PROTOCOL VIOLATION",
      "DEATH", "WITHDRAWAL BY PARENT/GUARDIAN"
    ), DCSREAS, "OTHER")
  ) %>%
  dplyr::mutate(DCTREAS = DCSREAS)

stack4 <- new_stack(
  data = new_dat_block(data = c4data),
  table = new_cardinal04_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    pop_vars = c("RANDFL", "ITTFL", "SAFFL", "PPROTFL"),
    lbl_pop_vars = c(
      "randomized", "ITT/mITT pop", "Safety pop", "Pre-protocol pop"
    )
  ),
  title = "Cardinal 04"
)

stack5 <- new_stack(
  new_random_cdisc_data_block,
  new_cardinal05_block,
  title = "Cardinal 05"
)

ui <- fluidPage(
  theme = bslib::bs_theme(5L),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack1)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack5)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack3)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack4)
    )
  )
)

server <- function(...){
  generate_server(stack1)
  generate_server(stack3)
  generate_server(stack4)
  generate_server(stack5)
}

shinyApp(ui, server)
