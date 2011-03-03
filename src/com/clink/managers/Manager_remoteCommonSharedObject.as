package com.clink.managers
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.utils.VarUtils;
	
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	[Event(name="connected", type="com.clink.events.SharedObjectEvent")]
	[Event(name="changed", type="com.clink.events.SharedObjectEvent")]
	[Event(name="clientChanged", type="com.clink.events.SharedObjectEvent")]
	[Event(name="deleted", type="com.clink.events.SharedObjectEvent")]
	
	public class Manager_remoteCommonSharedObject extends Sprite
	{
		private var _SO:SharedObject;
		
		private var _SOName:String;
		private var _template:Object;
		private var _isPersistent:Boolean;
		private var _nc:NetConnection;
		
		private static var _soList:Array;
		private static var _classId:String;
		
		public function Manager_remoteCommonSharedObject(SOName:String,template:Object,nc:NetConnection, isPersistent:Boolean = false)
		{
			super();
			
			if(!_soList)
			{
				throw new Error("Please init this manager by calling the static function init()");
			}
			
			_SOName = SOName + _classId;
			_template = template;
			_isPersistent = isPersistent;
			_nc = nc;
			
			make()
		}
		
		//response function which handles the return value from the 'createUserBasedSO' function on the Red5 server
		private function soCreationResponder(msg:String):void
		{
			//output from the server, return msg
			trace("[Red5][Common SO] "+msg);
			
			//connect to the SO after it's created on the server side
			_SO = SharedObject.getRemote(_SOName,_nc.uri,false);
			_SO.addEventListener(SyncEvent.SYNC,OnSync);
			_SO.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onSOError);
			_SO.client = this;
			_SO.connect(_nc);
		}
		
		private function make():void
		{
			//add this so to a static object so we can reference the list
			if(_soList.indexOf(_SOName) == -1)
			{
				_soList.push(_SOName);
			}
			
			//create a new byteArray and write the template object to the byteArray
			var TemplateAMF:ByteArray = new ByteArray();
			TemplateAMF.writeObject(_template);
			
			//set up the responder function to handle any function returns
			var r:Responder = new Responder(soCreationResponder);

			//call the function 'createCommonSO' on the Red5 server
			_nc.call("createCommonSO", r, TemplateAMF, _SOName, _classId,_isPersistent);
		}
		
		private function onSOError(e:AsyncErrorEvent):void
		{
			trace("[Manager_remoteCommonSharedObject]["+_SOName+"][ERROR] " + e.error);
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
						evt = new SharedObjectEvent(SharedObjectEvent.CHANGED);
						evt.propertyName = i.name;
						evt.propertyValue = _SO.data[i.name];
						evt.sharedObjectSlot = i.name;
						this.dispatchEvent(evt);
						break;
					
					//when this client changes the SO
					case "success":
						evt = new SharedObjectEvent(SharedObjectEvent.CHANGED);
						evt.propertyName = i.name;
						evt.propertyValue = _SO.data[i.name];
						evt.sharedObjectSlot = i.name;
						this.dispatchEvent(evt);
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
		
		//responder function for setProperty Method
		private function commonSOChangeHandler(msg:String = ""):void
		{
			trace(msg);
		}
		
		///////////////////////////GETTERS/SETTERS/////////////////////////////////
		/**
		 * Getter for template object
		 *
		 * @return Object
		 */
		public function get template():Object
		{
			return _template;
		}
		
		/**
		 * Getter for the SharedObject 
		 *
		 * @return sharedObject
		 */
		public function get sharedObject():SharedObject
		{
			return _SO;
		}
		
		/**
		 * Getter for netConnection 
		 *
		 * @return NetConnection
		 */
		public function get netConnection():NetConnection
		{
			return _nc;
		}
		
		/**
		 * Getter for SharedObject Name 
		 *
		 * @return String
		 */
		public function get SOName():String
		{
			return _SOName;
		}
		
		/**
		 * Getter for property list, this returns a string with a list of comma seperated values with datatypes indicated of the properties of this shared object.
		 * ex. "dog[String], name[String], age[int]"
		 *
		 * @return int
		 */
		public function get propertyList():String
		{
			var propList:String = "";
			var count:int = 1;
			
			var objectTotal:int = 0;
			for(var key:String in _template)
			{
				objectTotal ++;
			}
			
			for(var prop:String in _template)
			{
				propList += prop;
				
				propList += "[" + VarUtils.getDataType(_template[prop]) + "]";
				
				if(count < objectTotal)
				{
					propList += ", ";
				}
				count++;
			}
			
			return propList;
			
		}
		
		//////////////////////////PUBLIC METHODS////////////////////////////////
		/**
		 * Gets the value of a property within the sharedObject. The userID is an optional param, if no userID is given than an object is returned where
		 * the keys are the userID's in the object. 
		 *
		 * @param property:String name of the property within the sharedObject to read
		 * @param userID:int (Optional) userID to look at to get the property from
		 * 
		 * @return Object
		 */
		public function getProperty(property:String):Object
		{
			var data:Object = _SO.data;
			for(var prop:String in data)
			{	
				if(prop == property)
				{
					return data[prop];
				}
			}
			
			throw new Error("A property with name: " + property + " does not exist within this sharedObject");
			
			return {};
		}
		
		/**
		 * SetProperty sets a property in the sharedObject to a given value. Since we can't create functions at runtime, I'm passing in properties and values
		 * seperately. I'm forcing a check on datatypes like a normal property so there aren't any errors in the values. 
		 *
		 * @param propertyName:String name of the property within the sharedObject to change
		 * @param propertyValue:* the value changed within the property
		 * 
		 * @return void
		 */
		public function setProperty(propertyName:String,propertyValue:*):void
		{
			var data:Object = _SO.data;
			var r:Responder = new Responder(commonSOChangeHandler);
			for(var prop:String in data)
			{	
				//if the property exists within the sharedObject
				if(prop == propertyName)
				{
					//if the datatype of the passed in propertyValue matches the property value existing within the sharedObject
					if(VarUtils.getDataType(propertyValue) == VarUtils.getDataType(data[prop]))
					{
						_nc.call("updateCommonSO",r,propertyName,propertyValue,_SOName,_classId);
						return
					}else{
						throw new Error("The data type of the value your trying to change isn't the expected: " + VarUtils.getDataType(data[prop]));
					}
				}
			}
			throw new Error("A property with name: " + propertyName + " does not exist within this sharedObject");
			
		}
		
		
		public function addProperty(propertyName:String,propertyValue:*):void
		{
			var data:Object = _SO.data;
			var r:Responder = new Responder(commonSOChangeHandler);
			_nc.call("updateCommonSO",r,propertyName,propertyValue,_SOName,_classId);
		}
		
		////////////////Static///////////////////
		
		public static function init(classId:String):void
		{
			_classId = classId;
			_soList = [];
		}
		
		public static function get sharedObjectList():Array
		{
			return _soList;
		}
		
		public static function setClassId(id:String):void
		{
			_classId = id;
		}
		
		public function get ClassId():String
		{
			return _classId;
		}
	}
}