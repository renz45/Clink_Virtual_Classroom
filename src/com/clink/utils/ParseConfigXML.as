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
			var imgPath:String = (xml.@iconPath).toString();
			//basic button config
			vos.basicButton_isGradient = xml.ui.basicButton.isGradient as Boolean;
			vos.basicButton_upStateColor = xml.ui.basicButton.upStateColor;
			vos.basicButton_downStateColor = xml.ui.basicButton.downStateColor;
			vos.basicButton_overStateColor = xml.ui.basicButton.overStateColor;
			vos.basicButton_labelColor = xml.ui.basicButton.labelColor;
			
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
				vos.userListItem_awayColor = xml.ui.sideBar.userListItem.awayColor;
				vos.userListItem_isGradient = xml.ui.sideBar.userListItem.isGradient;
				vos.userListItem_talkingIcon = imgPath + (xml.ui.sideBar.userListItem.talkingIcon).toString();
				vos.userListItem_emoteTextColor = xml.ui.sideBar.userListItem.emoteTextColor;
				//textChat
				vos.textChat_backgroundColor = xml.ui.sideBar.textChat.backgroundColor;
				vos.textChat_textColor = xml.ui.sideBar.textChat.textColor;
				vos.textChat_usernameChatLabelColor = xml.ui.sideBar.textChat.usernameChatLabelColor;
				vos.textChat_urlLinkColor = xml.ui.sideBar.textChat.urlLinkColor;
				vos.textChat_welcomeMessage = xml.ui.sideBar.textChat.welcomeMessage;
				vos.textChat_welcomeUsername = xml.ui.sideBar.textChat.welcomeUsername;
				vos.textChat_textSize = xml.ui.sideBar.textChat.textSize;
				vos.textChat_usernameTextSize = xml.ui.sideBar.textChat.usernameTextSize;
			
			//Red5 Server Path
			vos.appURL = xml.settings.appURL;
			vos.modulePath = (xml.@modulePath).toString();
			
			//class Id
			vos.classId = xml.settings.classroomId;
			
			
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
					
					case "presenter":
						vos.presenterBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.presenterBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.presenterBtn_toolTip = b.toolTip;
						break;
					
					case "mute":
						vos.muteBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.muteBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.muteBtn_toolTip = b.toolTip;
						break;
					
					case "boot":
						vos.bootBtn_upIcon = imgPath + (b.icons.up).toString();
						vos.bootBtn_downIcon = imgPath + (b.icons.down).toString();
						vos.bootBtn_toolTip = b.toolTip;
						break;
				}
			}
					
			return vos;
		}
	}
}