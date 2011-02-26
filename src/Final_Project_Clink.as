package
{
	import com.clink.main.ClinkMain;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import org.osmf.display.ScaleMode;
	//the width and height in the swf object embed code needs to be set to 100%
	[SWF(width="960",height="600",frameRate = "25", backgroundColor = "0xAAAAAA")]
	public class Final_Project_Clink extends Sprite
	{

		public function Final_Project_Clink()
		{
			this.addEventListener(Event.ENTER_FRAME,checkForStage);
		}
		
		private function init():void
		{
			this.addChild( new ClinkMain(this.stage) );
			
			//turns off stage scaling when the stage is enlarged
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//defaults stage to the top of the screen
			stage.align = StageAlign.TOP_LEFT;
			
		}
		
		////////////////////////Callbacks/////////////////////
		
		private function checkForStage(e:Event):void
		{
			if(this.stage)
			{
				init();
				this.removeEventListener(Event.ENTER_FRAME,checkForStage);
			}
		}
		
	}
}



	
