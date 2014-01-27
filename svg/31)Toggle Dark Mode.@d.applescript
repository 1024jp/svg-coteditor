(*
	
	Toggle Dark Mode


[description]	
	toggle Dark Mode of the frontmost document in Gappin

[version]	1.0
[lastmod]	2014-01-27
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License

[default key assign] 	command + D
*)


-- __main_______________________________________________________________

tell application "Gapplin"
	if exists front window then
		tell front window to set dark mode to (not dark mode)
	end if
end tell
