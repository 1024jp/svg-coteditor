(*
	
	Preview (Open SVG in Gapplin)


[description]	
	open current SVG document on CotEditor in Gapplin

[version]	1.0
[lastmod]	2013-12-11
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License
*)

-- __settings_______________________________________________________________

-- show dialog when script couldn't run
property showAlertDialog : true


-- __advanced settings________________________________________________________

-- extension of svg file
property svgExtension : ".svg"


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

-- end script when file has not .svg extension
if thePath does not end with svgExtension then
	if showAlertDialog then
		beep
		display alert "The current document might not be a SVG file." message "The file name must end with \"" & svgExtension & "\".\n\nscript failed" as warning
	end if
	
	return
end if


-- open file in Inkscape
do shell script "open -a /Applications/Gapplin.app/ " & quoted form of thePath