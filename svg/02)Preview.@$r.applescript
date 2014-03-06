(*
	
	Preview (Open SVG in Gapplin)


[description]	
	open current SVG document on CotEditor in Gapplin

[version]	1.1.1
[lastmod]	2014-03-06
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License
*)

-- __settings_______________________________________________________________

-- show dialog when script couldn't run
property showAlertDialog : true

-- name of syntax mode
property syntaxName : "SVG"

-- whether position Gapplin window next to CotEditor window
property adjustsWindowPosition : true


-- __advanced settings________________________________________________________

-- extension of svg file
property svgExtension : ".svg"

-- margin between CotEditor document and preview window
property xPositionMargin : 15 -- px
property yPositionMargin : 80 -- px


-- __main_______________________________________________________________

-- get file path from CotEditor
tell application "CotEditor"
	set thePath to ""
	if exists front document then
		set thePath to path of front document
	else
		return
	end if
end tell

-- end script if coloring mode is not in SVG
tell application "CotEditor"
	if coloring style of front document is not syntaxName then return
end tell

-- end script if no file path is specified
if thePath is "" then
	if showAlertDialog then
		beep
		display alert "No file path is specified." message "Please save the document first." & return & return & "script failed" as warning
	end if
	
	return
end if

-- end script if file doesn't have ".svg" extension
if thePath does not end with svgExtension then
	if showAlertDialog then
		beep
		display alert "The document would not be a SVG file." message "SVG file names should end in the extension \"" & svgExtension & "\"." & return & return & "script failed" as warning
	end if
	
	return
end if


-- open file in Gapplin
tell application "Gapplin"
	open POSIX file thePath as alias
	
	-- adjust window position
	if adjustsWindowPosition then
		tell application "CotEditor" to set cotPos to bounds of front window
		set xPos to (item 3 of cotPos) + xPositionMargin
		set yPos to (item 2 of cotPos) + yPositionMargin
		
		tell application "Finder" to set screenPos to bounds of window of desktop
		
		set gapplinPos to bounds of front window
		set width to (item 3 of gapplinPos) - (item 1 of gapplinPos)
		set height to (item 4 of gapplinPos) - (item 2 of gapplinPos)
		set gapplinPos to {xPos, yPos, xPos + width, yPos + height}
		
		if item 3 of gapplinPos is greater than item 3 of screenPos then
			set item 3 of gapplinPos to (item 3 of screenPos) - 10
			set item 1 of gapplinPos to (item 3 of screenPos) - width
		end if
		
		set bounds of window 1 to gapplinPos
	end if
end tell
