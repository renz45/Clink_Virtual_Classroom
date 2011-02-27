package com.clink.utils
{
	import com.clink.valueObjects.VO_Settings;

	public class ParseConfigXML
	{
		public function ParseConfigXML()
		{
			
		}
		
		public static function parseConfig(xml:XML):VO_Settings
		{
			var vos:VO_Settings = new VO_Settings();
			
			//basic button config
			vos.basicButton_isGradient = xml.ui.basicButton.isGradient as Boolean;
			vos.basicButton_upStateColor = xml.ui.basicButton.upStateColor;
			vos.basicButton_downStateColor = xml.ui.basicButton.downStateColor;
			vos.basicButton_overStateColor = xml.ui.basicButton.overStateColor;
			
			//scrollBar config
			vos.scrollBar_buttonColor = xml.ui.scrollBar.buttonColor;
			vos.scrollBar_arrowColor = xml.ui.scrollBar.arrowColor;
			vos.scrollBar_trackColor = xml.ui.scrollBar.trackColor;
			vos.scrollBar_handleColor = xml.ui.scrollBar.handleColor;
			
			//toolTip config
			vos.toolTip_bgColor = xml.ui.toolTip.bgColor;
			vos.toolTip_textColor = xml.ui.toolTip.textColor;
			vos.toolTip_textSize = xml.ui.toolTip.textSize;
			vos.toolTip_displayDelay = xml.ui.toolTip.displayDelay;
			
			//sideBar config
			vos.sideBar_BgColor = xml.ui.sideBar.bgColor;
			vos.sideBar_isGradient = xml.ui.sideBar.isGradient;
			vos.sideBar_cornerRadius = xml.ui.sideBar.cornerRadius;
			vos.sideBar_videoBg = (xml.@skinImagesPath).toString() + (xml.ui.sideBar.videoBg).toString();
			vos.sideBar_videoBufferTime = xml.ui.sideBar.videoBufferTime;
			vos.sideBar_volumeTrackColor = xml.ui.sideBar.volumeTrackColor;
			vos.sideBar_volumeTriangleColor = xml.ui.sideBar.volumeTriangleColor;
			vos.sideBar_volumeHandleColor = xml.ui.sideBar.volumeHandleColor;
			vos.sideBar_micGain = xml.ui.sideBar.micGain;
			
			vos.appURL = xml.settings.appURL;
			
			var imgPath:String = (xml.@iconPath).toString();
			//button icon config
			for each(var b:XML in xml.buttons.button)
			{
				switch((b.name).toString())
				{
					case "cameraToggle":
						vos.cameraBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.cameraBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.cameraBtn_overIcon = imgPath + (b.icons.over).toString();
						vos.cameraBtn_toolTip = b.toolTip;
						break;
					
					case "micToggle":
						vos.micBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.micBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.micBtn_overIcon = imgPath + (b.icons.over).toString();
						vos.micBtn_toolTip = b.toolTip;
						break;
					
					case "volume":
						vos.volumeBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.volumeBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.volumeBtn_overIcon = imgPath + (b.icons.over).toString();
						vos.volumeBtn_toolTip = b.toolTip;
						break;
					
					case "pushToTalk":
						vos.pushToTalkBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.pushToTalkBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.pushToTalkBtn_overIcon = imgPath + (b.icons.over).toString();
						vos.pushToTalkBtn_toolTip = b.toolTip;
						break;
				}
			}
					
			return vos;
		}
	}
}