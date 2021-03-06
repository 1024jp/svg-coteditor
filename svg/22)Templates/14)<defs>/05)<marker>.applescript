(* 

	insert <marker> tag

	
[version]	0.5α
[lastmod]	2012-02-25
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License

[note]	based on XHTML template script by nakamuxu 2005
*)

--
property beginStr : "\t<marker id=\"Marker\" orient=\"auto\" markerUnits=\"userSpaceOnUse\"\n\t        markerWidth=\"10\" markerHeight=\"10\" refX=\"5\" refY=\"5\">\n\t\t"
property endStr : "\n\t</marker>"
property preMargin : 0

--
tell application "CotEditor"
	if exists front document then
		set {loc, len} to range of selection of front document
		if (len = 0) then
			set newStr to beginStr & endStr
			if (preMargin = 0) then
				set numOfMove to count of character of beginStr
			else
				set numOfMove to preMargin
			end if
		else if (len > 0) then
			set curStr to contents of selection of front document
			set newStr to beginStr & curStr & endStr
			if (preMargin = 0) then
				set numOfMove to count of character of newStr
			else
				set numOfMove to preMargin
			end if
		else
			return
		end if
		set contents of selection of front document to newStr
		set range of selection of front document to {loc + numOfMove, 0}
	end if
end tell