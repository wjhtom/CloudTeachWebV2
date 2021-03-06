package net.xuele.view.menu.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import net.xuele.commond.CommondView;
	import net.xuele.commond.MenuEvent;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.draw.utils.DrawData;
	import net.xuele.view.draw.utils.DrawUtils;
	import net.xuele.view.menu.controller.EraseController;
	import net.xuele.view.menu.controller.LineController;
	import net.xuele.view.menu.controller.PencilController;
	import net.xuele.view.menu.interfaces.IItem;
	import net.xuele.view.menu.utils.MenuData;
	import net.xuele.view.pages.utils.InputUtil;
	import net.xuele.view.resources.resBox.ResBoxView;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResDrawUtil;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	
	public class ItemView extends Group implements IItem
	{
		/**
		 * 菜单类型 
		 * 0：选择颜色，1：高亮，2：输入文字，3：铅笔，4：画直线
		 * 5：橡皮，6：点名，7：计时器，8：工具，9：打开资源盒
		 * 10：习题作业，11：提分神器，12：保存，13：最大化,14:鼠标
		 */
		private var _menuType:int;
		protected var _UIMovie:UIMovieClip;
		public function ItemView(t:int)
		{
			super();
			_menuType=t;
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
			addListener();
		}
		public function createUI():void
		{
			var skin:MovieClip;
			switch(_menuType){
				case 0:
					skin=PublicOperate.getUI("MenuColor","movieclip") as MovieClip;
					break;
				case 1:
					skin=PublicOperate.getUI("MenuHighlight","movieclip") as MovieClip;
					break;
				case 2:
					skin=PublicOperate.getUI("MenuInput","movieclip") as MovieClip;
					break;
				case 3:
					skin=PublicOperate.getUI("MenuPencil","movieclip") as MovieClip;
					break;
				case 4:
					skin=PublicOperate.getUI("MenuDraw","movieclip") as MovieClip;
					break;
				case 5:
					skin=PublicOperate.getUI("MenuEraser","movieclip") as MovieClip;
					break;
				case 6:
					skin=PublicOperate.getUI("MenuCallName","movieclip") as MovieClip;
					break;
				case 7:
					skin=PublicOperate.getUI("MenuSetTime","movieclip") as MovieClip;
					break;
				case 8:
					skin=PublicOperate.getUI("MenuTools","movieclip") as MovieClip;
					break;
				case 9:
					skin=PublicOperate.getUI("MenuResBox","movieclip") as MovieClip;
					break;
				case 10:
					skin=PublicOperate.getUI("MenuHomework","movieclip") as MovieClip;
					break;
				case 11:
					skin=PublicOperate.getUI("MenuUpScore","movieclip") as MovieClip;
					break;
				case 12:
					skin=PublicOperate.getUI("MenuSave","movieclip") as MovieClip;
					break;
				case 13:
					skin=PublicOperate.getUI("MenuFullScreen","movieclip") as MovieClip;
					break;
				case 14:
					skin=PublicOperate.getUI("MenuMouse","movieclip") as MovieClip;
				default:
					break;
			}
			this._UIMovie=new UIMovieClip;
			this._UIMovie.skinName=skin;
			this.addElement(this._UIMovie);
			this._UIMovie.gotoAndStop(0);
		}
		private function addListener():void
		{
			this._UIMovie.addEventListener(MouseEvent.CLICK,clickHandler)
		}
		private function clickHandler(e:MouseEvent):void
		{
			itemClick();
		}
		protected function itemClick():void
		{
			initMouseType();
			initMenu();
		}
		/**
		 * 初使化菜单  
		 * 
		 */
		private function initMenu():void
		{
			if(MenuData._isResBoxShow){
//				ResBoxView(CommondView.menuView.getElementAt(0)).removeListener();
				var resBox:ResBoxView=ResBoxView(CommondView.popView.getChildByName("resBox"));
				resBox.removeListener();
				CommondView.popView.removeElement(resBox);
				MenuData._isResBoxShow=false;
			}
			if(DrawData._eraseThicknessShow){
				EraseController.control.dispatchEvent(new MenuEvent(MenuEvent.HIDETHICKNESS));
				DrawData._eraseThicknessShow=false;
			}
			if(DrawData._pencilThicknessShow){
				PencilController.control.dispatchEvent(new MenuEvent(MenuEvent.HIDETHICKNESS));
				DrawData._pencilThicknessShow=false;
			}
			CommondView.menuView.removeAllElements();
		}
		/**
		 * 初使化鼠标类型 
		 * 
		 */
		private function initMouseType():void
		{
			if(MainData._mouseType==0){
				return;
			}
			switch(MainData._mouseType){
				case 1:
					if(DrawData._pencilThicknessShow){
						PencilController.control.dispatchEvent(new MenuEvent(MenuEvent.HIDETHICKNESS));
					}
					DrawUtils.stopDrawPencil();
					break;
				case 2:
					if(DrawData._lineStyleShow){
						LineController.control.dispatchEvent(new MenuEvent(MenuEvent.HIDETLINESTYLE));
					}
					DrawUtils.stopDrawLine();
					break;
				case 3:
					if(DrawData._eraseThicknessShow){
						EraseController.control.dispatchEvent(new MenuEvent(MenuEvent.HIDETHICKNESS));
					}
					DrawUtils.stopDrawPencil();
					break;
				case 4:
					InputUtil.stopInput();
					break;
				case 6:
				case 7:
					if(ResData._currentTools!=null){
						ResData._currentTools.moveEnabled=true;
					}
					ResDrawUtil.stopDrawPencil();
					break;
				default:
					break;
			}
			PublicOperate.setMouseType(0);
			
		}
		public function get contentMovie():UIMovieClip
		{
			trace(_UIMovie.parent,_menuType)
			return this._UIMovie;
		}
		public function click():void
		{
			
		}
	}
}