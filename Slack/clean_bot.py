from silvestrini import *
from slack_cleaner2 import SlackCleaner
s = SlackCleaner(TOKEN, sleep_for=1)
for msg in s.c['auto-build'].msgs():
  if msg.bot:
    msg.delete()