package
{
	import com.clink.events.UserSharedObjectEvent;
	import com.clink.managers.Manager_remoteUserSharedObject;
	
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	public class Final_Project_Clink extends Sprite
	{
		private var _nc:NetConnection
		private var _serverUserID:int
		
		private var _appURL:String;
		private var _username:String;
		
		private var _testManager:Manager_remoteUserSharedObject
		
		public function Final_Project_Clink()
		{
			_appURL = "rtmp://localhost/Clink_ServerSideApp";
			_username = "Adam";
			
			testInit();
		}
		
		private function testInit():void
		{
			_nc = new NetConnection();
			_nc.client = this;
			_nc.connect(_appURL,_username);
			_nc.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
		}
		
		public function setUserId(value:*):void
		{
			trace("Your user ID is:  "+value);
			_serverUserID = value;
			
			var template:Object = new Object();
			template = {name:"Adam", gender:"Male", age:26, dog:"Adley", mousePos:{x:234,y:876}};
			
			_testManager = new Manager_remoteUserSharedObject(_nc,_serverUserID,"testSO",template);
			_testManager.addEventListener(UserSharedObjectEvent.CONNECTED,onConnected);
			//trace("list of properties: " +_testManager.propertyList);
			
		}
		
		private function onConnected(e:UserSharedObjectEvent):void
		{
			_testManager.setProperty("dog", "zack");
		}
		
		
		/////////////////////////////////////////////////////////
		public function onBWDone():void
		{
			
		}
		
		private function netStatusHandler(e:NetStatusEvent):void
		{
			trace(e.info.code);
			if(e.info.code == "NetConnection.Connect.Success")
			{
				//setUpApplication();
			}
			
			if(e.info.code == "NetConnection.Connect.Failed")
			{
				trace("connection failed!!");
			}
		}
	}
}