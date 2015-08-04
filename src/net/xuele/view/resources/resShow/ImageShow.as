package net.xuele.view.resources.resShow
{
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PopUtils;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.vo.ContentVo;
	
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUtils.DomLoader;
	
	/**
	 * 图片显示 
	 * @author jianhua
	 * 
	 */
	public class ImageShow extends EditResBase
	{
		
		public function ImageShow()
		{
			super();
		}
		
		/**
		 * 创建资源 
		 * 
		 */
		override protected function createRes():void
		{
			PopUtils.createLoading();
			
			if(this._isCreate){
				DomLoader.loadBitmapData(this._contentVo._property.path,createComHandler,PopUtils.loadingPro,PopUtils.IOError);
			}else{
//				this._resVo._path="http://panfile.xuele.net/s/30393444364238414535443342313646354533383038423545433345463434362e706e67";
				DomLoader.loadBitmapData(this._resVo._path,comHandler,PopUtils.loadingPro,PopUtils.IOError);
			}
		}
		private function createComHandler(data:BitmapData):void
		{
			var ui:UIAsset=new UIAsset;
			ui.skinName=new Bitmap(data);
			this._resGroup.addElement(ui);
			ui.validateNow();
			this.drawGroup.width=ui.width;
			this.drawGroup.height=ui.height;
			if(this._contentVo._isOpen==1){
				var sclX:Number=this._contentVo._property.width/ui.width;
				var sclY:Number=this._contentVo._property.height/ui.height;
				ui.scaleX=sclX
				ui.scaleY=sclY;
				this.drawGroup.scaleX=sclX;
				this.drawGroup.scaleY=sclY;
			}
			this._dragRect=_resGroup;
			this.dispatchEvent(new ResEvent(ResEvent.LOADRESCOM));
		}
		private function comHandler(data:BitmapData):void
		{
			var ui:UIAsset=new UIAsset;
			ui.skinName=new Bitmap(data);
			this._resGroup.addElement(ui);
			this.drawGroup.width=ui.width;
			this.drawGroup.height=ui.height;
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
		
			this.drawGroup.scaleX=this.drawGroup.scaleY=scale;
			this._dragRect=_resGroup;
//			Rect(_dragRect).fillAlpha=0;
//			Rect(_dragRect).fillColor=0x000000;
//			Rect(_dragRect).width=ui.width;
//			Rect(_dragRect).height=ui.height;
//			Rect(_dragRect)..scaleX=Rect(_dragRect).scaleY=scale;
//			this.addElement(Rect(_dragRect));
			this.dispatchEvent(new ResEvent(ResEvent.LOADRESCOM));
		}
		
	}
}