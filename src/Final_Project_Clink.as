package
{
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
			
			var testManager:Manager_remoteUserSharedObject = new Manager_remoteUserSharedObject(_nc,_serverUserID,"testSO",template);
			
			
			var template2:Object = new Object();
			template = {color:"blue", toy:"Transformers", day:19, dog:"aussie", mousePos:{x:234,y:876}};
			
			var testManager2:Manager_remoteUserSharedObject = new Manager_remoteUserSharedObject(_nc,_serverUserID,"testSO2",template2);
			
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