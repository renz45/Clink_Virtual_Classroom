package com.critique.drawingObjects
{
	import flash.geom.Point;
	/**
	 * interface used by drawing tools 
	 * @author adamrensel
	 * 
	 */
	public interface IDrawingObject
	{
		function draw():void
		
		function get xPos():Number
			
		function set xPos(value:Number):void
			
		function get yPos():Number
			
		function set yPos(value:Number):void
		
		function set isEnabled(value:Boolean):void
			
		function deleteThis():void
			
		function set objName(value:String):void
			
		function get objName():String
	}
}