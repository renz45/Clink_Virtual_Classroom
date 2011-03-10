package
{
	import com.clink.factories.Factory_prettyBox;
	import com.clink.module.BaseModule;
	import com.clink.module.IModule;
	
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	
	public class Presenter extends BaseModule implements IModule
	{
		
		
		public function Presenter()
		{	
			this.moduleName = "Presenter";	
		}
		
		//////////////////public methods////////////////////
		
		//this is called when the moduleAPI information is loaded, the module starts up from here.
		override public function init():void
		{
			trace("initialized");
			
			this.addChild(Factory_prettyBox.drawPrettyBox(200,200,0x0000ff));
		} 
		
		public function connect():void
		{
			trace("module connected");
		}
		
		public function disconnect():void
		{
			trace("module disconnected");
		}
	}
}