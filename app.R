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

# cardinal 2
stack2 <- new_stack(
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

# cardianal 05
stack5 <- new_stack(
  new_random_cdisc_data_block,
  new_cardinal05_block,
  title = "Cardinal 05"
)

# cardinal 06
stack6 <- new_stack(
  data = new_random_cdisc_data_block(selected = "cadae"),
  table = new_cardinal06_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    saffl_var = "SAFFL"
  ),
  title = "Cardinal 06"
)

# cardinal 07
stack7 <- new_stack(
  data = new_random_cdisc_data_block(selected = "cadae"),
  table = new_cardinal07_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    na_level = "MISSING"
  ),
  title = "Cardinal 07"
)

# cardinal 09
stack9 <- new_stack(
  data = new_random_cdisc_data_block(selected = "cadae"),
  table = new_cardinal09_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    pref_var = "AEDECOD"
  ),
  title = "Cardinal 09"
)

# cardinal 10
c10data <- random.cdisc.data::cadae |>
  dplyr::rename(FMQ01SC = SMQ01SC) |>
  dplyr::mutate(
    AESER = sample(c("Y", "N"), size = nrow(random.cdisc.data::cadae), replace = TRUE),
    FMQ01NAM = sample(
      c("FMQ1", "FMQ2", "FMQ3"), size = nrow(random.cdisc.data::cadae), replace = TRUE
    )
  )

c10data$FMQ01SC[is.na(c10data$FMQ01SC)] <- "NARROW"

stack10 <- new_stack(
  data = new_dat_block(data = c10data),
  table = new_cardinal10_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    fmqsc_var = "FMQ01SC",
    fmqnam_var = "FMQ01NAM",
    fmq_scope = "NARROW",
    na_level = "<Missing>"
  ),
  title = "Cardinal 10"
)

# cardinal 11
c11data <- random.cdisc.data::cadae |>
  dplyr::rename(FMQ01SC = SMQ01SC) |>
  dplyr::mutate(
    AESER = sample(c("Y", "N"), size = nrow(random.cdisc.data::cadae), replace = TRUE),
    FMQ01NAM = sample(
      c("FMQ1", "FMQ2", "FMQ3"),
      size = nrow(random.cdisc.data::cadae), replace = TRUE
    )
  )

c11data$DCSREAS[is.na(c11data$DCSREAS)] <- "ADVERSE EVENTS"
c11data$FMQ01SC[is.na(c11data$FMQ01SC)] <- "NARROW"

stack11 <- new_stack(
  data = new_dat_block(data = c11data),
  table = new_cardinal11_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    fmqsc_var = "FMQ01SC",
    fmqnam_var = "FMQ01NAM",
    fmq_scope = "NARROW",
    na_level = "<Missing>"
  ),
  title = "Cardinal 11"
)

c12data <- random.cdisc.data::cadae
c12data$DCSREAS[is.na(c12data$DCSREAS)] <- "ADVERSE EVENT"

# cardinal 12
stack12 <- new_stack(
  data = new_dat_block(data = c12data),
  table = new_cardinal12_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    pref_var = "AEDECOD"
  ),
  title = "Cardinal 12"
)

# cardinal 13
stack13 <- new_stack(
  data = new_random_cdisc_data_block(selected = "cadae"),
  table = new_cardinal13_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    pref_var = "AEDECOD"
  ),
  title = "Cardinal 13"
)

# cardinal 14
c14data <- random.cdisc.data::cadae |>
  dplyr::rename(FMQ01SC = SMQ01SC, FMQ01NAM = SMQ01NAM)
levels(c14data$FMQ01SC) <- c("BROAD", "NARROW")
c14data$FMQ01SC[is.na(c14data$FMQ01SC)] <- "NARROW"

stack14 <- new_stack(
  data = new_dat_block(data = c14data),
  table = new_cardinal14_block(
    arm_var = "ARM",
    soc_var = "AEBODSYS",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    pref_var = "AEDECOD"
  ),
  title = "Cardinal 14"
)

# cardinal 15
c15data <- random.cdisc.data::cadae
c15data <- dplyr::rename(c15data, FMQ01SC = SMQ01SC, FMQ01NAM = SMQ01NAM)
levels(c15data$FMQ01SC) <- c("BROAD", "NARROW")
c15data$FMQ01SC[is.na(c15data$FMQ01SC)] <- "NARROW"
c15data$FMQ01NAM <- factor(
  c15data$FMQ01NAM,
  levels = c(unique(c15data$FMQ01NAM), "Erectile Dysfunction", "Gynecomastia")
)
c15data$FMQ01NAM[c15data$SEX == "M"] <- as.factor(
  sample(c("Erectile Dysfunction", "Gynecomastia"), sum(c15data$SEX == "M"), replace = TRUE)
)

