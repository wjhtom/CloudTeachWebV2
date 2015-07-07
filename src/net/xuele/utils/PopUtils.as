package net.xuele.utils
{
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	import net.xuele.commond.CommonControl;
	import net.xuele.commond.CommondView;
	import net.xuele.factory.AlertFactory;
	import net.xuele.factory.PopFactory;
	import net.xuele.interfaces.IPop;
	import net.xuele.interfaces.IPopFactory;
	import net.xuele.view.loading.LoadingEvent;
	import net.xuele.view.loading.factory.LoadingFactory;
	import net.xuele.view.loading.utils.LoadingData;
	import net.xuele.view.loading.view.LoadingPop;

	public class PopUtils
	{
		public function PopUtils()
		{
		}
		public static function IOError(e:IOErrorEvent=null,n:int=0):void
		{
			trace(e.errorID)
			var p:IPop=CommondView.popView.getChildByName("loading") as LoadingPop;
			if(p!=null){
				p.removeUI();
			}
			setAlert("加载错误");
		}
		private static function setAlert(str:String):void
		{
			var alert:IPopFactory=new AlertFactory(str);
			PopFactory.createPop(alert);
		}
		public static function createLoading():void
		{
			var loading:IPopFactory=new LoadingFactory;
			PopFactory.createPop(loading);
			
		}
		public static function loadingPro(e:ProgressEvent,n:int=0):void
		{
			LoadingData.loadingNum=Math.floor(e.bytesLoaded/e.bytesTotal*100);
			CommonControl.control.dispatchEvent(new LoadingEvent(LoadingEvent.CHANGEPROVALUE));
		}
		public static function upPop(pop:IPop):void
		{
			
			if(pop){
				PopFactory.unPop(pop);
			}
		}
		
	}
}