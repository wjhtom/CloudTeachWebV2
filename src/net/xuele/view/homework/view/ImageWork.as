package net.xuele.view.homework.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.PopUtils;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUtils.DomLoader;
	
	public class ImageWork extends Group
	{
		private var _resVo:ResourceVo
		public function ImageWork(rVo:ResourceVo)
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			createUI();
		}
		private function createUI():void
		{
			DomLoader.loadBitmapData(this._resVo._path,comHandler,PopUtils.loadingPro,PopUtils.IOError);
		}
		private function comHandler(data:BitmapData):void
		{
			var ui:UIAsset=new UIAsset;
			ui.skinName=new Bitmap(data);
			this.addElement(ui);
			var tempW:Number=590;
			var tempH:Number=310;
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
	}
}