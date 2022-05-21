#' geography_selections UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import data.table
mod_geography_selections_ui <- function(id){
  ns <- NS(id)
  tagList(

    # List of State Choices
    # Sourced from From Pre-loaded Package fipsCodes Dataset in data-raw/tigrisData
    shinyWidgets::pickerInput(
      ns("states"),
      label = "1) Select State(s)",
      choices = unique(fipsCodes$state_name),
      options = list(
        title = "Nothing Selected"
      ),
      multiple = TRUE
    ),

    # List of County Choices Based on State Input
    shinyWidgets::pickerInput(
      ns("counties"),
      label = "2) Select Counties",
      choices = NULL,
      options = list(
        title = "Nothing Selected"
      ),
      multiple = TRUE
    )
  )
}

#' geography_selections Server Functions
#'
#' @noRd
mod_geography_selections_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Populate Reactive Input Values
    inputValues <- reactiveValues()

    observe({
      inputValues$states <- input$states

      # If Input State(s) selected, subset possible counties
      if (!is.null(input$states)){
        countySubset <- fipsCodes[state_name %in% input$states]

        # Choices should show as county name grouped by state but internally return county code to avoid erros when same county in multiple states (i.e. Washington county)
        countyChoicesGrouped <- split(setNames(countySubset$county_code,countySubset$county),
                                      countySubset$state_name)
      }else{
        countyChoicesGrouped <- ''
      }

      # Update County UI Choices
      shinyWidgets::updatePickerInput(
        session = session,
        inputId = "counties",
        choices = countyChoicesGrouped
      )
      })

    # Update Counties Input If Change
    observe({
      inputValues$counties <- input$counties
    })

    return(inputValues)

  })
  }

## To be copied in the UI
# mod_geography_selections_ui("geography_selections_1")

## To be copied in the server
# mod_geography_selections_server("geography_selections_1")
