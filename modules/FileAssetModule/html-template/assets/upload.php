<?php
	$name = basename( $_FILES['Filedata']['name']);
	
	if (move_uploaded_file($_FILES['Filedata']['tmp_name'], $_GET['path'].$name))
	{
	     echo "Upload Successful";
	}else{
	     echo "There was an error uploading the file to the webserver";
	}
?>
