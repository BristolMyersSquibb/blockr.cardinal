#' @export
new_create_field <- function(value = character(), ...) {
  blockr::new_field(value, create = TRUE, class = "create_field")
}

#' @method validate_field create_field
#' @export
validate_field.create_field <- function(x) {
  NextMethod()
}
#' @method ui_input create_field
#' @export
ui_input.create_field <- function(x, id, name) {
  selectizeInput(
    input_ids(x, id),
    name,
    NULL,
    options = list(
      create = TRUE,
      maxItems = 99999,
      dropdownParent = "body",
      placeholder = "Create your options"
    )
  )
}
#' @method ui_update create_field
#' @export
ui_update.create_field <- function(x, session, id, name) {

}
