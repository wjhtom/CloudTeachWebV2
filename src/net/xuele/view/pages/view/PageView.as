package net.xuele.view.pages.view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.view.resources.utils.ResData;
	
	import org.flexlite.domUI.components.Group;
	
	public class PageView extends Group implements IBigPage
	{
		public function PageView()
		{
			super();
		}
		public function createUI():void
		{
			var timer:Timer=new Timer(20,1);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void
		{
			Timer(e.currentTarget).removeEventListener(TimerEvent.TIMER,timerHandler);
			init();
		}
		private function init():void
		{
//			this.width=stage.stageWidth;
//			this.height=stage.stageHeight-50;
			addListener();
		}
		private function addListener():void
		{
//			this.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		private function clickHandler(e:MouseEvent):void
		{
			trace(e.currentTarget);
		}
		public function addRes(res:IResShow):void
		{
			this.addElement(res);
			if(res is ImageShow || res is DocShow){
//				res.x=(stage.stageWidth-res.width)/2;
//				res.y=0;
				res.horizontalCenter=0;
				res.top=0;
			}else{
				res.x=this.mouseX;
				res.y=this.mouseY;
			}
			res.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			res.addEventListener(MouseEvent.MOUSE_UP,upHandler);
		}
		private static function resClickHandler(e:MouseEvent):void
		{
			IResShow(e.currentTarget).editRes();
		}
		private static var downTime:Number;
		private static function downHandler(e:MouseEvent):void
		{
			downTime=getTimer();
			IResShow(e.currentTarget).startResDrag();
		}
		private static function upHandler(e:MouseEvent):void
		{
			if(getTimer()-downTime<150){
				IResShow(e.currentTarget).editRes();
				ResData._currentEditRes=IResShow(e.currentTarget);
				IResShow(e.currentTarget).removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
				IResShow(e.currentTarget).removeEventListener(MouseEvent.MOUSE_UP,upHandler);
			}
			IResShow(e.currentTarget).stopResDrag();
		}
		public function createSmallPage():void
		{
		}
		
		public function removeListener():void
		{
		}
	}
}