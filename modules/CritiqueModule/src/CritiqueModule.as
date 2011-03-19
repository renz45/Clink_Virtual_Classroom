package
{
	import com.clink.main.ClinkMain;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.module.BaseModule;
	import com.clink.module.IModule;
	import com.clink.ui.ScrollBox;
	import com.clink.valueObjects.VO_ModuleApi;
	import com.critique.events.BottomBarEvent;
	import com.critique.ui.BottomBar;
	import com.critique.ui.LeftToolBar;
	import com.critique.ui.TopBar;
	
	import lib.MainToolBar;
	
	public class CritiqueModule extends BaseModule implements IModule
	{
		private var _leftControls:LeftToolBar;
		private var _canvas:ScrollBox;
		private var _bottomBar:BottomBar;
		private var _topBar:TopBar;
		
		private var _userValuesSO:Manager_remoteUserSharedObject;
		private var _genericInfoSO:Manager_remoteCommonSharedObject;
		private var _layerListSO:Manager_remoteCommonSharedObject;
		
		
		
		public function CritiqueModule()
		{
			this.moduleName = "Critique";
		}
		
		override public function init():void
		{
			setupUi();
		} 
		
		private function setupUi():void 
		{
			//userValuesSO
			var template:Object = {tool:"arrow",
								   fontSize:1,
								   strokeSize:1, 
								   strokeColor:0x000000,
								   fillColor:0xffffff,
								   isMouseDown:false,
								   mouseX:0,
								   mouseY:0,
								   layer:"default",
							  	   isMaskOn:false,
								   zoomPercent:Number(1),
								   zoomX:0,
								   zoomY:0};
			_userValuesSO = new Manager_remoteUserSharedObject(this.moduleApiSettings.netConnection, this.moduleApiSettings.userID,"critiqueUserValuesSO",template);
			
			//main left controls
			_leftControls = new LeftToolBar(_userValuesSO);
			_leftControls.x = 15;
			_leftControls.y = 20;
			this.addChild(_leftControls); 
			
			//create the canvas
			_canvas = new ScrollBox(633,456,"#ffffff");
			
			_canvas.x = 59;
			_canvas.y = 55;
			
			this.addChild(_canvas);
			
			//genericInfoSO
			template = {fileToEdit:"", publicEditEnabled:false};
			_genericInfoSO = new Manager_remoteCommonSharedObject("critiqueGenericInfoSO",template,this.moduleApiSettings.netConnection);
			
			//bottom controls
			_bottomBar = new BottomBar(_genericInfoSO, this.moduleApiSettings);
			_bottomBar.x = 58;
			_bottomBar.y = 518; 
			
			_bottomBar.addEventListener(BottomBarEvent.IMAGE_LOADED,onImageLoaded);
			
			this.addChild(_bottomBar);
			 
			//layerListSO
			template = {1:"default"};
			_layerListSO = new Manager_remoteCommonSharedObject("critiqueLayerListSO",template,this.moduleApiSettings.netConnection);
			
			//top controls
			_topBar = new TopBar(_userValuesSO, _layerListSO, this.moduleApiSettings);
			_topBar.x = 59;
			_topBar.y = 9;
			
			this.addChild(_topBar);
			
			//hide controls if the user isn't of teacher permission
			if(this.moduleApiSettings.userPermission == ClinkMain.STUDENT_PERMISSION)
			{
				_leftControls.visible = false;
				_bottomBar.visible = false;
			}
			
			this.setChildIndex(_leftControls,this.numChildren - 1);
		}
		
		////////////////////////////callbacks///////////////////////////////
		private function onImageLoaded(e:BottomBarEvent):void
		{
			_canvas.addItem(e.image);
		}
		
		///////////////////////////public methods///////////////////////////
		public function connect():void
		{
			
		}
		
		public function disconnect():void
		{
			
		}
	}
}