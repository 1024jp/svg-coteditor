(*

	Open in Chrome


[description]
	open current document on CotEditor in Chrome

[version]	1.0
[lastmod]	2013-12-12
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License
*)

-- __settings_______________________________________________________________

-- show dialog when script couldn't run
property showAlertDialog : true

-- browser
property browser : application "Google Chrome"


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


-- open document in terget browser
tell browser to open location "file://" & my encodeURI(thePath)


-- __subroutines____________________________________________________________

on encodeURI(theURI)
	return do shell script "ruby -e \"require 'uri'; print URI.encode(" & quoted form of theURI & ")\""
end encodeURI
