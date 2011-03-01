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
				//videoMonitor
				vos.videoMonitor_videoBg = (xml.@skinImagesPath).toString() + (xml.ui.sideBar.videoMonitor.videoBg).toString();
				vos.videoMonitor_videoBufferTime = xml.ui.sideBar.videoMonitor.videoBufferTime;
				vos.videoMonitor_volumeTrackColor = xml.ui.sideBar.videoMonitor.volumeTrackColor;
				vos.videoMonitor_volumeTriangleColor = xml.ui.sideBar.videoMonitor.volumeTriangleColor;
				vos.videoMonitor_volumeHandleColor = xml.ui.sideBar.videoMonitor.volumeHandleColor;
				vos.videoMonitor_micGain = xml.ui.sideBar.videoMonitor.micGain;
				//userList
				vos.userListButton_isGradient = xml.ui.sideBar.userList.userListButton.isGradient;
				vos.userListButton_upStateColor = xml.ui.sideBar.userList.userListButton.upStateColor;
				vos.userListButton_downStateColor = xml.ui.sideBar.userList.userListButton.downStateColor;
				vos.userListButton_overStateColor = xml.ui.sideBar.userList.userListButton.overStateColor;
				
				vos.userList_backgroundColor = xml.ui.sideBar.userList.backgroundColor;
				vos.userList_backgroundIsGradient = xml.ui.sideBar.userList.backgroundIsGradient;
				
				vos.userList_headerColor = xml.ui.sideBar.userList.headerColor;
				vos.userList_headerIsGradient = xml.ui.sideBar.userList.headerIsGradient;
				vos.userList_headerArrowColor = xml.ui.sideBar.userList.headerArrowColor;
				
				vos.userList_scrollListBackgroundColor = xml.ui.sideBar.userList.scrollListBackgroundColor;
				//userListItem
				vos.userListItem_backgroundColor = xml.ui.sideBar.userListItem.backgroundColor;
				vos.userListItem_textColor = xml.ui.sideBar.userListItem.textColor;
				vos.userListItem_handRaisedColor = xml.ui.sideBar.userListItem.handRaisedColor;
				vos.userListItem_thumbUpColor = xml.ui.sideBar.userListItem.thumbUpColor;
				vos.userListItem_thumbDownColor = xml.ui.sideBar.userListItem.thumbDownColor;
				vos.userListItem_laughColor = xml.ui.sideBar.userListItem.laughColor;
				vos.userListItem_isGradient = xml.ui.sideBar.userListItem.isGradient;
				
			vos.appURL = xml.settings.appURL;
			
			var imgPath:String = (xml.@iconPath).toString();
			//button icon config
			for each(var b:XML in xml.buttons.button)
			{
				switch((b.name).toString())
				{
					//video monitor buttons
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
					//userList Buttons
					case "raiseHand":
						vos.raiseHandBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.raiseHandBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.raiseHandBtn_overIcon = imgPath + (b.icons.over).toString();
						vos.raiseHandBtn_toolTip = b.toolTip;
						break;
					
					case "thumbUp":
						vos.thumbUpBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.thumbUpBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.thumbUpBtn_overIcon = imgPath + (b.icons.over).toString();
						vos.thumbUpBtn_toolTip = b.toolTip;
						break;
					
					case "thumbDown":
						vos.thumbDownBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.thumbDownBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.thumbDownBtn_overIcon = imgPath + (b.icons.over).toString();
						vos.thumbDownBtn_toolTip = b.toolTip;
						break;
					
					case "laugh":
						vos.laughBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.laughBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.laughBtn_overIcon = imgPath + (b.icons.over).toString();
						vos.laughBtn_toolTip = b.toolTip;
						break;
					
					case "away":
						vos.awayBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.awayBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.awayBtn_overIcon = imgPath + (b.icons.over).toString();
						vos.awayBtn_toolTip = b.toolTip;
						break;
				}
			}
					
			return vos;
		}
	}
}