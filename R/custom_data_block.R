#' @import blockr falcon rtables
new_custom_data_block<- function(...){
  blockr::new_block(
    name = "boxplot scatter data",
    expr = quote({
      # n <- 350 # Sample size
      # BiomarkerX <- rnorm(n, mean = 50, sd = 20)
      # BiomarkerY <- 0.7 * BiomarkerX + rnorm(n, mean = 0, sd = 15)
      # data.frame(BiomarkerX, BiomarkerY)
      adsl <- random.cdisc.data::cadsl
      data <- falcon::make_table_02(
        df = adsl,
        vars = c("SEX", "AGE", "RACE"),
        lbl_vars = c("Sex", "Age, years", "Race")
      )
    }),
    fields = list(),
    class = c("custom_block", "rtables_block", "transform_block")
  )
}

#' @param data Result from previous block
#' @rdname evaluate_block
#' @export
evaluate_block.transform_block <- function(x, data, ...) {
  stopifnot(...length() == 0L)
  browser()
  eval(
    substitute(data %>% expr, list(expr = generate_code(x))),
    list(data = data)
  )
}