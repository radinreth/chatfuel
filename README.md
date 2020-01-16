chatfuel-rails is a small rails app communicate with [chatfuel](https://chatfuel.com/)
to build interactive chatbot.

## How it works?

1. First, user communicate with chatbot in facebook page
2. Chatfuel will collect info (user's attributes) that user input and send to our rails app , in this case __chatfuel-rails__
3. __chatfuel-rails__ grabs those attributes through rails params, then, process result and response to chatfuel via JSON
4. It is possible to redirect to blocks dynamically, base on app logic.


## Plugins

- _set user attribute_ : use to capture value that user answer in messager.
- _json api_ : use to send request, unidirect flow from chatfuel to rails app
- _redirect to blocks_ : redirect user to specific block in design flow

## For more defail,

- [Chatfuel doc](https://docs.chatfuel.com/en/)
