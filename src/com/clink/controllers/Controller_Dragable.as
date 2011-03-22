package com.clink.controllers
{
	import com.clink.valueObjects.VO_Settings;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class Controller_Dragable extends EventDispatcher
	{
		private var _target:Sprite;
		private var _handle:Sprite;
		
		private var _lockCenter:Boolean;
		private var _dragRectangle:Rectangle;
		
		public function Controller_Dragable(target:Sprite, handle:Sprite, lockCenter:Boolean = false, dragRectangle:Rectangle = null)
		{
			super();
			
			_target = target;
			_handle = handle;
			_lockCenter = lockCenter;
			_dragRectangle = dragRectangle;
			
			init();
		}
		
		private function init():void
		{
			_handle.addEventListener(MouseEvent.MOUSE_DOWN,startDrag);
			_handle.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
			
			_target.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		
		////////////////////Callbacks////////////////////////
		private function addedToStage(e:Event):void
		{
			if(_target.stage)
			{
				_target.stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}
			
			_target.stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			_target.stage.addEventListener(MouseEvent.MOUSE_UP,stopDrag);
		}
		
		private function startDrag(e:MouseEvent):void
		{
			_target.startDrag(_lockCenter,_dragRectangle);
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
		
		public function set dragRectangle(rect:Rectangle):void
		{
			_dragRectangle = rect;
		}
	}
}