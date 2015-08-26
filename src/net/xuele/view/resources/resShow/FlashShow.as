package net.xuele.view.resources.resShow
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.events.ResEvent;
	
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.utils.callLater;

	public class FlashShow extends ResBase
	{
		private var _swfLoader:Loader;
		public function FlashShow()
		{
			super();
		}
		override protected function init():void
		{
			var ui:UIAsset=new UIAsset;
			ui.skinName=PublicOperate.getUI("IconBigSWF");
			this.addElement(ui);
			callLater(setUI,null,3);
		}
		private function setUI():void
		{
			this.dispatchEvent(new ResEvent(ResEvent.LOADRESCOM));
			if(!this._isCreate){
				callJS();
			}
		}
		public function callJS():void
		{
			ExternalInterface.call("openFlash",this._resVo._fileCode);
		}
		override public function loadRes():void
		{
			PopUtils.createLoading();
			_swfLoader=new Loader;
			
			_swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,swfComHandler);
			_swfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,PopUtils.loadingPro)
			_swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,PopUtils.IOError);
			_swfLoader.load(new URLRequest(this._resVo._path));
		}
		private function swfComHandler(e:Event):void
		{
			_swfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,swfComHandler);
			_swfLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,PopUtils.loadingPro);
			_swfLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,PopUtils.IOError);
			_swfLoader.scrollRect=new Rectangle(0,0,_swfLoader.contentLoaderInfo.width,_swfLoader.contentLoaderInfo.height);
			var swfUI:UIMovieClip=new UIMovieClip;
			swfUI.skinName=_swfLoader;
			this.addElement(swfUI);
			swfUI.mouseChildren=true;
			swfUI.mouseEnabled=true;
			this._dragRect=swfUI;
			
			this.dispatchEvent(new ResEvent(ResEvent.LOADRESCOM));
		}
	}
}