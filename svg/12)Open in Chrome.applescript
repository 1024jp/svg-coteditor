(*

	Open in Chrome


[description]
	open current document on CotEditor in Chrome

[version]	1.2
[lastmod] 2014-12-01
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


-- open document in terget browser
tell browser to open theFile
