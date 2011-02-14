package com.clink.managers
{
	import flash.display.Sprite;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.formats.FormatValue;
	
	public class Manager_remoteUserSharedObject extends Sprite
	{
		
		private var _nc:NetConnection;
		private var _SO:SharedObject;
		
		private var _SOTemplate:Object;
		private var _userID:int;
		private var _SOName:String;
		
		
		public function Manager_remoteUserSharedObject(nc:NetConnection, userID:int, SOName:String)
		{
			
			_nc = nc;
			_userID = userID;
			_SOName = SOName;
			
		}
		
		private function soCreationResponder(msg:String):void
		{
			//output from the server, return msg
			trace(msg);
			
			_SO = SharedObject.getRemote(_SOName,_nc.uri,false);
			_SO.addEventListener(SyncEvent.SYNC,OnSync);
			_SO.connect(_nc);
		}
		
		public function make(template:Object):void
		{
			trace(template);
			_SOTemplate = template;
			
			//create a new byteArray and write the template object to the byteArray
			var TemplateAMF:ByteArray = new ByteArray();
			TemplateAMF.writeObject(template);
			
			//set up the responder function to handle any function returns
			var r:Responder = new Responder(soCreationResponder);
			var userID:String = _userID.toString();
			
			//call the function 'createUserBasedSO' on the Red5 server
			_nc.call("createUserBasedSO", r, TemplateAMF, userID, _SOName);
			
		}
		
		
		private function OnSync(e:SyncEvent):void
		{
			for each(var i:Object in e.changeList)
			{
				
				switch(i.code)
				{
					//when another client changes the so
					case "change":
						//test.tf_output.text  = _drawingSO.data[i.name];
						trace("SO changing: "+i.name);
						
						break;
					//when this client changes the so
					case "success":
						//test.tf_output.text  = _drawingSO.data[i.name];
						trace("SO success: "+i.name);
						break;
					//when so first connects successfully
					case "clear":
						trace(" SO is connected")
						trace(_SO.data);
						break;
					//when something gets deleted from the so
					case "delete":
						trace(i.name +" in drawingSO was deleted!");
						break;
				}
			}
		}
		
	}
}