package com.critique.drawingObjects
{
	import com.clink.managers.Manager_remoteCommonSharedObject;
	
	import flash.display.Sprite;
	
	public class Factory_DrawingObject extends Sprite
	{
		public function Factory_DrawingObject()
		{
			super();
		}
		
		public static function getObject(objectType:String, objectListSO:Manager_remoteCommonSharedObject ,name:String, userId:Number):BaseDrawingObject
		{
			switch(objectType)
			{
				case "square":
					return new BoxTool(objectListSO, name, userId);
					break;
				
				case "circle":
					
					break;
				
				case "line":
					
					break;
				
				case "text":
					
					break;
				
				case "pencil":
					
					break;
			}
			
			return null;
		}
	}
}