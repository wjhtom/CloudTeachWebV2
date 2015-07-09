package net.xuele.view.resources.resShow
{
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.PopUtils;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUtils.DomLoader;
	
	/**
	 * 图片显示 
	 * @author jianhua
	 * 
	 */
	public class ImageShow extends EditResBase
	{
//		private var _resVo:ResourceVo;
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
	}
}