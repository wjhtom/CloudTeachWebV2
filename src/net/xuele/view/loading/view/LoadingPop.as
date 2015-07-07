package net.xuele.view.loading.view
{
	import flash.filters.DropShadowFilter;
	
	import net.xuele.commond.CommonControl;
	import net.xuele.interfaces.IPop;
	import net.xuele.utils.PopUtils;
	import net.xuele.view.loading.LoadingEvent;
	import net.xuele.view.loading.controller.LoadingController;
	import net.xuele.view.loading.model.LoadingModel;
	import net.xuele.view.loading.skins.LoadingSkin;
	import net.xuele.view.loading.utils.LoadingData;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.ProgressBar;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.events.UIEvent;
	
	public class LoadingPop extends Group implements IPop
	{
		private var _model:LoadingModel;
		private var _controller:LoadingController;
		private var proBar:ProgressBar;
		public function LoadingPop(m:LoadingModel,c:LoadingController)
		{
			super();
			this._model=m;
			this._controller=c;
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		public function createUI():void
		{
			var filter:DropShadowFilter=new DropShadowFilter;
			filter.alpha=0.5;
			filter.color=0x666666;
			
			var bg:Rect=new Rect;
			bg.width=300;
			bg.height=100;
			bg.fillAlpha=1;
			bg.fillColor=0xffffff;
			this.addElement(bg);
			bg.filters=[filter];
			
			
			proBar=new ProgressBar;
			proBar.skinName=LoadingSkin;
			proBar.width=250;
//			proBar.value=50;
			proBar.horizontalCenter=proBar.verticalCenter=0;
			this.addElement(proBar);
			
			CommonControl.control.addEventListener(LoadingEvent.CHANGEPROVALUE,setValue);
		}
		public function setValue(e:LoadingEvent):void
		{
			if(LoadingData.loadingNum>=100){
				removeUI();
			}else{
				this._controller.setProValue(proBar);
			}
		}
		public function removeUI():void
		{
			CommonControl.control.removeEventListener(LoadingEvent.CHANGEPROVALUE,setValue);
			PopUtils.upPop(this);
		}
	}
}