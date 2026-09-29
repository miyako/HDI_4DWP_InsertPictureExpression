Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222($_Methods; 0)
		APPEND TO ARRAY:C911($_Methods; "TimestampPicture")  // this method has to be allowed !
		SET ALLOWED METHODS:C805($_Methods)
		
		READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"Pictures"+Folder separator:K24:12+"Flush.png"; vPicture)
		
		WParea:=WP New:C1317
		
End case 