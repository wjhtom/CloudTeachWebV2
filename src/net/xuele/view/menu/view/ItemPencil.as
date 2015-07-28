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
	import net.xuele.view.menu.controller.PencilController;
	import net.xuele.view.menu.factory.MenuFactory;
	import net.xuele.view.menu.utils.MenuData;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.layouts.VerticalLayout;

	/**
	 * 铅笔 
	 * @author jianhua
	 * 
	 */
	public class ItemPencil extends ItemView
	{
		private var _thicknessShow:Boolean=false;
		private var _thicknessGroup:Group;
		private var _g:Group;
		public function ItemPencil(t:int)
		{
			super(t);
			_thicknessGroup=new Group;
			var thicknessLayout:VerticalLayout=new VerticalLayout;
			thicknessLayout.gap=0;
			_thicknessGroup.layout=thicknessLayout;
		}
		
		override protected function itemClick():void
		{
			if(MainData._mouseType!=1){
				super.itemClick();
			}
			if(!this._thicknessShow&&MainData._mouseType==1){
				PublicOperate.setMouseType(0);
				DrawUtils.stopDrawPencil();
				return;
			}
			if(_thicknessShow){
				removeThickness();
				PublicOperate.setMouseType(0);
				DrawUtils.stopDrawPencil();
			}else{
				createThickness();
				addListener();
				PublicOperate.setMouseType(1);
				this._UIMovie.gotoAndStop(1);
				MenuData._currentMenu=this._UIMovie;
				DrawUtils.drawPencil();
			}
		}
		private var _thickness1:Thickness;
		private var _thickness2:Thickness;
		private var _thickness3:Thickness;
		private var _thickness4:Thickness;
		/**
		 * 当前笔触 
		 */
		private var _currentThicknessID:int;
		private var _timer:Timer;
		private function createThickness():void
		{
			_g=new Group;
			
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("ThicknessBg");
			_g.addElement(bg);
			
			for(var i:int=1;i<=4;i++){
				this["_thickness"+i]=MenuFactory.createThickness(i) as Thickness;
				this["_thickness"+i]._id=i
			}
			_thicknessGroup.addElement(this._thickness4);
			_thicknessGroup.addElement(this._thickness3);
			_thicknessGroup.addElement(this._thickness2);
			_thicknessGroup.addElement(this._thickness1);
			_g.addElement(_thicknessGroup);
			_thicknessGroup.top=15;
			CommondView.menuView.addElement(_g);
			_g.top=-135;
			_g.left=this.x+this.parent.x;
			
			this._thicknessShow=true;
			DrawData._pencilThicknessShow=true;
			PencilController.control.addEventListener(MenuEvent.HIDETHICKNESS,removeThicknessHandler);
			
			_timer=new Timer(50,1);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			_timer.start();
		}
		private function removeThicknessHandler(e:MenuEvent):void
		{
			PencilController.control.removeEventListener(MenuEvent.HIDETHICKNESS,removeThicknessHandler)
			removeThickness();
		}
		private function timerHandler(e:TimerEvent):void
		{
			this._timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			switch(DrawData._pencilThickness){
				case 1:
					this._thickness1.thicknessMovie.gotoAndStop(1);
					this._currentThicknessID=1;
					break;
				case 2:
					this._thickness2.thicknessMovie.gotoAndStop(1);
					this._currentThicknessID=2;
					break;
				case 3:
					this._thickness3.thicknessMovie.gotoAndStop(1);
					this._currentThicknessID=3;
					break;
				case 4:
					this._thickness4.thicknessMovie.gotoAndStop(1);
					this._currentThicknessID=4;
					break;
			}
		}
		private function removeThickness():void
		{
			removeListener();
			CommondView.menuView.removeElement(_g);
			this._thicknessGroup.removeAllElements();
			this._thicknessShow=false;
			
			DrawData._pencilThicknessShow=false;
		}
		private function addListener():void
		{
			for(var i:int=1;i<=4;i++){
				this["_thickness"+i].addEventListener(MouseEvent.CLICK,clickHandler);
				this["_thickness"+i].addEventListener(MouseEvent.MOUSE_OVER,overHandler);
				this["_thickness"+i].addEventListener(MouseEvent.MOUSE_OUT,outHandler);
			}
			
		}
		private function removeListener():void
		{
			for(var i:int=1;i<=4;i++){
				this["_thickness"+i].removeEventListener(MouseEvent.CLICK,clickHandler);
				this["_thickness"+i].removeEventListener(MouseEvent.MOUSE_OVER,overHandler);
				this["_thickness"+i].removeEventListener(MouseEvent.MOUSE_OUT,outHandler);
			}
		}
		private function clickHandler(e:MouseEvent):void
		{
			var thickness:UIMovieClip=Thickness(e.currentTarget).thicknessMovie;
//			if(this._currentThickness!=Thickness(e.currentTarget)){
//				this._currentThickness.thicknessMovie.gotoAndStop(0);
//				thickness.gotoAndStop(1);
				this._currentThicknessID=Thickness(e.currentTarget)._id;
				DrawData._pencilThickness=Thickness(e.currentTarget)._id;
				PublicOperate.setMouseType(1);
				this._UIMovie.gotoAndStop(1);
				DrawUtils.drawPencil();
				this.removeThickness();
//			}
		}
		private function overHandler(e:MouseEvent):void
		{
			var thickness:UIMovieClip=Thickness(e.currentTarget).thicknessMovie;
			if(this._currentThicknessID!=Thickness(e.currentTarget)._id){
				thickness.gotoAndStop(1);
			}
		}
		private function outHandler(e:MouseEvent):void
		{
			var thickness:UIMovieClip=Thickness(e.currentTarget).thicknessMovie;
			if(this._currentThicknessID!=Thickness(e.currentTarget)._id){
				thickness.gotoAndStop(0);
			}
		}
	}
}