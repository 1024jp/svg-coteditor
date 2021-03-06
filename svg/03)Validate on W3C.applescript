(*

	Validate on W3C


[description]
	validate current document on CotEditor using the W3C Markup Validation Service

[version]	1.2
[lastmod]	2014-12-01
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License

[note]
	documentation of the W3C Markup Validation
		http://validator.w3.org/docs/api.html
*)

-- __settings_______________________________________________________________

-- show dialog when script couldn't run
property showAlertDialog : true


-- __advanced settings________________________________________________________

-- validator URL
property validatorUrl : "http://validator.w3.org/check"

-- base URL for result HTML document
property baseUrl : "http://validator.w3.org/"


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


-- pre check
tell application "CotEditor"
	if not (find front document for "^[\\t ]*<" with RE) then
		try
			display alert "The document would not be written in markup language." message "Only markup documents can be validated." as warning buttons {"Cancel", "Continue"} cancel button "Cancel"
		on error
			return
		end try
	end if
end tell


-- set Mime Type
tell application "CotEditor" to set coloringSyntax to coloring style of front document
set theExtension to name extension of (info for theFile)
if theExtension is "svg" then
	set mimeType to "image/svg+xml" -- SVG
else if theExtension is "mml" then
	set mimeType to "application/mathml+xml" -- MathML
else if theExtension is "smil" or theExtension is "smi" then
	set mimeType to "application/smil" -- SMIL
else if coloringSyntax is "XML" then
	set mimeType to "application/xml" -- general XML
else
	set mimeType to "text/html" -- HTML
end if

-- set result file path
set tmpDir to system attribute "TMPDIR"
set resultPath to tmpDir & "validation_result.html"
set rawPath to tmpDir & "validation_result_raw.html"
set headerPath to tmpDir & "validation_header.html"

-- post file to W3C using curl and save the results at the temporary file
do shell script "curl --dump-header " & quoted form of headerPath & " -F 'uploaded_file=@" & quoted form of theFile's POSIX path & ";type=" & mimeType & "' " & validatorUrl & " > " & quoted form of rawPath


-- get simple result from HTTP header
try
	set theResult to do shell script "grep 'X-W3C-Validator-Status' " & headerPath
	
	set warningCount to do shell script "grep 'X-W3C-Validator-Warnings: ' " & headerPath
	set warningCount to text ((count of "X-W3C-Validator-Warnings") + 3) thru -1 of warningCount
	set errorCount to do shell script "grep 'X-W3C-Validator-Errors' " & headerPath
	set errorCount to text ((count of "X-W3C-Validator-Errors") + 3) thru -1 of errorCount
on error
	display alert "The W3C Vaidation Service returned no HTTP header results." message "Try later." as warning
	return
end try

-- get OS version only for emoji on Lion and later (ha ha
set osVersion to do shell script "sw_vers -productVersion"

-- create massage from HTTP header results
if theResult ends with "Invalid" then
	set theResult to "Your document is Invalid"
	if osVersion is greater than or equal to 10.7 then
		set theResult to theResult & " 😰"
	else
		set theResult to theResult & "."
	end if
	set theResult to theResult & return & return & ¬
		"Warnings: " & warningCount & return & ¬
		"Errors: " & errorCount
	
else if theResult ends with "Valid" then
	set theResult to "Your document is Valid"
	if osVersion is greater than or equal to 10.7 then
		set theResult to theResult & " 😃"
	else
		set theResult to theResult & "."
	end if
	if warningCount is not "0" then set theResult to theResult & return & return & ¬
		"Warnings: " & warningCount
	
else if theResult ends with "Abort" then
	display alert "W3C Markup Validator returned fatal error." message "Try later." as warning
	return
else
	return
end if

-- display simple result
display dialog theResult ¬
	with title "Results on the W3C Markup Validation Service" buttons {"Show Details", "OK"} default button "OK"


-- show details on browser
if button returned of result is "Show Details" then
	-- add base tag to result html
	set baseTag to "<base href=\"" & baseUrl & "\"/>" & return
	do shell script "head -5 " & quoted form of rawPath & " > " & quoted form of resultPath
	do shell script "echo " & quoted form of baseTag & ">> " & quoted form of resultPath
	do shell script "tail -n +6 " & quoted form of rawPath & " >> " & quoted form of resultPath
	
	-- open result page on browser
	try
		set defaultBrowserId to do shell script "export VERSIONER_PERL_PREFER_32_BIT=yes; " & ¬
			"perl -MMac::InternetConfig -le 'print +(substr((GetICHelper \"http\"), 0, 4))'"
		set defaultBrowser to application id defaultBrowserId
	on error
		set defaultBrowser to application "Safari"
	end try
	
	tell defaultBrowser to open location "file://" & resultPath
end if