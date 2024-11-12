import sys, json
from urllib import request, error

"""
This script is used to upload new analyses to the server through an http API.
An API-key is required to prevent unauthorized access.
"""

def upload(json_analyse, filename):
  print(f'Uploading "{json_analyse["name"]}" from {filename}... ')
 
 
  req = request.Request(
    'https://web-oppdaterte-analyser.azurewebsites.net/api/',
    data=json.dumps(json_analyse).encode('utf-8'),
    headers={
      "Content-Type": "application/json",
      "Authorization": "SECRET-API-KEY"
    }
  )
 
  def print_response(response):
    print(f"Status code: {response.status} ({response.reason}).")
    print("Server:", json.loads(response.read().decode('utf-8'))["reply"])
 
  try:
    with request.urlopen(req) as response:
      print_response(response)
  except error.HTTPError as e:
    print_response(e.file)
 
if __name__ == "__main__":
  for filename in sys.argv[1:]:
    with open(filename, encoding="utf-8") as file:
      upload(json.loads(file.read()), filename)