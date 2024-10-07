# PS-Filelisting-to-HTML

This PowerShell script will create an HTML list of all files in a folder. It will generate an HTML file titled "FileList.html". This is based of a similar function that the now defunct Winamp program offered.

Right now, it is in a very basic functioning state but I have plans to continue developing it. Hopefully you find it of use!

## Usage

### Index a directory and create an HTML list in the current directory:
```
FileList-to-HTML.ps1
```
### Index a directory and create an HTML list, but put the HTML file in a different folder:
```
FileList-to-HTML.ps1 -o X:\path\to\somefolder
```
### Recursively index a directory and create an HTML list in the current directory:
```
FileList-to-HTML.ps1 -r
```
### Recursively index a directory and create an HTML file, but put the HTML file in a different folder:
```
FileList-to-HTML.ps1 -r -o X:\path\to\somefolder
```
### View help
```
FileList-to-HTML.ps1 -help
```
