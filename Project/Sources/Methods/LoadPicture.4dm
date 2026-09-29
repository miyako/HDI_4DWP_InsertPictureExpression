//%attributes = {"invisible":true}

#DECLARE($pictName : Text)->$picture : Picture

var $path : Text

If (Count parameters:C259=0)
	$pictName:="Flush.png"
End if 

$path:=Get 4D folder:C485(Current resources folder:K5:16)+"Pictures"+Folder separator:K24:12+$pictName
If (Test path name:C476($path)=Is a document:K24:1)
	If (Is picture file:C1113($path))
		READ PICTURE FILE:C678($path; $picture)
	End if 
End if 
