package net.xuele.view.homework.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	public class SoundWork extends Group
	{
		private var _snd:Sound;
		private var _soundChannel:SoundChannel;
		/**
		 * 播放按钮 
		 */
		private var _playBtn:McButton;
		/**
		 * 暂停按钮 
		 */
		private var _pauseBtn:McButton;
		/**
		 * 停止按钮 
		 */
		private var _stopBtn:McButton;
		/**
		 * 进度条 
		 */
		private var _seekBar:Group;
		/**
		 * 声音条 
		 */
		private var _volumeBar:Group;
		/**
		 * 静音按钮 
		 */
		private var _muteBtn:UIMovieClip;
		/**
		 * 背景 
		 */
		private var _bg:UIAsset;
		/**
		 * 进度控制条 
		 */
		private var _posBar:UIAsset;
		/**
		 * 进度按钮 
		 */
		private var _posBtn:McButton;
		/**
		 * 声音控制条 
		 */
		private var _volBar:UIAsset;
		/**
		 * 声音按钮 
		 */
		private var _volBtn:McButton;
		/**
		 * 静音 
		 */
		private var _isMute:Boolean;
		/**
		 * 音量 
		 */
		private var _vol:Number;
		/**
		 * 静音前的保存音量大小 
		 */
		private var _saveVol:Number;
		
		/**
		 * 进度定位 
		 */
		private var _pos:Number;
		private var _sound:Sound;
		/**
		 * 声音是否播放状态 
		 */
		private var _soundOn:Boolean=false;
		private var _sndURL:String;
		public function SoundWork(str:String)
		{
			super();
			_sndURL=str;
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			this._soundChannel=new SoundChannel;
			this._pos=0;
			this._vol=1;
			createUI();
			addListener();
		}
		private function createUI():void
		{
			this._bg=new UIAsset;
			this._bg.skinName=PublicOperate.getUI("SoundBg") as Sprite;
			
			var playGroup:Group=new Group;
			this._playBtn=new McButton;
			this._playBtn.skinName=PublicOperate.getUI("SoundPlayBtn","movieclip") as MovieClip;
			this._pauseBtn=new McButton;
			this._pauseBtn.skinName=PublicOperate.getUI("SoundPauseBtn","movieclip") as MovieClip;
			playGroup.addElement(this._playBtn);
			this._playBtn.maintainAspectRatio=true;
			playGroup.addElement(this._pauseBtn);
			this._pauseBtn.visible=false;
			this._pauseBtn.maintainAspectRatio=true;
			
			this._seekBar=new Group;
			this._posBar=new UIAsset;
			this._posBar.skinName=PublicOperate.getUI("SoundPosBar") as Sprite;
			this._posBtn=new McButton;
			this._posBtn.skinName=PublicOperate.getUI("SoundPosBtn") as Sprite;
			this._seekBar.addElement(this._posBar);
			this._posBar.maintainAspectRatio=true;
			this._posBar.verticalCenter=0;
			this._seekBar.addElement(this._posBtn);
			this._posBtn.maintainAspectRatio=true;
			
			
			this.addElement(this._bg);
			var seekGroup:Group=new Group;
			var seekLayout:HorizontalLayout=new HorizontalLayout;
			seekLayout.gap=10;
			seekGroup.layout=seekLayout;
			seekGroup.addElement(playGroup);
			seekGroup.addElement(this._seekBar);
			this.addElement(seekGroup);
			seekGroup.left=20;
			seekGroup.verticalCenter=0;
			
			
		}
		private function addListener():void
		{
			this._playBtn.addEventListener(MouseEvent.CLICK,StartSoundHandler);
			this._pauseBtn.addEventListener(MouseEvent.CLICK,pauseHandler);
			this._posBar.addEventListener(MouseEvent.CLICK,setPosHandler);
			this._posBtn.addEventListener(MouseEvent.MOUSE_DOWN,posDownHandler);
			this._posBtn.addEventListener(MouseEvent.MOUSE_UP,posUpHandler);
			this._posBtn.addEventListener(MouseEvent.RELEASE_OUTSIDE,posUpHandler);
		}
		private function StartSoundHandler(e:MouseEvent):void
		{
			if(MainData._mouseType!=0){
				return;
			}
			this._pauseBtn.visible=true;
			this._playBtn.visible=false;
			if(this._soundOn){
				playSound();
			}else{
				loadSound();
			}
		}
		private function loadSound():void
		{
			this._sound=new Sound;
			SoundMixer.stopAll();
			this._soundOn=true;
			var request:URLRequest=new URLRequest;
			request.contentType="audio/mp3";
			request.url=this._sndURL;
			this._pos=0;
			var context:SoundLoaderContext=new SoundLoaderContext(5000);
			this._sound.load(request,context);
			this._soundChannel=this._sound.play(0);
			this._soundChannel.addEventListener(Event.SOUND_COMPLETE,sndComHandler);
			_posBtn.addEventListener(Event.ENTER_FRAME,posEnterHandler);
		}
		private function playSound():void
		{
			this._soundChannel=_sound.play(this._pos);
			this._soundChannel.addEventListener(Event.SOUND_COMPLETE,sndComHandler);
			_posBtn.addEventListener(Event.ENTER_FRAME,posEnterHandler);
		}
		private function sndComHandler(e:Event):void
		{
			this._soundChannel.removeEventListener(Event.SOUND_COMPLETE,sndComHandler);
			this._pauseBtn.visible=false;
			this._playBtn.visible=true;
			this._pos=0;
			this._soundChannel.stop();
			_posBtn.removeEventListener(Event.ENTER_FRAME,posEnterHandler);
		}
		private function pauseHandler(e:MouseEvent):void
		{
			if(MainData._mouseType!=0||this._sound==null){
				return;
			}
			this._soundChannel.removeEventListener(Event.SOUND_COMPLETE,sndComHandler);
			this._pauseBtn.visible=false;
			this._playBtn.visible=true;
			this._pos=this._soundChannel.position;
			this._soundChannel.stop();
			_posBtn.removeEventListener(Event.ENTER_FRAME,posEnterHandler);
		}
		private function setPosHandler(e:MouseEvent):void
		{
			if(MainData._mouseType!=0||this._sound==null){
				return;
			}
			trace(_seekBar.mouseX,mouseX-_seekBar.x,"SoundShow")
			if((_seekBar.mouseX)>78.5){
				this._posBtn.x=78.5;
			}else{
				this._posBtn.x=_seekBar.mouseX;
			}
			this._pos=_sound.length/78.5*(_posBtn.x);
			this.setPos();
		}
		private function posEnterHandler(e:Event):void
		{
			this._pos=this._soundChannel.position;
			this._posBtn.x=this._pos/(_sound.length/78.5);
			
		}
		private function posDownHandler(e:MouseEvent):void
		{
			if(MainData._mouseType!=0||this._sound==null){
				return;
			}
			_posBtn.removeEventListener(Event.ENTER_FRAME,posEnterHandler);
			this._posBtn.startDrag(false,new Rectangle(0,0,78.5,0));
		}
		private function posUpHandler(e:MouseEvent):void
		{
			if(MainData._mouseType!=0||this._sound==null){
				return;
			}
			this._posBtn.stopDrag();
			this._pos=_sound.length/78.5*this._posBtn.x;
			this.setPos();
		}
		private function setPos():void
		{
			this._soundChannel.stop();
			this._soundChannel.removeEventListener(Event.SOUND_COMPLETE,sndComHandler);
			_posBtn.removeEventListener(Event.ENTER_FRAME,posEnterHandler);
			this._soundChannel=_sound.play(this._pos);
			this._soundChannel.addEventListener(Event.SOUND_COMPLETE,sndComHandler);
			_posBtn.addEventListener(Event.ENTER_FRAME,posEnterHandler);
			this._pauseBtn.visible=true;
			this._playBtn.visible=false;
		}
		public function sndStop():void
		{
			if(MainData._mouseType!=0||this._sound==null){
				return;
			}
			this._soundChannel.stop();
			if(this._pauseBtn.visible){
				this._pauseBtn.visible=false;
				this._playBtn.visible=true;
			}
		}
	}
}