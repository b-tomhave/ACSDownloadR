#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  inputGeography <- mod_geography_selections_server("geography_selections_1")

  observe({
    print(inputGeography)
    # print(inputGeography$states)
    # print(inputGeography$counties)
  })

  mod_map_selections_server("map_selections_1", inputGeography)

}
