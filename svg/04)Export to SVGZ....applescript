(*

	Convert SVG into gzipped SVG (svgz)


[description]	
	Convert current SVG document on CoEditor into gzipped SVG

[version]	1.2
[lastmod]	2014-12-01
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License
*)

-- __settings_______________________________________________________________

-- show dialog when script couldn't run
property showAlertDialog : true


-- __advanced settings________________________________________________________

-- extension of svg file
property svgExtension : "svg"

-- extension of output file
property outExtension : "svgz"


-- __main_______________________________________________________________

-- get file path from CotEditor
tell application "CotEditor"
	if not (exists front document) then return
	
	set theFile to file of front document
end tell

-- end script if no file path is specified
if theFile is missing value then
	if showAlertDialog then
		beep
		display alert "No file path is specified." message "Please save the document first." & return & return & "script failed" as warning
	end if
	
	return
end if

-- show alert when the file has not .svg extension
set theExtension to name extension of (info for theFile)
if theExtension is not svgExtension then
	beep
	try
		display alert "The document would not be a SVG file." message "SVG file names should end in the extension \"" & svgExtension & "\", but actually it ends with \"." & theExtension & "\".\n\nDo you really want to continue?" as warning buttons {"Cancel", "Continue"} default button "Cancel" cancel button "Cancel"
	on error
		return
	end try
end if


-- get the file name and its directory
set fileName to name of (info for theFile)
if theExtension is svgExtension then
	set fileName to text 1 thru -((count of svgExtension) + 1) of fileName as text
end if


-- "Save As" dialog
try
	set savePath to choose file name with prompt "" default name fileName & outExtension default location theFile
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

-- make svgz
do shell script "gzip -c " & (quoted form of theFile's POSIX path) & " > " & (quoted form of savePath)

-- hide extension
if extensionHidden then
	tell application "Finder"
		set extension hidden of file (savePath as POSIX file) to true
	end tell
end if