stack15 <- new_stack(
  data = new_dat_block(data = c15data),
  table = new_cardinal15_block(
    arm_var = "ARM",
    soc_var = "AEBODSYS",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    pref_var = "AEDECOD",
    sex_scope = "M",
    fmq_scope = "NARROW",
    fmqsc_var = "FMQ01SC",
    fmqnam_var = "FMQ01NAM"
  ),
  title = "Cardinal 15"
)

# cardinal 16
c16data <- random.cdisc.data::cadae
c16data <- dplyr::rename(c16data, FMQ01SC = SMQ01SC, FMQ01NAM = SMQ01NAM)
levels(c16data$FMQ01SC) <- c("BROAD", "NARROW")
c16data$FMQ01SC[is.na(c16data$FMQ01SC)] <- "NARROW"
c16data$FMQ01NAM <- factor(
  c16data$FMQ01NAM,
  levels = c(unique(c16data$FMQ01NAM), "Erectile Dysfunction", "Gynecomastia")
)
c16data$FMQ01NAM[c16data$SEX == "M"] <- as.factor(
  sample(c("Erectile Dysfunction", "Gynecomastia"), sum(c16data$SEX == "M"), replace = TRUE)
)

stack16 <- new_stack(
  data = new_dat_block(data = c16data),
  table = new_cardinal16_block(
    arm_var = "ARM",
    soc_var = "AEBODSYS",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    pref_var = "AEDECOD",
    sex_scope = "M",
    fmq_scope = "BROAD",
    fmqsc_var = "FMQ01SC",
    fmqnam_var = "FMQ01NAM"
  ),
  title = "Cardinal 16"
)

# cardinal 17
c17data <- dplyr::rename(random.cdisc.data::cadae, FMQ01SC = SMQ01SC, FMQ01NAM = SMQ01NAM)
levels(c17data$FMQ01SC) <- c("BROAD", "NARROW")
c17data$FMQ01SC[is.na(c17data$FMQ01SC)] <- "NARROW"
c17data$FMQ01NAM <- factor(c17data$FMQ01NAM, levels = c(
  unique(c17data$FMQ01NAM), "Abnormal Uterine Bleeding", "Amenorrhea",
  "Bacterial Vaginosis", "Decreased Menstrual Bleeding"
))
c17data$FMQ01NAM[c17data$SEX == "F"] <- as.factor(
  sample(c(
    "Abnormal Uterine Bleeding", "Amenorrhea",
    "Bacterial Vaginosis", "Decreased Menstrual Bleeding"
  ), sum(c17data$SEX == "F"), replace = TRUE)
)

stack17 <- new_stack(
  data = new_dat_block(data = c17data),
  table = new_cardinal17_block(
    arm_var = "ARM",
    soc_var = "AEBODSYS",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    pref_var = "AEDECOD",
    sex_scope = "F",
    fmq_scope = "BROAD",
    fmqsc_var = "FMQ01SC",
    fmqnam_var = "FMQ01NAM"
  ),
  title = "Cardinal 17"
)

# cardinal 18
c18data <- dplyr::rename(random.cdisc.data::cadae, FMQ01SC = SMQ01SC, FMQ01NAM = SMQ01NAM)
levels(c14data$FMQ01SC) <- c("BROAD", "NARROW")
c18data$FMQ01SC[is.na(c18data$FMQ01SC)] <- "NARROW"
c18data$FMQ01NAM <- factor(c18data$FMQ01NAM, levels = c(
  unique(c18data$FMQ01NAM), "Abnormal Uterine Bleeding", "Amenorrhea",
  "Bacterial Vaginosis", "Decreased Menstrual Bleeding"
))
c18data$FMQ01NAM[c18data$SEX == "F"] <- as.factor(
  sample(c(
    "Abnormal Uterine Bleeding", "Amenorrhea",
    "Bacterial Vaginosis", "Decreased Menstrual Bleeding"
  ), sum(c18data$SEX == "F"), replace = TRUE)
)

stack18 <- new_stack(
  data = new_dat_block(data = c17data),
  table = new_cardinal18_block(
    arm_var = "ARM",
    soc_var = "AEBODSYS",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    pref_var = "AEDECOD",
    sex_scope = "F",
    fmq_scope = "BROAD",
    fmqsc_var = "FMQ01SC",
    fmqnam_var = "FMQ01NAM"
  ),
  title = "Cardinal 18"
)

# cardinal 20
c20data <- random.cdisc.data::cadae
c20data$AESIFL <- ifelse(c20data$AESOC %in% c("cl A", "cl D"), "Y", "N")
c20data$AELABFL <- sample(c("Y", "N"), nrow(c20data), replace = TRUE)

