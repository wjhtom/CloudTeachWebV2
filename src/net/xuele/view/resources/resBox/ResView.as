package net.xuele.view.resBox.view
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resBox.interfaces.IResBox;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIMovieClip;
	
	/**
	 * 单个资源 
	 * @author jianhua
	 * 
	 */
	public class ResView extends Group implements IResBox
	{
		private var _resVo:ResourceVo;
		public function ResView(resVo:ResourceVo)
		{
			super();
		}
		private var timer:Timer;
		public function createUI():void
		{
			timer=new Timer(10,1);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void
		{
			timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			create();
		}
		private function create():void
		{
			createRes();
			createName();
			addListener();
		}
		private function createRes():void
		{
			var bg:MovieClip=PublicOperate.getUI("","movieclip") as MovieClip;
			var bgUI:UIMovieClip=new UIMovieClip;
			bgUI.skinName=bg;
			bgUI.gotoAndStop(0);
			this.addElement(bgUI);
		}
		
		private function createName():void
		{
		}
		
		private function addListener():void
		{
		}
		public function removeListener():void
		{
			
		}
	}
}