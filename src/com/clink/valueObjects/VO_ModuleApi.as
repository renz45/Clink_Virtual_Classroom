package com.clink.valueObjects
{
	import com.clink.main.TextChat;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	
	import flash.net.NetConnection;

	public class VO_ModuleApi
	{
		//sharedObjects from the sideBar
		public var chatSO:Manager_remoteCommonSharedObject;
		public var userSO:Manager_remoteUserSharedObject;
		
		//textChat object
		public var textChat:TextChat;
		
		//basic button styles
		public var basicButton_isGradient:Boolean;
		public var basicButton_upStateColor:String;
		public var basicButton_downStateColor:String;
		public var basicButton_overStateColor:String;
		public var basicButton_labelColor:String;
		
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
		
		//general settings
		public var appURL:String;
		public var classId:String;
		public var username:String;
		public var userPermission:String;
		public var userID:Number;
		public var modulePath:String;
		
		public var netConnection:NetConnection;
		
		public function VO_ModuleApi()
		{
		}
	}
}