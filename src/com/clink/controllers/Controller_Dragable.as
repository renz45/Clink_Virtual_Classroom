package com.clink.controllers
{
	import com.clink.valueObjects.VO_Settings;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public class Controller_Dragable extends EventDispatcher
	{
		private var _target:Sprite;
		private var _handle:Sprite;
		
		public function Controller_Dragable(target:Sprite, handle:Sprite)
		{
			super();
			
			_target = target;
			_handle = handle;
			
			init();
		}
		
		private function init():void
		{
			_handle.addEventListener(MouseEvent.MOUSE_DOWN,startDrag);
			_handle.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
		}
		
		////////////////////Callbacks////////////////////////
		private function startDrag(e:MouseEvent):void
		{
			_target.startDrag();
		}
		
		private function stopDrag(e:MouseEvent):void
		{
			_target.stopDrag();
		}
		
		public function enable():void
		{
			_handle.addEventListener(MouseEvent.MOUSE_DOWN,startDrag);
			_handle.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
		}
		
		public function disable():void
		{
			_handle.removeEventListener(MouseEvent.MOUSE_DOWN,startDrag);
			_handle.removeEventListener(MouseEvent.MOUSE_UP, stopDrag);
		}
	}
}