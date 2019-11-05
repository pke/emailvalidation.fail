# https://trello.com/b/OSIlbRbJ/emailvalidationfail.json
curl "https://api.trello.com/1/lists/5dc01d21a74d223445930f94/cards?fields=name,desc,date,cover&attachments=true&actions=emailCard,cardCreate" > _data/fails.json
curl "https://api.trello.com/1/lists/5dc01d3f4893677b9434f1d1/cards?fields=name,desc,date,cover&attachments=true&actions=emailCard,cardCreate" > _data/unfails.json
