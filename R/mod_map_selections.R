#' map_selections UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import leaflet
#' @import sf
mod_map_selections_ui <- function(id){
  ns <- NS(id)
  tagList(
    leafletOutput(ns("countyMap")),
  )
}

#' map_selections Server Functions
#'
#' @noRd
mod_map_selections_server <- function(id, inputGeography){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    output$countyMap <- renderLeaflet({
      leaflet() %>%
        addProviderTiles(providers$Stamen.TonerLite,
                         options = providerTileOptions(noWrap = TRUE)
        )
    })

      observe({
        if(!is.null(inputGeography$states)){

          bbox <- st_bbox(usCounties_2020[usCounties_2020$STATE_NAME %in% inputGeography$states, ]) %>%
            as.vector()



          leafletProxy("countyMap", data = usCounties_2020[usCounties_2020$STATE_NAME %in% inputGeography$states, ]) %>%
            clearShapes() %>%
            fitBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>%
            addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                        opacity = 1.0, fillOpacity = 0.5,
                        fillColor = "gre",
                        label=~NAMELSAD,
                        highlightOptions = highlightOptions(color = "white", weight = 2,
                                                            bringToFront = TRUE))
        }else{
          # If no states selected zoom to center of map and clear layers
          leafletProxy("countyMap") %>%
            clearShapes() %>%
            setView(lng = -96.11985152014068,
                    lat = 40.021119257811385,
                    zoom = 4)
        }

      })

  })
}

## To be copied in the UI
# mod_map_selections_ui("map_selections_1")

## To be copied in the server
# mod_map_selections_server("map_selections_1")
