package com.clink.controllers
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * 
	 * this controller is for sprite based buttons and rollovers. It takes 3 different sprites and enables rollover, mouse down, and mouse up states.
	 * 
	 */
	public class Controller_button extends Sprite
	{
		private var _upState:Sprite;
		private var _downState:Sprite;
		private var _overState:Sprite;
		
		private var _state:String;
		private var _isEnabled:Boolean;
		
		public function Controller_button(upState:Sprite)
		{
			super();
			
			_upState = upState;
			
			init();
			enable();
		}
		
		private function init():void
		{
			this.addChild(_upState);
			_state = "up";
			
			this.buttonMode = true;
			this.mouseChildren = false;
			
			
		}
		
		///////////////Callbacks////////////
		
		private function onOver(e:MouseEvent):void
		{
			over();
		}
		
		private function onOut(e:MouseEvent):void
		{
			up();
		}
		
		private function onDown(e:MouseEvent):void
		{
			down();
		}
		
		///////////////Public Methods///////////////
		public function enable():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER,onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			this.addEventListener(MouseEvent.MOUSE_UP,onOver);
			
			_isEnabled = true;
		}
		
		public function disable():void
		{
			this.removeEventListener(MouseEvent.ROLL_OVER,onOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,onDown);
			this.removeEventListener(MouseEvent.MOUSE_UP,onOver);
			
			_isEnabled = false;
		}
		
		public function over():void
		{
			if(_overState)
			{
				this.setChildIndex(_overState,this.numChildren - 1);
			}else{
				this.setChildIndex(_upState,this.numChildren - 1);
			}
			
			_state = "over";
		}
		
		public function up():void
		{
			
			this.setChildIndex(_upState,this.numChildren - 1);
			
			_state = "up";
		}
		
		public function down():void
		{
			
			if(_downState)
			{
				this.setChildIndex(_downState,this.numChildren - 1);
			}
			
			_state = "down";
		}
		
		/////////////Getters/Setters//////////
		public function set upState(upstate:Sprite):void
		{
			
			if(_upState && this.contains(_upState))
			{
				this.removeChild(_upState);	
			}
			_upState = upstate;
			if(this.numChildren == 0)
			{
				this.addChild(_upState);
			}else{
				this.addChildAt(_upState,this.numChildren - 1);
			}
		}
		
		public function get upState():Sprite
		{
			return _upState;
		}
		
		public function set downState(downstate:Sprite):void
		{
			if(_downState && this.contains(_downState))
			{
				this.removeChild(_downState);	
			}
			
			_downState = downstate;
			this.addChildAt(_downState,0);
		}
		
		public function get downState():Sprite
		{
			return _downState;
		}
		
		public function set overState(overstate:Sprite):void
		{
			if(_overState && this.contains(_overState))
			{
				this.removeChild(_overState);	
			}
			
			_overState = overstate;
			this.addChildAt(_overState,0);
		}
		
		public function get overState():Sprite
		{
			return _overState;
		}
		
		public function get enabled():Boolean
		{
			return _isEnabled;
		}
		
		public function get State():String
		{
			return _state;
		}
	}
}