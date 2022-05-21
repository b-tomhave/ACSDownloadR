#' map_selections UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_map_selections_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' map_selections Server Functions
#'
#' @noRd 
mod_map_selections_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_map_selections_ui("map_selections_1")
    
## To be copied in the server
# mod_map_selections_server("map_selections_1")