stack20 <- new_stack(
  data = new_dat_block(data = c20data),
  table = new_cardinal20_block(
    arm_var = "ARM",
    soc_var = "AEBODSYS",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    pref_var = "AEDECOD",
    aesifl_var = "AESIFL",
    aelabfl_var = "AELABFL"
  ),
  title = "Cardinal 20"
)

# cardinal 21
c21adsl <- random.cdisc.data::cadsl %>%
  dplyr::mutate(AGEGR1 = as.factor(dplyr::case_when(
    AGE >= 17 & AGE < 65 ~ ">=17 to <65",
    AGE >= 65 ~ ">=65",
    AGE >= 65 & AGE < 75 ~ ">=65 to <75",
    AGE >= 75 ~ ">=75"
  )) %>% formatters::with_label("Age Group, years")) %>%
  formatters::var_relabel(
    AGE = "Age, years"
  )

c21adae <- random.cdisc.data::cadae
c21adae$ASER <- c21adae$AESER

c21data <- dplyr::left_join(
  c21adsl,
  c21adae,
  by = intersect(names(c21adsl), names(c21adae))
)

stack21 <- new_stack(
  data = new_dat_block(data = c21data),
  table = new_cardinal21_block(
    arm_var = "ARM",
    soc_var = "AEBODSYS",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    vars = c("SEX", "AGEGR1", "RACE", "ETHNIC"),
    denom = c("N_s", "N_col", "n")
  ),
  title = "Cardinal 21"
)

# cardinal 22
c22adsl <- random.cdisc.data::cadsl %>%
  dplyr::mutate(AGEGR1 = as.factor(dplyr::case_when(
    AGE >= 17 & AGE < 65 ~ ">=17 to <65",
    AGE >= 65 ~ ">=65",
    AGE >= 65 & AGE < 75 ~ ">=65 to <75",
    AGE >= 75 ~ ">=75"
  )) %>% formatters::with_label("Age Group, years")) %>%
  formatters::var_relabel(
    AGE = "Age, years"
  )

c22adae <- random.cdisc.data::cadae
c22adae$ASER <- c22adae$AESER

c22data <- dplyr::left_join(
  c22adsl,
  c22adae,
  by = intersect(names(c22adsl), names(c22adae))
)

stack22 <- new_stack(
  data = new_dat_block(data = c22data),
  table = new_cardinal22_block(
    arm_var = "ARM",
    soc_var = "AEBODSYS",
    id_var = "USUBJID",
    saffl_var = "SAFFL",
    vars = c("SEX", "AGEGR1", "RACE", "ETHNIC"),
    denom = c("N_s", "N_col", "n")
  ),
  title = "Cardinal 22"
)

# cardinal 32
stack32 <- new_stack(
  data = new_random_cdisc_data_block(selected = "cadvs"),
  table = new_cardinal32_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    saffl_var = "SAFFL"
  ),
  title = "Cardinal 32"
)

# cardinal 33
c33data <- random.cdisc.data::cadvs
c33data$AVAL <- c33data$AVAL - 100

stack33 <- new_stack(
  data = new_dat_block(data = c33data),
  table = new_cardinal33_block(
    arm_var = "ARM",
    id_var = "USUBJID",
    saffl_var = "SAFFL"
  ),
  title = "Cardinal 33"
)

ui <- fluidPage(
  theme = bslib::bs_theme(5L),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack2)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack3)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack4)
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
      generate_ui(stack6)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack7)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
    ),
    div(
      class = "col-md-6",
      generate_ui(stack9)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack10)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack11)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack12)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack13)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack14)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack15)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack16)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack17)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack18)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack20)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack21)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack22)
    )
  ),
  div(
    class = "row",
    div(
      class = "col-md-6",
      generate_ui(stack32)
    ),
    div(
      class = "col-md-6",
      generate_ui(stack33)
    )
  )
)

server <- function(...){
  generate_server(stack2)
  generate_server(stack3)
  generate_server(stack4)
  generate_server(stack5)
  generate_server(stack6)
  generate_server(stack7)

  generate_server(stack9)
  generate_server(stack10)
  generate_server(stack11)
  generate_server(stack12)
  generate_server(stack13)
  generate_server(stack14)
  generate_server(stack15)
  generate_server(stack16)
  generate_server(stack17)
  generate_server(stack18)
  generate_server(stack20)
  generate_server(stack21)
  generate_server(stack22)
  generate_server(stack32)
  generate_server(stack33)
}

shinyApp(ui, server)
