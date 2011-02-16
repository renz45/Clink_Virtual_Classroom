package com.clink.managers
{
	import com.clink.events.SharedObjectEvent;
	
	import flash.display.Sprite;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	public class Manager_remoteCommonSharedObject extends Sprite
	{
		private var _SO:SharedObject;
		
		private var _SOName:String;
		private var _template:Object;
		private var _isPersistent:Boolean;
		private var _nc:NetConnection;
		
		public function Manager_remoteCommonSharedObject(SOName:String,template:Object,nc:NetConnection, isPersistent:Boolean = false)
		{
			super();
			
			_SOName = SOName;
			_template = template;
			_isPersistent = isPersistent;
			_nc = nc;
			
			make()
		}
		
		//response function which handles the return value from the 'createUserBasedSO' function on the Red5 server
		private function soCreationResponder(msg:String):void
		{
			//output from the server, return msg
			trace(msg);
			
			//connect to the SO after it's created on the server side
			_SO = SharedObject.getRemote(_SOName,_nc.uri,false);
			_SO.addEventListener(SyncEvent.SYNC,OnSync);
			_SO.client = this;
			_SO.connect(_nc);
		}
		
		private function make():void
		{
			//create a new byteArray and write the template object to the byteArray
			var TemplateAMF:ByteArray = new ByteArray();
			TemplateAMF.writeObject(_template);
			
			//set up the responder function to handle any function returns
			var r:Responder = new Responder(soCreationResponder);

			//call the function 'createUserBasedSO' on the Red5 server
			_nc.call("createCommonSO", r, TemplateAMF, _SOName, _isPersistent);
		}
		
		private function OnSync(e:SyncEvent):void
		{
			for each(var i:Object in e.changeList)
			{
				//create a new userSharedObjectEvent to be used in the switch statements below
				var evt:SharedObjectEvent;
				switch(i.code)
				{
					//when another client changes the so
					case "change":	
						
						trace("so is changing " + i.name);
						break;
					
					//when this client changes the SO
					case "success":
						
						break;
					
					//when SO first connects successfully, dispatch a UserSharedObjectEvent.CONNECTED event
					case "clear":
						
						evt = new SharedObjectEvent(SharedObjectEvent.CONNECTED);
						this.dispatchEvent(evt);
						break;
					
					//when something gets deleted from the SO, dispatch UserSharedObjectEvent.DELETED with the deleted slot name
					case "delete":
						evt = new SharedObjectEvent(SharedObjectEvent.DELETED);
						evt.sharedObjectSlot = i.name;
						this.dispatchEvent(evt);
						break;
				}
			}
		}//end onSync
	}
}