 #' ai chat template

 #' Main layout tructure
 #' 
 #' @param title Title ilustrated on browser
 #' @import htmltools magrittr
 #' @export
 #' 
 ai_chat <- function(...,title = 'Chat IA - Assistente Inteligente'){
    head <- tags$head(
        suppressDependencies('bootstrap'),
        tags$meta(charset="UTF-8"),
        tags$meta(name="viewport" ,content="width=device-width, initial-scale=1.0"),
        tags$title(title),
       
        tags$link(href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css",
         rel="stylesheet",integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH", crossorigin="anonymous"),
        tags$link(rel="stylesheet", href="www/css/chat.css")
    )

    body <- tags$body(
                tags$div( class="chat-container d-flex flex-column mx-auto bg-white",
                ...),
                tags$link(src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js",
                 integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz",
                  crossorigin="anonymous")
                ,tags$script( src="www/JS/chat.js")
                 #' calling customs JS scripts
                ,tags$script( src="www/JS/chatInput.js")
    )
    tagList(head, body)
 }

 #' Pre build logo
 #' 
 #' @noRd
 #' 
 logo <- HTML('<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 002.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 00-2.456 2.456z" />
          </svg>')
 


 #' Header
 #' 
 #' @param logos a logo, on svg format
 #' @export
 #' 
 ai_chat_header <- function(logos = logo, title = 'Assistente de IA'){
    header <-tagList( tags$header(class="chat-header d-flex align-items-center justify-content-between px-4 py-3 border-bottom",
        tags$div(class = "d-flex align-items-center gap-3",
          tags$div(class="chat-logo d-flex align-items-center justify-content-center",
            logos
          )
        ,
        tags$div(class="chat-info",
        tags$h1(class="fw-bold mb-0", title))
      ),
        tags$button(class="new-chat-btn btn d-flex align-items-center gap-2" ,id="newChatBtn",
        HTML('<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
        </svg>'),
        'Nova conversa')
    ))
        header
 }
   
 
 #' Suggestions boxes
 #' 
 #' Description - function to generate suggestions boxes
 #' @export
 #' 
 suggestions <- function(sugs){
    sugestoes <- lapply(sugs, function(x){
        sprintf('<div class="col-12 col-sm-6">
            <button class="suggestion-btn btn w-100 h-100 text-start">%s</button>
          </div>', x) %>% HTML
    })
    tags$div(class="suggestions row g-3 w-100", sugestoes)
   
 }

 #' Main
 #' 
 #' @export
 #' 
 ai_chat_main <- function(texto1 = 'Como posso ajudar voce hoje?',
  texto2 = 'Sou seu assistente de IA. Posso ajudar com perguntas, escrever textos, explicar conceitos e muito mais.' ,logos = logo, sugest = NULL){
    sugestao <- sugest
    tags$main(class="chat-messages flex-grow-1 d-flex flex-column gap-4 p-4", id="chatMessages",
                tags$div(class="empty-state d-flex flex-column align-items-center justify-content-center text-center", id="emptyState",
                  tags$div(class="empty-state-icon d-flex align-items-center justify-content-center",
                logos)
                ,
                tags$h2(class="fw-bold mb-2",texto1),
                tags$p(class="text-secondary mb-4",texto2),
                sugestao
            )
            )
 }

#' Footer
#' 
#' Description - function with box message ui
#' @export
#' 
 ai_chat_footer <- function(){
  tags$footer(class="chat-input-area px-4 py-3 border-top",
              tags$div(class ="input-wrapper d-flex align-items-end gap-2 p-2",
                tags$textarea(class="chat-textarea flex-grow-1",
                              id="chatInput",
                              placeholder="Digite sua mensagem...",
                              rows="1")
                ,tags$div(class="input-actions d-flex align-items-center",
                  HTML('<button class="send-btn btn d-flex align-items-center justify-content-center" id="sendBtn" disabled>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M6 12L3.269 3.126A59.768 59.768 0 0121.485 12 59.77 59.77 0 013.27 20.876L5.999 12zm0 0h7.5" />
                    </svg>
                    </button>')
                )
             )
            ,tags$p(class="input-hint text-center text-secondary mt-2 mb-0", 'Pressione Enter para enviar, Shift+Enter para nova linha')
  ) #end div
 }