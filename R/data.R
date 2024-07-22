#' @import blockr
#' @export
new_random_cdisc_data_block <- function(
  ...,
  selected = "cadsl"
) {
  blockr::new_block(
    name = "Random CDISC data block",
    expr = quote({
      do.call(
        "::",
        list(
          pkg = "random.cdisc.data",
          name = .(dataset)
        )
      )
    }),
    fields = list(
      dataset = blockr::new_select_field(
        selected,
        c(
          "cadab", "cadae", "cadaette", "cadcm", "caddv", "cadeg", "cadex",
          "cadhy", "cadlb", "cadmh", "cadpc", "cadpp", "cadqlqc", "cadqs",
          "cadrs", "cadsl", "cadsub", "cadtr", "cadtte", "cadvs", "radab",
          "radae", "radaette", "radcm", "raddv", "radeg", "radex", "radhy",
          "radlb", "radmh", "radpc", "radpp", "radqlqc", "radqs", "radrs",
          "radsaftte", "radsl", "radsub", "radtr", "radtte", "radvs", "rel_var",
          "replace_na", "rtexp", "rtpois"
        ),
        title = "Dataset"
      )
    ),
    ...,
    class = c("random_cdisc_block", "data_block")
  )
}
