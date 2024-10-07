# FileList-to-HTML.ps1
# Version 1.2
# Last updated 3/5/2019

# This PowerShell script will create an HTML list of all files in a folder. It will generate an HTML file titled "FileList.html"
# Right now, it is in a very basic functioning state but I have plans to continue developing it. Hopefully you find it of use!
# You may use the "-help" parameter to view practical usage examples.


param(
  [switch]$r,[string]$o,[switch]$help
)

# Help contents
function help {
  Write-Host ""
  Write-Host "FileList-to-HTML.ps1"
  Write-Host "Indexes files/folders and outputs a list of them to an HTML file."
  Write-Host ""
  Write-Host "- Index a directory and create an HTML list in the current directory:" -ForegroundColor Green
  Write-Host -ForegroundColor Magenta "  powershell.exe .\FileList-to-HTML.ps1 "
  Write-Host ""
  Write-Host "- Index a directory and create an HTML list, but put the HTML file in a different folder:" -ForegroundColor Green
  Write-Host -ForegroundColor Magenta "  powershell.exe .\FileList-to-HTML.ps1 " -NoNewline; "-o X:\path\to\somefolder"
  Write-Host ""
  Write-Host "- Recursively index a directory and create an HTML list in the current directory:" -ForegroundColor Green
  Write-Host -ForegroundColor Magenta "  powershell.exe .\FileList-to-HTML.ps1 " -NoNewline; "-r"
  Write-Host ""
  Write-Host "- Recursively index a directory and create an HTML file, but put the HTML file in a different folder:" -ForegroundColor Green
  Write-Host -ForegroundColor Magenta "  powershell.exe .\FileList-to-HTML.ps1 " -NoNewline; "-r -o X:\path\to\somefolder"
  Write-Host ""
  exit
}

# Variables 
$OutputFolder = $folder
$OutputFile = "FileList.html"

if ($help) { help }

if (!($help -or $r -or $o -or $args.Count -eq 0)) {
  throw "That is not a valid parameter. Please use the -help parameter for more information."
  exit }

#Initial prompt
Write-Host "FileList-to-HTML.ps1                            Version: [1.2]"
Write-Host ""
Write-Host "Indexes files/folders and outputs a list of them to an HTML file."
Write-Host ""
Write-Host "Please use the -help parameter to view more options."
Write-Host "---------------------------------------------------------------------------"
$folder = Read-Host "Enter the directory name of files to index (leave blank for current directory)"
if ($folder -eq "") { $OutputFolder = $pwd } else { $OutputFolder = $folder }

# More variables
$files = Get-ChildItem $folder -File | Select-Object -ExpandProperty Name
if ($r) { $files = Get-ChildItem $folder -File -Recurse | Select-Object -ExpandProperty Name }
if ($o) { $OutputFolder = $o }
$date = Get-Date -Format yyyy-MM-dd
$time = Get-Date -Format hh:mm

# The counter that will count each file.
$counter = 0
$files | ForEach-Object {
  $files[$counter] = "$($counter+1). $($files[$counter])<BR>`n"
  $counter++
  Write-Host "Indexing file...$counter"
}

# HTML file contents
$HTML = @"
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<!--
Generated with FileList-to-HTML.ps1. Get it at https://github.com/sbirdsill/PS-Filelisting-to-HTML
-->
<title>File list</title>
<style>
a {
    color: rgb(0,140,245);
    text-decoration: underline;
 
}
a:hover {
    color: rgb(0,90,160);
}
body {
    background-color: rgb(55,55,55);
    color: rgb(235,235,235);
    font-family: verdana;
       font-size: 10pt;
       overvlow:hidden;
       height:100%;
}
h1 {
    color: rgb(0,140,245);
}
h3 {
    color: rgb(0,140,245);
}
h5 {
    color: rgb(0,140,245);
}
</style>
</head>
<body>
<h1 >File list</h1>
<HR>
<h5>Number of files: $counter
<BR>
Right-click <a class="link" href="">here</a> to save this HTML file.</h5>
<h3>List of files:</h3>
<p>$files</p>
<HR>
<i><pre>Generated on $date $time</pre></i>
</body>
</html>
"@

# Create the HTML file.
Write-Host "Creating the HTML file..."
$HTML | Out-File $OutputFolder\$OutputFile

# Verify successful creation of the HTML file.
if (Test-Path -Path $OutputFolder\$OutputFile) {
  Write-Host -ForegroundColor Green "HTML file successfully created at '$OutputFolder\$OutputFile'!"
  Start $OutputFolder\$OutputFile
}
else {
  throw "File was not successfully created. Please check for any errors above."
}

exit
