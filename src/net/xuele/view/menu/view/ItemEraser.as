package net.xuele.view.menu.view
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.commond.MenuEvent;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.draw.utils.DrawData;
	import net.xuele.view.draw.utils.DrawUtils;
	import net.xuele.view.menu.controller.EraseController;
	import net.xuele.view.menu.controller.PencilController;
	import net.xuele.view.menu.factory.MenuFactory;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.layouts.VerticalLayout;

	/**
	 * 橡皮擦 
	 * @author jianhua
	 * 
	 */
	public class ItemEraser extends ItemView
	{
		private var _thicknessShow:Boolean=false;
		public function ItemEraser(t:int)
		{
			super(t);
			_thicknessGroup=new Group;
			var thicknessLayout:VerticalLayout=new VerticalLayout;
			thicknessLayout.gap=0;
			_thicknessGroup.layout=thicknessLayout;
		}
		override protected function itemClick():void
		{
			if(MainData._mouseType!=3){
				super.itemClick();
			}
			if(this._thicknessShow){
				removeThickness();
				PublicOperate.setMouseType(0);
				DrawUtils.stopDrawPencil();
			}else{
				createThickness();
				addListener();
				PublicOperate.setMouseType(3);
				DrawUtils.drawPencil();
			}
		}
		private var _thickness1:Thickness;
		private var _thickness2:Thickness;
		private var _thickness3:Thickness;
		
		private var _thicknessGroup:Group;
		private var _timer:Timer;
		private function createThickness():void
		{
			for(var i:int=1;i<=3;i++){
				this["_thickness"+i]=MenuFactory.createThickness(i) as Thickness;
				this["_thickness"+i]._id=i;
			}
			this._thicknessGroup.addElement(this._thickness3);
			this._thicknessGroup.addElement(this._thickness2);
			this._thicknessGroup.addElement(this._thickness1);
			
			CommondView.menuView.addElement(_thicknessGroup);
			_thicknessGroup.top=-105;
			_thicknessGroup.left=this.x;
			_timer=new Timer(50,1);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			_timer.start();
			
			this._thicknessShow=true;
			DrawData._eraseThicknessShow=true;
			EraseController.control.addEventListener(MenuEvent.HIDETHICKNESS,removeThicknessHandler);
		}
		private function removeThicknessHandler(e:MenuEvent):void
		{
			EraseController.control.removeEventListener(MenuEvent.HIDETHICKNESS,removeThicknessHandler);
			removeThickness();
		}
		private function timerHandler(e:TimerEvent):void
		{
			this._timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			switch(DrawData._eraseThickness){
				case 1:
					this._thickness1.thicknessMovie.gotoAndStop(1);
					break;
				case 2:
					this._thickness2.thicknessMovie.gotoAndStop(1);
					break;
				case 3:
					this._thickness3.thicknessMovie.gotoAndStop(1);
					break;
			}
		}
		private function removeThickness():void
		{
			removeListener();
			this._thicknessGroup.removeAllElements();
			this._thicknessShow=false;
			DrawData._eraseThicknessShow=false;
		}
		private function addListener():void
		{
			for(var i:int=1;i<=3;i++){
				this["_thickness"+i].addEventListener(MouseEvent.CLICK,clickHandler);
				this["_thickness"+i].addEventListener(MouseEvent.MOUSE_OVER,overHandler);
				this["_thickness"+i].addEventListener(MouseEvent.MOUSE_OUT,outHandler);
			}
			
		}
		private function removeListener():void
		{
			for(var i:int=1;i<=3;i++){
				this["_thickness"+i].removeEventListener(MouseEvent.CLICK,clickHandler);
				this["_thickness"+i].removeEventListener(MouseEvent.MOUSE_OVER,overHandler);
				this["_thickness"+i].removeEventListener(MouseEvent.MOUSE_OUT,outHandler);
			}
		}
		private function clickHandler(e:MouseEvent):void
		{
			var thickness:UIMovieClip=Thickness(e.currentTarget).thicknessMovie;
			DrawData._eraseThickness=Thickness(e.currentTarget)._id;
			PublicOperate.setMouseType(3);
			DrawUtils.drawPencil();
			this.removeThickness();
		}
		private function overHandler(e:MouseEvent):void
		{
			var thickness:UIMovieClip=Thickness(e.currentTarget).thicknessMovie;
			if(DrawData._eraseThickness!=Thickness(e.currentTarget)._id){
				thickness.gotoAndStop(1);
			}
		}
		private function outHandler(e:MouseEvent):void
		{
			var thickness:UIMovieClip=Thickness(e.currentTarget).thicknessMovie;
			if(DrawData._eraseThickness!=Thickness(e.currentTarget)._id){
				thickness.gotoAndStop(0);
			}
		}
	}
}