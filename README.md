# IntelliShare

## How to run IntelliShare App in R studio

1. Clone this repo in r studio working directory and install all necessary packages in all .R files. 
2. Then open the runApp.R file and hit the green Run App button. 
3. Supply the directory name which contains the app (3702SA1Team9 if you did not rename the folder). 
4. Wait for the app to load on your machine (takes up to a few minutes) and start exploring IntelliShare!

## Below is the original README from the app gallery, Intelligentsia, note that the edition of keyring.R is NOT required to run IntelliShare

### Prerequisites

This shinyapp is using the `geocode()` function in the R package `ggmap`. In order for this to work on your computer, you will need to create an account on Google Cloud Platform and generate an API key to Google's Geocoding API.

Additionally, you will need to create a file keyring.R and store the register your key for Google's Geocoding API like so:

```{r eval = FALSE}
googleKey <- "your-API-key"
register_google(key = googleKey) #register for ggmap
```

This script is called by server.R