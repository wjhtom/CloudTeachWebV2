package net.xuele.view.resources.resShow
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.events.ResEvent;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	

	public class VideoShow extends ResBase
	{
		private var _stream:NetStream;
		private var _connection:NetConnection;
		private var _video:Video;
		private var _client:Object;
		private var _vidWidth:Number;
		private var _vidHeight:Number;
		private var _vidX:Number;
		private var _vidY:Number;
		private const _BGWidth:Number=480;
		private const _BGHeight:Number=360;
		private var _thisIsFull:Boolean=false;
		
		private var _isEnd:Boolean;
		
		private var _totalTime:Number;
		
		public function VideoShow()
		{
			super();
		}
		override protected function init():void
		{
//			this._resVo._path="http://panfile.xuele.net/s/33313735353542333238353234453832414232374346433244333645453842432e6d7034";
			createVideoUI();
			addListener();
			createVideo();
		}
		private var _vidGroup:Group;
		private var _contentBg:UIAsset;
		private var _playBtn:McButton;
		private var _pauseBtn:McButton;
		private var _fullBtn:McButton;
		private var _unFullBtn:McButton;
		private var _btnGroup:Group;
		private var _playPro:Rect;
		private var _bufferPro:Rect;
		private var _pos:McButton;
		private var _btnBg:Rect;
		private function createVideoUI():void
		{
			//视频区
			this._vidGroup=new Group;
			var vidBg:Rect=createRect(this._BGWidth,this._BGHeight,0x999999);
			this._vidGroup.addElement(vidBg);
			this.addElement(this._vidGroup);
			this._dragRect=this._vidGroup;
			
			//按钮
			this._btnGroup=new Group;
			_btnBg=createRect(this._BGWidth,40,0xB2C0BF);
			this._btnGroup.addElement(_btnBg);
			_btnBg.fillAlpha=0.55;
			
			var playGroup:Group=new Group;
			this._playBtn=new McButton;
			this._playBtn.skinName=PublicOperate.getUI("VideoPlayBtn","movieclip") as MovieClip;
			this._pauseBtn=new McButton;
			this._pauseBtn.skinName=PublicOperate.getUI("VideoPauseBtn","movieclip") as MovieClip;
			
			playGroup.addElement(this._playBtn);
			this._playBtn.maintainAspectRatio=true;
			playGroup.addElement(this._pauseBtn);
			this._pauseBtn.maintainAspectRatio=true;
			this._pauseBtn.visible=false;
			
			
			_btnGroup.addElement(playGroup);
			playGroup.left=20;
			playGroup.verticalCenter=0;
			
			//进度条
			var proGroup:Group=new Group;
			var proBg:Rect=createRect(300,10,0x666666);
			this._bufferPro=createRect(0,10,0x000000);
			this._playPro=createRect(0,10,0xff0000);
			this._pos=new McButton;
			this._pos.skinName=PublicOperate.getUI("VideoPos","movieclip") as MovieClip;
			
			
			
			proGroup.addElement(proBg);
			proGroup.addElement(_bufferPro);
			proGroup.addElement(_playPro);
			proGroup.addElement(this._pos);
			this._pos.maintainAspectRatio=true;
			this._pos.x=0;
			
			proBg.verticalCenter=0;
			_bufferPro.verticalCenter=0;
			_playPro.verticalCenter=0;
			_bufferPro.left=0;
			_playPro.left=0;
			this._btnGroup.addElement(proGroup);
			proGroup.horizontalCenter=0;
			proGroup.verticalCenter=0;
			
			//最大化按钮
			var fullGroup:Group=new Group;
			this._fullBtn=new McButton;
			this._fullBtn.skinName=PublicOperate.getUI("VideoFullBtn","movieclip") as MovieClip;
			this._unFullBtn=new McButton;
			this._unFullBtn.skinName=PublicOperate.getUI("VideoUnFullBtn","movieclip") as MovieClip;
			fullGroup.addElement(this._fullBtn);
			this._fullBtn.maintainAspectRatio=true;
			fullGroup.addElement(this._unFullBtn);
			this._unFullBtn.visible=false;
			this._unFullBtn.maintainAspectRatio=true;
			this._btnGroup.addElement(fullGroup);
			fullGroup.right=20;
			fullGroup.verticalCenter=0;
			
			this.addElement(this._btnGroup);
			this._btnGroup.bottom=-40;
			
			this.dispatchEvent(new ResEvent(ResEvent.LOADRESCOM));
			this._vidX=this.x;
			this._vidY=this.y;
		}
		private var _vidUI:UIAsset;
		private function createVideo():void
		{
			SoundMixer.stopAll();
			_connection=new NetConnection;
			_connection.connect(null);
			_stream=new NetStream(_connection);
			_stream.bufferTime=10;
			
			_video=new Video;
			_video.attachNetStream(_stream);
			_vidUI=new UIAsset;
			_vidUI.skinName=_video;
			_vidGroup.addElement(_vidUI);
			_stream.play(this._resVo._path);
			_stream.togglePause();
			
			_client = new Object;
			_client.onMetaData = onMetaData;
			_stream.client = _client;
			
			_isEnd=false;
			_stream.addEventListener(NetStatusEvent.NET_STATUS,stateHandler);
		}
		private function onMetaData(data:Object):void
		{
			_vidWidth=data.width;
			_vidHeight=data.height;
			setVideoWH(_vidWidth,_vidHeight);
			_totalTime=data.duration;
		}
		private function setVideoWH(w:Number,h:Number):void
		{
			this._vidUI.width=w;
			this._vidUI.height=h;
			if(w>h){
				if(this._BGWidth>=w){
					this._vidUI.horizontalCenter=this._vidUI.verticalCenter=0;
				}else{
					this._btnBg.width=w;
				}
			}else{
				if(this._BGHeight>=h){
					this._vidUI.horizontalCenter=this._vidUI.verticalCenter=0;
				}else{
					this._btnBg.width=w;
				}
			}
		}
		private var statusCode:String;
		private function stateHandler(e:NetStatusEvent):void
		{
			trace("state",e.info.code)
			statusCode=e.info.code;
			switch(e.info.code){
				case "NetStream.Play.Stop":
					_isEnd=true;
					this._video.clear();
					_stream.play(this._resVo._path);
					_stream.seek(0);
					_stream.pause();
					break;
				case "NetStream.Play.Start":
					break;
				case "NetStream.Seek.Complete":
//					_stream.pause();
//					_playBtn.visible=true;
//					_pauseBtn.visible=false;
					_stream.resume();
					_playBtn.visible=false;
					_pauseBtn.visible=true;
					break;
				case "NetStream.Pause.Notify":
					_playBtn.visible=true;
					_pauseBtn.visible=false;
					break;
				case "NetStream.Unpause.Notify":
					_playBtn.visible=false;
					_pauseBtn.visible=true;
					break;
				case "NetStream.Buffer.Flush":
//					_stream.togglePause();
//					_playBtn.visible=false;
//					_pauseBtn.visible=true;
					break;
				default:
					break;
			}
		}
		private function addListener():void
		{
			_playBtn.addEventListener(MouseEvent.CLICK,playHandler);
			_pauseBtn.addEventListener(MouseEvent.CLICK,playHandler);
			_fullBtn.addEventListener(MouseEvent.CLICK,fullHandler);
			_unFullBtn.addEventListener(MouseEvent.CLICK,fullHandler);
			this._playPro.addEventListener(Event.ENTER_FRAME,playEnterHandler);
			this._bufferPro.addEventListener(Event.ENTER_FRAME,bufferEnterHandler);
			this._pos.addEventListener(MouseEvent.MOUSE_DOWN,posDownHandler);
			this._pos.addEventListener(MouseEvent.MOUSE_UP,posUpHandler);
			this._pos.addEventListener(MouseEvent.RELEASE_OUTSIDE,posUpHandler);
		}
		private function posDownHandler(e:MouseEvent):void
		{
			if(MainData._mouseType!=0){
				return;
			}
			if(this._pos.hasEventListener(Event.ENTER_FRAME)){
				this._pos.removeEventListener(Event.ENTER_FRAME,posEnterHandler);
			}
			_stream.pause();
			this._pos.startDrag(false,new Rectangle(0,0,300-this._pos.width,0));
		}
		private function posUpHandler(e:MouseEvent):void
		{
			if(MainData._mouseType!=0){
				return;
			}
			if(!this._pos.hasEventListener(Event.ENTER_FRAME)){
				this._pos.addEventListener(Event.ENTER_FRAME,posEnterHandler);
			}
			var value:Number=_totalTime/300*this._pos.x;
			if (value > Math.floor(int(_totalTime) * _stream.bytesLoaded / _stream.bytesTotal)) 
			{ 
				_stream.seek(Math.floor(int(_totalTime) * _stream.bytesLoaded / _stream.bytesTotal)-5); 
			} 
			else 
			{ 
				_stream.seek(value); 
			} 
			
			this._pos.stopDrag();
		}
		private function playHandler(e:MouseEvent):void
		{
			if(MainData._mouseType!=0){
				return;
			}
			if(this._pos.hasEventListener(Event.ENTER_FRAME)){
				this._pos.removeEventListener(Event.ENTER_FRAME,posEnterHandler);
			}else{
				this._pos.addEventListener(Event.ENTER_FRAME,posEnterHandler);
			}
			if(_isEnd){
				if(!this._pos.hasEventListener(Event.ENTER_FRAME)){
					this._pos.addEventListener(Event.ENTER_FRAME,posEnterHandler);
				}
				_isEnd=false;
			}
			_stream.togglePause();
			
		}
		private function fullHandler(e:MouseEvent):void
		{
			if(MainData._mouseType!=0){
				return;
			}
			changeSize();
		}
		private function posEnterHandler(e:Event):void
		{
			this._pos.x=(300/this._totalTime)*this._stream.time;
//			trace(_totalTime,_stream.time)
		}
		private function playEnterHandler(e:Event):void
		{
			this._playPro.width=this._pos.x+this._pos.width/2;
		}
		private function bufferEnterHandler(e:Event):void
		{
			this._bufferPro.width=Math.round((this._stream.bytesLoaded/this._stream.bytesTotal)*100)*3;
		}
		private function changeSize():void
		{
			
			if(this._thisIsFull){
				CommondView.popView.removeElementAt(0);
//				this._vidGroup.width=this._BGWidth;
//				this._vidGroup.height=this._BGHeight;
				Group(CommondView.contentView).addElement(this);
				this.includeInLayout=false;
				this._vidUI.scaleX=this._vidUI.scaleY=1;
				this._vidUI.width=this._vidWidth;
				this._vidUI.height=this._vidHeight;
				this.x=this._vidX;
				this.y=this._vidY;
				this._unFullBtn.visible=false;
				this._fullBtn.visible=true;
				this._thisIsFull=false;
				
			}else{
				var bg:Rect=new Rect;
				bg.width=MainData._stageWidth;//stage.stageWidth;
				bg.height=MainData._stageHeight;//stage.stageHeight;
				bg.fillAlpha=1;
				bg.fillColor=0x000000;
				CommondView.popView.addElementAt(bg,0);
				CommondView.popView.addElement(this);
				this.includeInLayout=true;
				this._vidX=this.x;
				this._vidY=this.y;
				if(this._vidUI.width>this._vidUI.height){
					this._vidUI.scaleX=this._vidUI.scaleY=(MainData._stageHeight-40)/this._vidUI.height;
				}else{
					this._vidUI.scaleX=this._vidUI.scaleY=MainData._stageWidth/this._vidUI.width;
				}
				
				this.horizontalCenter=0;
				this.top=0;
				this._thisIsFull=true;
				this._unFullBtn.visible=true;
				this._fullBtn.visible=false;
				
			}
			this._btnBg.width=this._vidUI.getBounds(this._vidUI.parent).width;
		}
		override public function removeListener():void
		{
			_playBtn.removeEventListener(MouseEvent.CLICK,playHandler);
			_pauseBtn.removeEventListener(MouseEvent.CLICK,playHandler);
			_fullBtn.removeEventListener(MouseEvent.CLICK,fullHandler);
			_unFullBtn.removeEventListener(MouseEvent.CLICK,fullHandler);
			this._playPro.removeEventListener(Event.ENTER_FRAME,playEnterHandler);
			this._bufferPro.removeEventListener(Event.ENTER_FRAME,bufferEnterHandler);
			this._pos.removeEventListener(MouseEvent.MOUSE_DOWN,posDownHandler);
			this._pos.removeEventListener(MouseEvent.MOUSE_UP,posUpHandler);
			this._pos.removeEventListener(MouseEvent.RELEASE_OUTSIDE,posUpHandler);
		}
		private function createRect(w:Number,h:Number,color:uint):Rect
		{
			var rect:Rect=new Rect;
			rect.width=w;
			rect.height=h;
			rect.fillAlpha=1;
			rect.fillColor=color;
			return rect;
		}
	}
}