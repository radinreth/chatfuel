`chatfuel-rails` is a small rails app communicate with [chatfuel](https://chatfuel.com/)
to build interactive chatbot.

## How it works?

1. First, user communicate with chatbot in facebook page.
2. Chatfuel will collect info (user's attributes) that user input and send to our rails app, in this case __chatfuel-rails__.
3. __chatfuel-rails__ grabs those attributes through rails params, then, process result and response to chatfuel via JSON response.
4. It is possible to redirect to blocks dynamically, based on app logic.

## Plugins

- _set user attribute_ : use to capture value that user answer in messager.
- _json api_ : use to send request, unidirect flow from chatfuel to rails app.
- _redirect to blocks_ : redirect user to specific block in design flow.

## Challenge

- __re-engagement__
  - _story_: send remind static message to user if he/she does not complete questionnaire form.
  - _solution_: subscribe user to a sequence, then unsubscribe once finish.

- __advance re-engagement__
  - _story_: as a chat admin, the bot should follow up the user only question that he/she does not answer yet or not yet complete the current form.
  - _solution_: keep track for each question, redirect user to last block, which is where his/her question that not yet complete.

## For more detail

- [Chatfuel doc](https://docs.chatfuel.com/en/)
