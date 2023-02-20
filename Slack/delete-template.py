from slack_cleaner2 import *
token = "foobarbeer"
channel = "name-of-your-channel"
s = SlackCleaner(token)
for msg in s.msgs(filter(match(channel), s.conversations)):
  print(msg)
  # delete messages, its files, and all its replies (thread)
  # msg.delete(replies=True, files=True)