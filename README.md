# EMail Validation Fail

Proof of concept for displaying dynamic data on a static page using:

- A [trello](https://trello.com) board as data source
- A [form submission API](https://usebasin.com) to upload new content to the trello board
- A [zapier](https://zapier.com) zap for creating the card on the trello board after form submission
- Trigger [travis-ci](https://travis-ci.com) rebuild of the site after trello board was updated

and **not using**:

- JavaScript
