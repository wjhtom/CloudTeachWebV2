package net.xuele.view.menu.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.menu.interfaces.IItem;
	
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
		 * 10：习题作业，11：提分神器，12：保存，13：最大化
		 */
		private var _menuType:int;
		private var _UIMovie:McButton;
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
					_menuType
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
				default:
					break;
			}
			this._UIMovie=new McButton;
			this._UIMovie.skinName=skin;
			this.addElement(this._UIMovie);
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
			click();
		}
		public function click():void
		{
			
		}
	}
}