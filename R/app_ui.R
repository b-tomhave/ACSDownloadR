#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      h1("ACSDownloadR"),
      mod_geography_selections_ui("geography_selections_1"),
      mod_map_selections_ui("map_selections_1"),
      h4("Map Above")
    )
  )
}



# Display this message somewhere:
#"This product uses the Census Bureau Data API but is not endorsed or certified by the Census Bureau."

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "ACSDownloadR"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
