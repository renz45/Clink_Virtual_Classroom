package com.clink.valueObjects
{
	import flash.net.NetConnection;

	public class VO_Settings
	{
		//basic button colors
		public var basicButton_isGradient:Boolean;
		public var basicButton_upStateColor:String;
		public var basicButton_downStateColor:String;
		public var basicButton_overStateColor:String;
		
		//scrollbar styles
		public var scrollBar_buttonColor:String;
		public var scrollBar_arrowColor:String;
		public var scrollBar_trackColor:String;
		public var scrollBar_handleColor:String;
		
		//tooltip settings
		public var toolTip_bgColor:String;
		public var toolTip_textColor:String;
		public var toolTip_textSize:Number;
		public var toolTip_displayDelay:Number;
		
		//sideBar settings
		public var sideBar_BgColor:String;
		public var sideBar_isGradient:Boolean;
		public var sideBar_cornerRadius:Number;
		//videoMonitor
		public var videoMonitor_videoBg:String;
		public var videoMonitor_videoBufferTime:Number;
		public var videoMonitor_volumeTrackColor:String;
		public var videoMonitor_volumeTriangleColor:String;
		public var videoMonitor_volumeHandleColor:String;
		public var videoMonitor_micGain:Number;
		//user List
		public var userListButton_isGradient:Boolean;
		public var userListButton_upStateColor:String;
		public var userListButton_downStateColor:String;
		public var userListButton_overStateColor:String;
		
		public var userList_backgroundColor:String;
		public var userList_backgroundIsGradient:Boolean;
		public var userList_headerColor:String;
		public var userList_headerIsGradient:Boolean;
		public var userList_headerArrowColor:String;
		
		public var userList_scrollListBackgroundColor:String;
		//userListItem
		public var userListItem_backgroundColor:String;
		public var userListItem_textColor:String;
		public var userListItem_handRaisedColor:String;
		public var userListItem_thumbUpColor:String;
		public var userListItem_thumbDownColor:String;
		public var userListItem_laughColor:String;
		public var userListItem_isGradient:Boolean;
		
		//general settings
		public var appURL:String;
		public var classId:String;
		public var username:String;
		public var userPermission:String;
		public var userID:Number;
		
		public var netConnection:NetConnection;
		
		//buttons
		//videoMonitor Buttons
		public var cameraBtn_toolTip:String;
		public var cameraBtn_upIcon:String;
		public var cameraBtn_downIcon:String;
		public var cameraBtn_overIcon:String;
		
		public var micBtn_toolTip:String;
		public var micBtn_upIcon:String;
		public var micBtn_downIcon:String;
		public var micBtn_overIcon:String;
		
		public var volumeBtn_toolTip:String;
		public var volumeBtn_upIcon:String;
		public var volumeBtn_downIcon:String;
		public var volumeBtn_overIcon:String;
		
		public var pushToTalkBtn_toolTip:String;
		public var pushToTalkBtn_upIcon:String;
		public var pushToTalkBtn_downIcon:String;
		public var pushToTalkBtn_overIcon:String;
		
		//userList
		public var raiseHandBtn_toolTip:String
		public var raiseHandBtn_upIcon:String
		public var raiseHandBtn_downIcon:String
		public var raiseHandBtn_overIcon:String
		
		public var thumbUpBtn_toolTip:String
		public var thumbUpBtn_upIcon:String
		public var thumbUpBtn_downIcon:String
		public var thumbUpBtn_overIcon:String
		
		public var thumbDownBtn_toolTip:String
		public var thumbDownBtn_upIcon:String
		public var thumbDownBtn_downIcon:String
		public var thumbDownBtn_overIcon:String
		
		public var laughBtn_toolTip:String
		public var laughBtn_upIcon:String
		public var laughBtn_downIcon:String
		public var laughBtn_overIcon:String
		
		public var awayBtn_toolTip:String
		public var awayBtn_upIcon:String
		public var awayBtn_downIcon:String
		public var awayBtn_overIcon:String
		
		public function VO_Settings()
		{
		}
	}
}