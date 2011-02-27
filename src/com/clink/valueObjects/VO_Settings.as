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
		public var sideBar_videoBg:String;
		public var sideBar_videoBufferTime:Number;
		public var sideBar_volumeTrackColor:String;
		public var sideBar_volumeTriangleColor:String;
		public var sideBar_volumeHandleColor:String;
		public var sideBar_micGain:Number;
		
		
		//general settings
		public var appURL:String;
		public var username:String;
		public var userPermission:String;
		public var userID:Number;
		
		public var netConnection:NetConnection;
		
		//buttons
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
		
		public function VO_Settings()
		{
		}
	}
}