#' variable_selections UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_variable_selections_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' variable_selections Server Functions
#'
#' @noRd 
mod_variable_selections_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_variable_selections_ui("variable_selections_1")
    
## To be copied in the server
# mod_variable_selections_server("variable_selections_1")
