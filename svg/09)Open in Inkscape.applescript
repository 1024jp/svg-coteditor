(*
	
	Open SVG in Inkscape


[description]	
	open current SVG document on CotEditor in Inkscape

[version]	1.2
[lastmod] 2014-12-01
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License
*)

-- __settings_______________________________________________________________

-- show dialog when script couldn't run
property showAlertDialog : true


-- __main_______________________________________________________________

-- get file path from CotEditor
tell application "CotEditor"
	if not (exists front document) then return
	
	set theFile to file of front document
	set syntax to coloring style of front document
end tell

-- end script if no file path is specified
if theFile is missing value then
	if showAlertDialog then
		beep
		display alert "No file path is specified." message "Please save the document first." & return & return & "script failed" as warning
	end if
	
	return
end if

-- end script when file has not .svg extension
if syntax is not "SVG" then
	if showAlertDialog then
		beep
		display alert "The current document might not be a SVG file." message "The file name must end with \"" & svgExtension & "\".\n\nscript failed" as warning
	end if
	
	return
end if

-- open file in Inkscape
tell application "Inkscape" to open theFile
