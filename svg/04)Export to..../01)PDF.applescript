(*

	Convert SVG into PDF using wkpdf


[description]	
	Convert current SVG document on CoEditor into PDF

[version]	0.6
[lastmod]	2012-12-22
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License
	
[required]	wkpdf <http://plessl.github.com/wkpdf/>
*)

-- __settings_______________________________________________________________

-- show dialog when script couldn't run
property showAlertDialog : true


-- __advanced settings________________________________________________________

-- extension of svg file
property svgExtension : ".svg"

-- extension of output file
property outExtension : ".pdf"


-- __main_______________________________________________________________

-- get file path from CotEditor
tell application "CotEditor"
	set thePath to ""
	if exists front document then
		set thePath to path of front document as Unicode text
	else
		return
	end if
end tell

-- end script if no file path is specified
if thePath is "" then
	if showAlertDialog then
		beep
		display alert "No file path is specified." message "Please save the document first." & return & return & "script failed" as warning
	end if
	
	return
end if

-- show alert when the file has not .svg extension
if thePath does not end with svgExtension then
	-- get the extension of the current document
	tell application "Finder"
		set theFileInfo to info for thePath as POSIX file
		set theExtension to name extension of theFileInfo
	end tell
	
	-- alert
	beep
	try
		display alert "The document would not be a SVG file." message "SVG file names should end in the extension \"" & svgExtension & "\", but actually it ends with \"." & theExtension & "\".\n\nDo you really want to continue?" as warning buttons {"Cancel", "Continue"} default button "Cancel" cancel button "Cancel"
	on error
		return
	end try
end if



-- get the file name and its directory
set dirPath to do shell script "dirname " & quoted form of thePath
set FileName to do shell script "basename " & quoted form of thePath
if FileName ends with svgExtension then
	set FileName to text 1 thru -((count of svgExtension) + 1) of FileName as text
end if


-- "Save As" dialog
try
	set savePath to choose file name with prompt "" default name FileName & outExtension default location dirPath
on error
	-- cansel
	return
end try


-- convert savePath to UNIX style
set savePath to POSIX path of savePath


-- check file extension
set extensionHidden to false
if savePath does not end with outExtension then
	set savePath to savePath & outExtension
	set extensionHidden to true
end if


-- make pdf
do shell script "wkpdf --no-paginate --source " & thePath & " --output " & savePath


-- hide extension
if extensionHidden then
	tell application "Finder"
		set extension hidden of file (savePath as POSIX file) to true
	end tell
end if
