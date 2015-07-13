package net.xuele.view.resources.resShow
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.UIAsset;

	public class VideoShow extends ResBase
	{
		private var _videoURL:String;
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
		private var _thisIsFull:Boolean;
		
		public function VideoShow()
		{
			super();
		}
		override protected function init():void
		{
			this._resVo._path="http://panfile.xuele.net/s/45373346424237344145443236343836323642364637393244343339384430382e6d7034";
			createVideoUI();
			addListener();
		}
		private var _vidGroup:Group;
		private var _contentBg:UIAsset;
		private var _playBtn:McButton;
		private var _pauseBtn:McButton;
		private var _fullBtn:McButton;
		private function createVideoUI():void
		{
			
		}
		private function createVideo():void
		{
			
			_connection=new NetConnection;
			_connection.connect(null);
			_stream=new NetStream(_connection);
			_stream.bufferTime=10;
			
			_video=new Video;
			_video.attachNetStream(_stream);
			var vidUI:UIAsset=new UIAsset;
			vidUI.skinName=_video;
			_vidGroup.addElement(vidUI);
			_stream.play(_videoURL);
			_stream.togglePause();
			
			_client = new Object;
			_client.onMetaData = onMetaData;
			_stream.client = _client;
			
			_stream.addEventListener(NetStatusEvent.NET_STATUS,stateHandler);
		}
		private function onMetaData(data:Object):void
		{
			_vidWidth=data.width;
			_vidHeight=data.height;
			_video.width=_vidWidth;
			_video.height=_vidHeight;
			
		}
		private var statusCode:String;
		private function stateHandler(e:NetStatusEvent):void
		{
			trace("state",e.info.code)
			statusCode=e.info.code;
			switch(e.info.code){
				case "NetStream.Play.Stop":
					_stream.seek(0);
					break;
				case "NetStream.Play.Start":
					break;
				case "NetStream.Seek.Complete":
					_stream.pause();
					
					_playBtn.visible=true;
					_pauseBtn.visible=false;
					break;
				case "NetStream.Pause.Notify":
					_playBtn.visible=true;
					_pauseBtn.visible=false;
					break;
				case "NetStream.Unpause.Notify":
					_playBtn.visible=false;
					_pauseBtn.visible=true;
					break;
				
				default:
					break;
			}
		}
		private function addListener():void
		{
			
		}
		override public function removeListener():void
		{
			
		}
	}
}