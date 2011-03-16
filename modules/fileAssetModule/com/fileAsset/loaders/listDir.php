<?php
if ($handle = opendir($_GET['path'])) {
	$fileList = array();
    while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != "..") {
            array_push($fileList, $file);
        }
    }
    
    echo implode("##",$fileList);
    closedir($handle);
}
?>
