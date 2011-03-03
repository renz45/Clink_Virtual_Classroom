package com.clink.main
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.ui.BasicButton;
	import com.clink.ui.ScrollList;
	import com.clink.utils.StringUtils;
	import com.clink.valueObjects.VO_Settings;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.sendToURL;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.formats.TextAlign;
	
	import mx.utils.StringUtil;
	
	public class TextChat extends Sprite
	{
		private var _chatBox:ScrollList;
		private var _chat:TextField;
		private var _inputChat:TextField;
		private var _inputSubmit:BasicButton;
		
		private var _configInfo:VO_Settings;
		private var _tff:TextFormat;
		
		private var _chatSO:Manager_remoteCommonSharedObject;
		
		public function TextChat(chatSO:Manager_remoteCommonSharedObject,configInfo:VO_Settings)
		{
			super();
			
			_configInfo = configInfo;
			_chatSO = chatSO;
			init();
		}
		
		private function init():void
		{
			//scrolling chat
			_chatBox = new ScrollList(220,167,"#ffffff");
			_chatBox.value = 1;
			this.addChild(_chatBox);
			
			//chat textfield
			_chat = new TextField();
			_chat.wordWrap = true;
			_chat.width = 200;
			_chat.height = 0
			_chat.autoSize = TextFieldAutoSize.LEFT;
			_chat.embedFonts = true;
			_chat.multiline = true;
			//textfieldformat
			var f:Font = new HelveticaRegular();
			_tff = new TextFormat(f.fontName,12,0x555555);
			_tff.leading = 3;
			_chat.defaultTextFormat = _tff;
			
			_chatBox.addListItem(_chat);
			
			//input text field
				//bg
			var textInputBg:Sprite = Factory_prettyBox.drawPrettyBox(178,20,0xffffff,0,false,false,true);
			textInputBg.y = _chatBox.height + 5;
			this.addChild(textInputBg);
				//input textfield
			_inputChat = new TextField();
			_inputChat.type = TextFieldType.INPUT;
			_inputChat.width = 170;
			_inputChat.height = 15;
			_inputChat.y = textInputBg.y + 3
			_inputChat.defaultTextFormat = _tff;
			_inputChat.embedFonts = true;
			this.addChild(_inputChat);
			
			//submit button
			var btnLabels:Array = [];
			
			_inputSubmit = new BasicButton(37,20,true);
			var tff2:TextFormat = new TextFormat(f.fontName,12,0xffffff,null,null,null,null,null,TextAlign.CENTER);
			_inputSubmit.setLabel("Post",tff2);
			_inputSubmit.x = textInputBg.width + 5;
			_inputSubmit.y = textInputBg.y;
			_inputSubmit.setShortCutKey(Keyboard.ENTER,true);
			_inputSubmit.addEventListener(MouseEvent.CLICK,chatSubmit);
			this.addChild(_inputSubmit);
			
			//add listeners to the chatSO
			_chatSO.addEventListener(SharedObjectEvent.CHANGED,onSOChange);
			_chatSO.addEventListener(SharedObjectEvent.CLIENT_CHANGED,onSOChange);
			_chatSO.addEventListener(SharedObjectEvent.CONNECTED,onSOConnect);
		}
		
		private function fillChat(name:String, msg:String):void
		{
			
			_chat.defaultTextFormat = _tff;
			
			_chat.htmlText += ("<p> <b><font color='#000077' size='14'>"+ name + ":</font></b> " + msg + "</p>");
			_chatBox.update();
		}
		
		
		////////////////////////////////Callbacks///////////////////////////////
		private function chatSubmit(e:MouseEvent):void
		{
			if(_inputChat.text != "")
			{
				var count:int = 0;
				
				for(var k:Object in _chatSO.sharedObject.data)
				{
					count++;
				}
				
				var newSlot:String = (count + 1).toString();
				
				//var pattern1:RegExp = new RegExp("http\\://[a-zA-Z0-9\\-\\.]+\\.[a-zA-Z]{2,3}(/\\S*)?","gi");
				
				var pattern1:RegExp = new RegExp("(http|https|ftp)\\://([a-zA-Z0-9\\.\-]+(\\:[a-zA-Z0-9\.&amp;%\\$\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\+&amp;%\$#\=~_\\-]+))?","gi");
				
				var pattern2:RegExp = new RegExp("(?:(?:w{3}\\.)(?:[a-zA-Z0-9/;\\?&=:\\-_\\$\\+!\\*'\\(\\|\\\\~\\[\\]#%\\.])+[\\.com|\\.edu|\\.gov|\\.int|\\.mil|\\.net|\\.org|\\.biz|\\.info|\\.name|\\.pro|\\.aero|\\.coop|\\.museum|\\.cat|\\.jobs|\\.travel|\\.arpa|\\.mobi|\\.ac|\\.ad|\\.ae|\\.af|\\.ag|\\.ai|\\.al|\\.am|\\.an|\\.ao|\\.aq|\\.ar|\\.as|\\.at|\\.au|\\.aw|\\.az|\\.ax|\\.ba|\\.bb|\\.bd|\\.be|\\.bf|\\.bg|\\.bh|\\.bi|\\.bj|\\.bm|\\.bn|\\.bo|\\.br|\\.bs|\\.bt|\\.bv|\\.bw|\\.by|\\.bz|\\.ca|\\.cc|\\.cd|\\.cf|\\.cg|\\.ch|\\.ci|\\.ck|\\.cl|\\.cm|\\.cn|\\.co|\\.cr|\\.cs|\\.cu|\\.cv|\\.cx|\\.cy|\\.cz|\\.de|\\.dj|\\.dk|\\.dm|\\.do|\\.dz|\\.ec|\\.ee|\\.eg|\\.eh|\\.er|\\.es|\\.et|\\.eu|\\.fi|\\.fj|\\.fk|\\.fm|\\.fo|\\.fr|\\.ga|\\.gb|\\.gd|\\.ge|\\.gf|\\.gg|\\.gh|\\.gi|\\.gl|\\.gm|\\.gn|\\.gp|\\.gq|\\.gr|\\.gs|\\.gt|\\.gu|\\.gw|\\.gy|\\.hk|\\.hm|\\.hn|\\.hr|\\.ht|\\.hu|\\.id|\\.ie|\\.il|\\.im|\\.in|\\.io|\\.iq|\\.ir|\\.is|\\.it|\\.je|\\.jm|\\.jo|\\.jp|\\.ke|\\.kg|\\.kh|\\.ki|\\.km|\\.kn|\\.kp|\\.kr|\\.kw|\\.ky|\\.kz|\\.la|\\.lb|\\.lc|\\.li|\\.lk|\\.lr|\\.ls|\\.lt|\\.lu|\\.lv|\\.ly|\\.ma|\\.mc|\\.md|\\.mg|\\.mh|\\.mk|\\.ml|\\.mm|\\.mn|\\.mo|\\.mp|\\.mq|\\.mr|\\.ms|\\.mt|\\.mu|\\.mv|\\.mw|\\.mx|\\.my|\\.mz|\\.na|\\.nc|\\.ne|\\.nf|\\.ng|\\.ni|\\.nl|\\.no|\\.np|\\.nr|\\.nu|\\.nz|\\.om|\\.pa|\\.pe|\\.pf|\\.pg|\\.ph|\\.pk|\\.pl|\\.pm|\\.pn|\\.pr|\\.ps|\\.pt|\\.pw|\\.py|\\.qa|\\.re|\\.ro|\\.ru|\\.rw|\\.sa|\\.sb|\\.sc|\\.sd|\\.se|\\.sg|\\.sh|\\..si|\\.sj|\\.sk|\\.sl|\\.sm|\\.sn|\\.so|\\.sr|\\.st|\\.sv|\\.sy|\\.sz|\\.tc|\\.td|\\.tf|\\.tg|\\.th|\\.tj|\\.tk|\\.tl|\\.tm|\\.tn|\\.to|\\.tp|\\.tr|\\.tt|\\.tv|\\.tw|\\.tz|\\.ua|\\.ug|\\.uk|\\.um|\\.us|\\.uy|\\.uz|\\.va|\\.vc|\\.ve|\\.vg|\\.vi|\\.vn|\\.vu|\\.wf|\\.ws|\\.ye|\\.yt|\\.yu|\\.za|\\.zm|\\.zw](?:[a-zA-Z0-9/;\\?&=:\\-_\\$\\+!\\*'\\(\\|\\\\~\\[\\]#%\\.])*)","gi");
				
				var sendText:String = _inputChat.text.replace(pattern1,"<font color='#0000FF'><u><a href='$&' target='_blank'>$&</a></u></font>");
				
				if(!pattern1.test(_inputChat.text))
				{
					 sendText = _inputChat.text.replace(pattern2,"<font color='#0000FF'><u><a href='http://$&' target='_blank'>$&</a></u></font>");
				}
					 
				_chatSO.addProperty(newSlot,{name:_configInfo.username,msg:sendText});
				
				_chatBox.value = 1;
				
				_inputChat.text = "";
			}
		}
		
		private function onSOChange(e:SharedObjectEvent):void
		{
			fillChat(e.propertyValue.name, e.propertyValue.msg);
		}
		
		private function onSOConnect(e:SharedObjectEvent):void
		{
			
		}
	}
}