# Õigusakt epub converter
This is a python script that converts XML files from [Riigiteataja](https://www.riigiteataja.ee/index.html) legal acts from XML to an epub format for use in E-readers.


# Installing
## Linux
Install [Õigusakt python library](https://github.com/KaarelP2rtel/oigusakt)  
`pip3 install https://github.com/KaarelP2rtel/oigusakt/releases/download/1.2.1/oigusakt_kaarelp2rtel-1.2.1-py3-none-any.whl`  
Install the converter  
`pip3 install https://github.com/KaarelP2rtel/epub-oigusakt/releases/download/1.2.0/epub_oigusakt_kaarelp2rtel-1.2.0-py3-none-any.whl`  
  
# Usage
The package is installed as a command, meaning that you can just use the command `epub-oigusakt`. The command takes one or more files as input and outputs the same filename as epub.  
  
Example:  
```epub-oigusakt relvaseadus.xml```  
Output:  
```
Converting /home/kaarel/relvaseadus.xml  
Finished  /home/kaarel/relvaseadus.epub  
```


