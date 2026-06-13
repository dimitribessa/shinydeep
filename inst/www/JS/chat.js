// DOM Elements
const chatMessages = document.getElementById('chatMessages');
const emptyState = document.getElementById('emptyState');
const chatInput = document.getElementById('chatInput');
const sendBtn = document.getElementById('sendBtn');
const newChatBtn = document.getElementById('newChatBtn');
const suggestionBtns = document.querySelectorAll('.suggestion-btn');



// State
let messages = [];
let isLoading = false;

// Auto-resize textarea
chatInput.addEventListener('input', function() {
  this.style.height = 'auto';
  this.style.height = Math.min(this.scrollHeight, 128) + 'px';
  sendBtn.disabled = !this.value.trim();
});


// New chat button
//newChatBtn.addEventListener('click', function() {
$(document).on('click', '#newChatBtn',  function() {
  Shiny.setInputValue('input_newbtn',cont++);
});

// Suggestion buttons
suggestionBtns.forEach(btn => {
  btn.addEventListener('click', function() {
    return sendMessageUser(this.textContent);
  });
});

suggestionBtns.forEach(btn => {
  btn.addEventListener('click', function() {
    Shiny.setInputValue('input_text',this.textContent);
    Shiny.setInputValue('input_sendbtn',cont++); 
  });
});

//message handler
Shiny.addCustomMessageHandler("update_response", function(message) {
      sendMessageAssist(message.text);    
    });

// Format time
function formatTime(date) {
  return date.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' });
}

// Create message element
function createMessageElement(message, isLoadingState = false) {
  const isUser = message.role === 'user';
  
  const messageDiv = document.createElement('div');
  messageDiv.className = `message ${message.role}`;
  
  const avatarIcon = isUser 
    ? '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" /></svg>'
    : '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9.75 3.104v5.714a2.25 2.25 0 01-.659 1.591L5 14.5M9.75 3.104c-.251.023-.501.05-.75.082m.75-.082a24.301 24.301 0 014.5 0m0 0v5.714c0 .597.237 1.17.659 1.591L19.8 15.3M14.25 3.104c.251.023.501.05.75.082M19.8 15.3l-1.57.393A9.065 9.065 0 0112 15a9.065 9.065 0 00-6.23-.693L5 14.5m14.8.8l1.402 1.402c1.232 1.232.65 3.318-1.067 3.611A48.309 48.309 0 0112 21c-2.773 0-5.491-.235-8.135-.687-1.718-.293-2.3-2.379-1.067-3.61L5 14.5" /></svg>';

  const bubbleContent = isLoadingState 
    ? '<div class="loading-dots"><span></span><span></span><span></span></div>'
    : message.content;

  messageDiv.innerHTML = `
    <div class="message-avatar">${avatarIcon}</div>
    <div class="message-content">
      <div class="message-bubble">${bubbleContent}</div>
      <span class="message-time">${formatTime(message.timestamp)}</span>
    </div>
  `;

  return messageDiv;
}

// Render messages
function renderMessages() {
  // Clear messages except empty state
  const existingMessages = chatMessages.querySelectorAll('.message');
  existingMessages.forEach(msg => msg.remove());
  
  // Show/hide empty state
  if (messages.length === 0) {
    emptyState.classList.remove('hidden');
  } else {
    emptyState.classList.add('hidden');
    messages.forEach(msg => {
      chatMessages.appendChild(createMessageElement(msg));
    });
  }
  
  // Scroll to bottom
  chatMessages.scrollTop = chatMessages.scrollHeight;
}

// Send message
function sendMessageUser(text) {
  // Add user message
  const userMessage = {
    role: 'user',
    content: text,
    timestamp: new Date()
  };
  messages.push(userMessage);
  
  // Clear input
  chatInput.value = '';
  chatInput.style.height = 'auto';
  sendBtn.disabled = true;
  
  // Render user message
  renderMessages();
  
}



async function sendMessageAssist(text) {
  // Show loading
  //isLoading = true;
  const loadingMessage = {
    role: 'assistant',
    content: '',
    timestamp: new Date()
  };
  const loadingElement = createMessageElement(loadingMessage, true);
  chatMessages.appendChild(loadingElement);
  chatMessages.scrollTop = chatMessages.scrollHeight;
  
  // Simulate API delay
  await new Promise(resolve => setTimeout(resolve, 1500));

  // Remove loading
  loadingElement.remove();
 
   // AI response
  
   const aiResponse = {
    role: 'assistant',
    content: text,
    timestamp: new Date()
  };
  messages.push(aiResponse);
  //isLoading = false;
  
  renderMessages();
}

// Initial render
renderMessages();
