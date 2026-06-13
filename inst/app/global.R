 #' loading libraries
 #' 
 library('magrittr')
 library('dplyr')
 library('shiny')
 library('httr')
 library('jsonlite')

 #' get Deeseek API key
 api_key <- Sys.getenv('DEEPSEEK_API_KEY')