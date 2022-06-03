# pip install --upgrade google-api-python-client google-auth-httplib2 \
# google-auth-oauthlib

from __future__ import print_function
import os.path
import sys
import datetime
from googleapiclient.discovery import build
from google.oauth2.credentials import Credentials

# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/calendar.events.readonly']


def main():
    """Shows basic usage of the Google Calendar API.
    Prints the start and name of the next 10 events on the user's calendar.
    """
    creds = None
    if os.path.exists('credentials.json'):
        creds = Credentials.from_authorized_user_file('credentials.json',
                                                      SCOPES)
    if not creds or not creds.valid:
        print('Please update your credentials by using auth.py')
        sys.exit()

    service = build('calendar', 'v3', credentials=creds)

    # Call the Calendar API
    page_token = None
    now = datetime.datetime.utcnow().isoformat() + 'Z'
    print(now)
    while True:
        events = service.events().list(calendarId='15mpi7772ls15hm1h1md73mlhc@group.calendar.google.com',
                                       pageToken=page_token,
                                       timeMin=now).execute()

        for event in events['items']:
            print(event['summary'], event['start'])
        page_token = events.get('nextPageToken')
        if not page_token:
            break


if __name__ == '__main__':
    main()
