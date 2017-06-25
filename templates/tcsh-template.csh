#! /bin/tcsh

foreach d ( $path )
	if (! -d $d ) then
		echo $d NOT DIRECTORY
	endif
end


#if (expr) then
#...
#else if (expr2) then
#...
#else
#...
#endif

#foreach name (wordlist)
#...
#end

#while (expr)
#...
#end

#switch (string)
#case str1:
#   ...
#   breaksw
#...
#default:
#   ...
#   breaksw
#endsw
