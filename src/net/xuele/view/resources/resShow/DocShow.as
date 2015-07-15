package net.xuele.view.resources.resShow
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PopUtils;
	import net.xuele.view.resources.events.ResEvent;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.UIMovieClip;
	
	
	/**
	 * 文档显示 
	 * @author jianhua
	 * 
	 */
	public class DocShow extends EditResBase
	{
		private var _docMovie:UIMovieClip;
		private var _loader:Loader;
		private var _currentFrame:int;
		
		private var _preBtn:McButton;
		private var _nextBtn:McButton;
		public function DocShow()
		{
			super();
		}
		override protected function createRes():void
		{
			PopUtils.createLoading();
			this._resVo._path="http://panfile.xuele.net/s/38364537433930303939334135453545333146333339443542304645363835322e707074";
			_loader=new Loader;
			var request:URLRequest=new URLRequest;
			request.contentType="application/x-shockwave-flash";
			if(this._isCreate){
				request.url=this._contentVo._property.path;
			}else{
				request.url=this._resVo._path;
			}
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,PopUtils.IOError);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,PopUtils.loadingPro);
			var lc:LoaderContext=new LoaderContext;
			lc.securityDomain=SecurityDomain.currentDomain;
			if(MainData._isOnline){
				_loader.load(request,lc);
			}else{
				_loader.load(request);
			}
			
		}
		private function loadComHandler(e:Event):void
		{
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComHandler);
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,PopUtils.IOError);
			this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,PopUtils.loadingPro);
			this._docMovie=new UIMovieClip;
			this._docMovie.skinName=MovieClip(_loader.content);
			this.addElement(_docMovie);
			if(this._isCreate){
				createCom();
			}else{
				loadCom();
			}
			addListener();
		}
		private function loadCom():void
		{
			var tempW:Number=CommondView.resShowView.width;
			var tempH:Number=CommondView.resShowView.height-50;
			if(_docMovie.width>=tempW&&_docMovie.height>=tempH){
				if(tempW/_docMovie.width>tempH/_docMovie.height){
					var scale:Number=tempH/_docMovie.height;
				}else{
					scale=tempW/_docMovie.width;
				}
			}else if(_docMovie.width>=tempW&&_docMovie.height<tempH){
				scale=tempW/_docMovie.width;
			}else if(_docMovie.width<tempW&&_docMovie.height>=tempH){
				scale=tempH/_docMovie.height;
			}else{
				scale=1;
			}
			_docMovie.scaleX=_docMovie.scaleY=scale;
			
			this._currentFrame=0;
			this._docMovie.gotoAndStop(_currentFrame);
			
			var docGroup:Group=new Group;
			docGroup.width=this._docMovie.width;
			docGroup.height=this._docMovie.height;
			docGroup.addElement(this._docMovie);
			_preBtn=new McButton;
			_nextBtn=new McButton;
			docGroup.addElement(_preBtn);
			_preBtn.left=0;
			docGroup.addElement(_nextBtn);
			_nextBtn.right=0;
			this._resGroup.addElement(docGroup);
			
			this.drawGroup.width=_docMovie.width;
			this.drawGroup.height=_docMovie.height;
			this.drawGroup.scaleX=this.drawGroup.scaleY=scale;
			this._dragRect=this._docMovie;
			this.dispatchEvent(new ResEvent(ResEvent.LOADRESCOM));
			
		}
		private function addListener():void
		{
			_preBtn.addEventListener(MouseEvent.CLICK,preHandler);
			_nextBtn.addEventListener(MouseEvent.CLICK,nextHandler);
		}
		private function createCom():void
		{
			
		}
		private function preHandler(e:MouseEvent):void
		{
			if(this._docMovie.currentFrame>0){
				this._currentFrame--;
				this._docMovie.gotoAndStop(this._currentFrame);
			}
		}
		private function nextHandler(e:MouseEvent):void
		{
			if(this._currentFrame<this._docMovie.totalFrames-1){
				this._currentFrame++;
				this._docMovie.gotoAndStop(this._currentFrame);
			}
		}
		override public function removeListener():void
		{
			_preBtn.removeEventListener(MouseEvent.CLICK,preHandler);
			_nextBtn.removeEventListener(MouseEvent.CLICK,nextHandler);
		}
	}
}