#' map_overview UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_map_overview_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' map_overview Server Functions
#'
#' @noRd 
mod_map_overview_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_map_overview_ui("map_overview_1")
    
## To be copied in the server
# mod_map_overview_server("map_overview_1")
