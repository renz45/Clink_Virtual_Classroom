package
{
	import com.clink.main.ClinkMain;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	[SWF(width = "960", height = "600", frameRate = "25", backgroundColor = "0xAAAAAA")]
	public class Final_Project_Clink extends Sprite
	{
		
		
		public function Final_Project_Clink()
		{
			this.addEventListener(Event.ENTER_FRAME,checkForStage);
		}
		
		private function checkForStage(e:Event):void
		{
			if(this.stage.stageWidth > 0)
			{
				this.addChild( new ClinkMain() );
				this.removeEventListener(Event.ENTER_FRAME,checkForStage);
			}
		}
		
	}
}



	
