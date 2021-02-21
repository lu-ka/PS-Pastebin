# PS-Pastebin

This powershell function uploads a message/code/text to pastebin.com. It uses the official Pastebin API for communication. I created this for antoher project of mine. 

# Features
You can submit a paste to pastebin.com and choose some options which include:
- Visibility (public, unlisted, private)
- Name/Title
- Expire date (self destruct feature)
- Format (for code; ex. "php")

# How To use
You can import the fuction or just use the script itself. Using the script goes as follows:

.\PS-Pastebin.ps1 -k "mydevkey" -u "myusername" -p "mypassword" -msg "Hello World!"

## Options:
-k Pastebin developer key (required, example "mydevkey")
-u Pastebin username (required, example "myusername")
-p Pastebin password (required, example "mypassword")
-msg code to paste (required, example "Hello World!")
-v paste visibility (optional, example "2")
-t paste name/title (optional, example "My first API paste")
-d paste expire date (optional, example "10M")
-f paste format (optional, example "php")

Your developer key can be found at https://pastebin.com/doc_api.
