 ui  <- ai_chat(title = 'Assistente DeepSeek',
   
   ai_chat_header(),
   ai_chat_main(sugest = suggestions(c('Diga olá!', 'Me ajude a fazer um resumo.','Quantas estrelas há no céu?', 'Qual o mais gostoso: caju ou cajá?'))),
   ai_chat_footer()
)