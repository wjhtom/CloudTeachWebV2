package net.xuele.view.resources.resShow
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.PopUtils;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUtils.DomLoader;
	
	/**
	 * 图片显示 
	 * @author jianhua
	 * 
	 */
	public class ImageShow extends Group implements IResShow
	{
		private var _resGroup:Group;
		private var _drawGroup:Group;
		private var _menuGroup:Group;
		private var _resVo:ResourceVo;
		/**
		 * 是否拖动（是true/否false） 
		 */
		private var _isDrag:Boolean;
		public function ImageShow()
		{
			super();
		}
		
		public function editRes():void
		{
			trace("editRes")
		}
		
		public function createUI(resVo:ResourceVo):void
		{
			this._resVo=resVo;
			var timer:Timer=new Timer(20,1);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void
		{
			Timer(e.target).removeEventListener(TimerEvent.TIMER,timerHandler);
			init();
		}
		private function init():void
		{
			createRes();
			createDraw();
			createMenu();
		}
		/**
		 * 创建画布 
		 * 
		 */
		private function createDraw():void
		{
			this._drawGroup=new Group;
			this.addElement(this._drawGroup);
		}
		
		private var _loader:Loader;
		/**
		 * 创建资源 
		 * 
		 */
		private function createRes():void
		{
			PopUtils.createLoading();
			this._resGroup=new Group;
			this.addElement(this._resGroup);
			this._loader=new Loader;
			this._resVo._path="http://panfile.xuele.net/s/42354244304533344432364642343035453136384441333035443845414246342e6a7067";
			DomLoader.loadBitmapData(this._resVo._path,comHandler,PopUtils.loadingPro,PopUtils.IOError);
		}
		private function comHandler(data:BitmapData):void
		{
			var ui:UIAsset=new UIAsset;
			ui.skinName=new Bitmap(data);
			this._resGroup.addElement(ui);
			var tempW:Number=CommondView.resShowView.width;
			var tempH:Number=CommondView.resShowView.height-50;
			if(ui.width>=tempW&&ui.height>=tempH){
				if(tempW/ui.width>tempH/ui.height){
					var scale:Number=tempH/ui.height;
				}else{
					scale=tempW/ui.width;
				}
			}else if(ui.width>=tempW&&ui.height<tempH){
				scale=tempW/ui.width;
			}else if(ui.width<tempW&&ui.height>=tempH){
				scale=tempH/ui.height;
			}else{
				scale=1;
			}
			ui.scaleX=ui.scaleY=scale;
		}
		/**
		 * 创建菜单 
		 * 
		 */
		private function createMenu():void
		{
			this._menuGroup=new Group;
			this.addElement(this._menuGroup);
		}
		
		public function resetRes():void
		{
		}
		
		public function removeListener():void
		{
			if(this._isDrag){
				this.stopDrag();
			}
		}
		
		public function startResDrag():void
		{
			this.startDrag();
		}
		public function stopResDrag():void
		{
			this.stopDrag();
		}
	}
}