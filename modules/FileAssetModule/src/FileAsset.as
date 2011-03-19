package
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.main.ClinkMain;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.module.BaseModule;
	import com.clink.module.IModule;
	import com.clink.ui.BasicButton;
	import com.clink.ui.LayoutBox;
	import com.clink.ui.ScrollBox;
	import com.clink.ui.ScrollList;
	import com.clink.ui.SortingLayoutBox;
	import com.fileAsset.events.FileLoaderEvent;
	import com.fileAsset.loaders.DeleteServerFile;
	import com.fileAsset.loaders.FileDownloader;
	import com.fileAsset.loaders.FileUploader;
	import com.fileAsset.loaders.LoadFileNames;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import lib.ProgressBar;
	import lib.fileIcon;
	
	public class FileAsset extends BaseModule implements IModule
	{
		private var _fileArea:ScrollList;
		private var _gridContainer:SortingLayoutBox;
		private var _listContainer:SortingLayoutBox;
		
		private var _uploader:FileUploader;
		private var _filedownload:FileDownloader;
		private var _progressBar:ProgressBar;
		
		private var _fileNameLoader:LoadFileNames;
		private var _updateFileNamesSO:Manager_remoteCommonSharedObject;
		
		private var _filenameList:Array;
		
		public function FileAsset()
		{	
			//name has to be set, same as the name set in the moduleConfig.xml
			this.moduleName = "FileAssets";	
		} 
		
		/**
		 * this is called when the moduleAPI information is loaded, the module starts up from here, don't call this from the constructor
		 * this is also a required method
		 * 
		 */		
		override public function init():void
		{	
			trace("[module]["+ this.moduleName +"] initialized");
			
			_filenameList = [];
			
			//load the list of filenames
			_fileNameLoader = new LoadFileNames();
			_fileNameLoader.readDir(this.assetsPath + "listDir.php","../storage",updateFileList);
			
			drawUI();
			
			//uploader class
			_uploader = new FileUploader(_progressBar.mc_changer);
			_uploader.addEventListener(FileLoaderEvent.CLIENT_LOADED,onClientUploadComplete);
			_uploader.addEventListener(FileLoaderEvent.SERVER_LOADED,onServerUploadComplete);
			_uploader.serverSideFileLocation = "assets/upload.php";
			
			//downloader class
			_filedownload = new FileDownloader(_progressBar.mc_changer);
			
			//shared object used to refresh the file list whenever someone uploads a new file
			var template:Object = {updateNames:1};
			_updateFileNamesSO = new Manager_remoteCommonSharedObject("fileAssetUpdateSO",template,this.moduleApiSettings.netConnection);
			_updateFileNamesSO.addEventListener(SharedObjectEvent.CHANGED,onSOChange);
			
		} 
		
		private function drawUI():void
		{
			//main layoutbox
			var mainLB:LayoutBox = new LayoutBox(false,10);
			mainLB.x = 25;
			mainLB.y = 25;
			this.addChild(mainLB);
			
			//new scroll Area
			_fileArea = new ScrollList(648,494,"#ffffff");
			mainLB.addChild(_fileArea);
			
			//file holder
			_gridContainer = new SortingLayoutBox(false,10,true,7,10);
			_gridContainer.x = 20;
			_gridContainer.y = 20;
			_fileArea.addListItem(_gridContainer);
			_fileArea.update();
			
			//listContainer
			_listContainer = new SortingLayoutBox(true,0);

			//layout buttons
			//button layoutbox
			var buttonLB:LayoutBox = new LayoutBox(true,5);
			mainLB.addChild(buttonLB);
			
			//grid button
			var gridBtn:BasicButton = new BasicButton(26,26);
			gridBtn.upIcon = this.assetsPath + "gridBtn.png";
			gridBtn.downIcon = this.assetsPath + "gridBtn.png";
			gridBtn.enableToggle();
			gridBtn.message = "Grid View";
			buttonLB.addChild(gridBtn);
			gridBtn.addEventListener(MouseEvent.CLICK, switchToGrid);
			//list button
			var listBtn:BasicButton = new BasicButton(26,26);
			listBtn.upIcon = this.assetsPath + "listBtn.png";
			listBtn.downIcon = this.assetsPath + "listBtn.png";
			listBtn.enableToggle();
			listBtn.message = "List View";
			buttonLB.addChild(listBtn);
			listBtn.addEventListener(MouseEvent.CLICK,switchToList);
			
			gridBtn.setToggleGroup([gridBtn,listBtn]);
			listBtn.setToggleGroup([gridBtn,listBtn]);
			
			//set the grid the the default selected
			gridBtn.down();
			gridView();
			
			//upload button
			var upLoadBtn:BasicButton = new BasicButton(50,22,true);
			
			var f:Font = new HelveticaRegular();
			var tff:TextFormat = new TextFormat(f.fontName,12,0xffffff);
			tff.align = TextFormatAlign.CENTER;
			upLoadBtn.setLabel("Upload",tff);
			
			upLoadBtn.y = mainLB.height + mainLB.y + 10;
			upLoadBtn.x = mainLB.x;
			this.addChild(upLoadBtn);
			
			upLoadBtn.addEventListener(MouseEvent.CLICK,onUploadClick);
			
			//progress bar
			_progressBar = new ProgressBar();
			_progressBar.x = upLoadBtn.x + upLoadBtn.width + 25;
			_progressBar.y = upLoadBtn.y;
			this.addChild(_progressBar);
			_progressBar.visible = false;
		}
		
		private function gridView():void
		{
			if(_gridContainer.parent != _fileArea)
			{
				_fileArea.removeListItemAt(0);
				_fileArea.addListItem(_gridContainer);
			}
		}
		
		private function listView():void
		{
			if(_listContainer.parent != _fileArea)
			{
				_fileArea.removeListItemAt(0);
				_fileArea.addListItem(_listContainer);
			}
		}
		
		private function updateView():void
		{
			_fileNameLoader.updateFileNameList(updateFileList);
		}
		
		//////////////////Callbacks//////////////////////////
		
		private function deleteFile(e:MouseEvent):void
		{
			var del:DeleteServerFile = new DeleteServerFile(this.assetsPath + "deleteFile.php");
			del.deleteFile("../storage/" + e.currentTarget.name);
			del.addEventListener(Event.COMPLETE,deleteComplete);
			
		}
		
		private function deleteComplete(e:Event):void
		{
			updateView();
			_updateFileNamesSO.setProperty("updateNames",Number(_updateFileNamesSO.getProperty("updateNames")) * -1);
		}
		
		private function switchToGrid(e:MouseEvent):void
		{
			gridView(); 
		}
		
		private function switchToList(e:MouseEvent):void
		{
			listView();
		}
		
		private function downloadFile(e:MouseEvent):void
		{
			if(e.currentTarget.name != "false" )
			{
				_progressBar.visible = true;
				_filedownload.downLoadFileToDesktop(this.storagePath + e.target.name);
				_filedownload.addEventListener(Event.COMPLETE,downloadComplete);
			}
			
		}
		
		private function downloadComplete(e:Event):void
		{
			_progressBar.visible = false;
		}
		
		private function onSOChange(e:SharedObjectEvent):void
		{
			updateView();
		}
		
		private function updateFileList(fileNameList:Array):void
		{
			_filenameList = fileNameList;
			
			//remove a file from the display list if it no longer exists
			var deleted:Boolean = false;
			for each(var ob:Object in _gridContainer.items)
			{
				var exists:Boolean = false;
				for each(var file:String in fileNameList)
				{
					if(file == ob.label)
					{
						exists = true;
						break;
					}
				}
				if(!exists)
				{
					_gridContainer.removeItem(ob.item,ob.label);
					_listContainer.removeItem(ob.item,ob.label);
					deleted = true;
				}
				
			}
			
			//check to see if the new file is already displayed
			if(!deleted)
			{
				for each(var fileName:String in fileNameList)
				{
					var hasName:Boolean = false;
					
					for each(var obj:Object in _gridContainer.items)
					{
						if(obj.label == fileName)
						{
							hasName = true;
							break;
						}
					}
					
					//if the item doesn't exist than create a new icon
					if(!hasName && fileNameList.length > 0 && fileNameList[0] != "")
					{
						//populate the grid container
						//all this extra font and textFormat had to be added because of a flash cs5 bug that has to do with embedding fonts in textfields
						var icon:fileIcon = new fileIcon();
						icon.tf_fileName.embedFonts = true;
						icon.tf_fileType.embedFonts = true; 
						var f:Font = new HelveticaRegular();
						var tff:TextFormat = icon.tf_fileType.getTextFormat();
						tff.font = f.fontName;
						var tff2:TextFormat = icon.tf_fileName.getTextFormat();
						tff2.font = f.fontName;
						icon.buttonMode = true;
						icon.mouseChildren = false;
						icon.tf_fileName.text = fileName;
						icon.tf_fileName.setTextFormat(tff2);
						icon.tf_fileType.text = (fileName.split(".")[1] as String).toUpperCase();
						icon.tf_fileType.setTextFormat(tff);
						icon.name = fileName;
						
						icon.addEventListener(MouseEvent.CLICK,downloadFile);
						
						
						
						//populate the list container
						//list textfield
						var tf_fileName:TextField = new TextField();
						tf_fileName.embedFonts = true;
						tf_fileName.height = 15;
						tf_fileName.autoSize = TextFieldAutoSize.RIGHT;
						tf_fileName.mouseEnabled = false
						var tff3:TextFormat = new TextFormat(f.fontName,12,0x444444);
						tf_fileName.text = fileName;
						tf_fileName.setTextFormat(tff3);
						//list bg
						var bg:Sprite = Factory_prettyBox.drawPrettyBox(_fileArea.width - 3,22,0xeeeeee);
						bg.buttonMode = true;
						bg.mouseChildren = false;
						bg.addEventListener(MouseEvent.CLICK,downloadFile);
						bg.addChild(tf_fileName);
						bg.name = fileName;
						tf_fileName.x = 5;
						tf_fileName.y = 5;
						if(this.moduleApiSettings.userPermission == ClinkMain.TEACHER_PERMISSION)
						{
							//list delete button
							var newBg:Sprite = bg;
							bg = Factory_prettyBox.drawPrettyBox(_fileArea.width - 3,22,0xeeeeee);
							bg.addChild(newBg);
							tff3.color = 0xffffff;
							tff3.align = TextFormatAlign.CENTER;
							var btn:BasicButton = new BasicButton(45,22,true);
							btn.setLabel("Delete",tff3);
							btn.message = "Delete " + fileName;
							btn.addEventListener(MouseEvent.CLICK,deleteFile);
							newBg.width =  newBg.width - btn.width - 20;
							btn.x = newBg.width;
							btn.name = fileName;
							bg.addChild(btn);
							
							//grid Delete button
							var iconContainer:Sprite = new Sprite;
							
							var btn2:BasicButton = new BasicButton(45,22,true);
							btn2.setLabel("Delete",tff3);
							btn2.message = "Delete " + fileName;
							btn2.name = fileName;
							btn2.addEventListener(MouseEvent.CLICK,deleteFile);
							iconContainer.addChild(btn2);
							iconContainer.addChild(icon);
							icon.y = btn2.height + 5;
							btn2.x = iconContainer.width/2 - btn2.width/2;
							
							_gridContainer.addItem(iconContainer,fileName);
							
						}else{
							_gridContainer.addItem(icon,fileName);
						}
						
						_listContainer.addItem(bg,fileName);
						
						
					}
				} 
				_fileArea.update();  
			}
		}
		
		private function onClientUploadComplete(e:FileLoaderEvent):void
		{
			_uploader.uploadToServer("../storage/");
		}
		
		//whenever the sharedObject changes we want to update the file view, we don't care what the object is changed to, its just a notification basically
		private function onServerUploadComplete(e:FileLoaderEvent):void
		{
			_progressBar.visible = false;
			updateView();
			_updateFileNamesSO.setProperty("updateNames",Number(_updateFileNamesSO.getProperty("updateNames")) * -1);
		}
		
		private function onUploadClick(e:MouseEvent):void
		{
			_progressBar.visible = true;
			_uploader.browseForFile();
		}
		
		//////////////////public methods////////////////////
		
		public function getFileList():Array
		{
			return _filenameList;
		}

		public function get storageLocation():String
		{
			return this.storagePath;
		}
		
		public function saveFile(fileReference:FileReference):void
		{
			_uploader.uploadToServer("../storage/",fileReference);
		}
		
		/**
		 * required method, place any things that can be enabled or connected in this method. 
		 * 
		 */		
		public function connect():void
		{
			trace("[module]["+ this.moduleName +"] connected");
			
			updateView();
		}
		/**
		 * required method, place any things that can be disabled or disconnected in this method. 
		 * 
		 */		
		public function disconnect():void
		{
			trace("[module]["+ this.moduleName +"] disconnected");
		}
	}
}