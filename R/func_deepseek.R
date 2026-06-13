 #' function to call deepseek connection
 #' 
 #' @param prompt a list following the deepseek format message role
 #' @param system providing a system prompt
 #' @param api_key deepseek api key
 #' @import httr jsonlite
 #' @return deepseek call output
 #' 
 func_deepseek_request <- function(prompt, system = "You are a helpful assistant.", api_key = Sys.getenv("DEEPSEEK_API_KEY")) {
   
    #' structuring the messages
    sistema <- list(role = 'system', content = system)
    mensagem <- append(list(sistema), prompt)

    # Prepare request body
    body <- list(
      model = 'deepseek-v4-flash',
      messages = mensagem,
      stream = F, #temporário
      temperature = 0.7,
      max_tokens = 10000
    )
    
    response <-  POST(
        "https://api.deepseek.com/chat/completions",
        add_headers(
          "Authorization" = paste("Bearer", api_key),
          "Content-Type" = "application/json"
        ),
        body = toJSON(body, auto_unbox = TRUE)
        , encode = 'json'
      )
      
    if(http_error(response)){
        return('Error')
    }
   content <- fromJSON(content(response, "text"))
   content <- content$choices$message$content
   content

}

 