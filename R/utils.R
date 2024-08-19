get_column_default <- function(data, column, default = 1L) {
  if(length(column) > 0)
    return(column)

  if(is.numeric(default))
    return(names(data)[default])

  return(default)
}
