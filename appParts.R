#   ____________________________________________________________________________
#   Carpark Browser                                                    ####

neighborhoodDescription <- function() {
    tagList(
        div(class = "container",
            h1("Carpark Browser: Provided for Your Customers", class = "title fit-h1"),
            p("Interested to find out nearest available carparks? Use this map-based browser to checkout the availability of carparks near your place."),
            p("Use the Longitude and Latitude Inputs to center the map at your place. Don't your coordinates ? Simply google 'my map coordinates' !"),
            p("Use the slider to show only k available carparks around to avoid conflicts with others."),
            sidebarLayout(
              sidebarPanel(
                       numericInput("lon", label = h3("Enter longitude of your location"), value = 34.79399507628829),
                       numericInput("lat", label = h3("Enter latitude of your location"), value = 32.08886188641638),
                       sliderInput("topK",label = h3("Show nearest k carparks"),
                                   min = 50, 
                                   max = 500, value = 200),
                       radioButtons(inputId = "mapFormat",label="View Format",
                                    choices = c("Point","Heatmap","Cluster"))),
              mainPanel(
                       leafletOutput("map", height = 600)
                       )
        )
    ))
}


#   ____________________________________________________________________________
#   Location Comparison                                                     ####

legend <- "<div class='legend-custom'>
               <div class='legend-group'>
                   <div class='legend-element-label' color='location'></div>
                   <div class='legend-element-name'>Property</div>
               </div>
               <div class='legend-group'>
                   <div class='legend-element-label' color='yelp'></div>
                   <div class='legend-element-name'>Yelp</div>
               </div>
               <div class='legend-group'>
                   <div class='legend-element-label' color='schools'></div>
                   <div class='legend-element-name'>Schools</div>
               </div>
           </div>"
