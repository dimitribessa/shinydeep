server <- function(input, output, session){

    feed_chat <- reactiveVal(list())

    deepseek_output <- eventReactive(input$input_sendbtn,{
                            send_request <- feed_chat()
                            send_request[[length(send_request) + 1]] <- list('role' = 'user', 'content' = input$input_text)
                            feed_chat(send_request)
                            func_deepseek_request(send_request)
                            })

    observeEvent(input$input_sendbtn, {
        session$sendCustomMessage("update_response", list(text = deepseek_output()))
        received_request <- feed_chat()
        received_request[[length(received_request) + 1]] <- list('role' = 'user', 'content' = deepseek_output())
                            feed_chat(received_request)
    })

    observeEvent(input$input_newbtn, {
        session$reload()
        })
}