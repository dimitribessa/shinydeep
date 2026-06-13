// Send button click
var cont = 0;
$(document).on('click', '#sendBtn',  function(event) {
        var texto = $('#chatInput').val();
        Shiny.setInputValue('input_text',texto);
        Shiny.setInputValue('input_sendbtn',cont++);  
         if (chatInput.value.trim() && !isLoading) {
    sendMessageUser(chatInput.value.trim()); 
    }      
      });

//keydown text input
$(document).on('keydown', '#chatInput',  function(event) {
  if (event.key === 'Enter' && !event.shiftKey) {
    event.preventDefault();
    var texto = $('#chatInput').val();
        Shiny.setInputValue('input_text',texto);
        Shiny.setInputValue('input_sendbtn',cont++);  
    if (this.value.trim() && !isLoading) {
      sendMessageUser(texto.trim());
    }
  }
});