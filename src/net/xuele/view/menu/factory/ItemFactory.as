package net.xuele.view.menu.factory
{
	import net.xuele.view.menu.interfaces.IItem;
	import net.xuele.view.menu.interfaces.IMenuFactory;
	import net.xuele.view.menu.view.ItemCallName;
	import net.xuele.view.menu.view.ItemColor;
	import net.xuele.view.menu.view.ItemDraw;
	import net.xuele.view.menu.view.ItemEraser;
	import net.xuele.view.menu.view.ItemFullScreen;
	import net.xuele.view.menu.view.ItemHighLight;
	import net.xuele.view.menu.view.ItemHomework;
	import net.xuele.view.menu.view.ItemInput;
	import net.xuele.view.menu.view.ItemMouse;
	import net.xuele.view.menu.view.ItemPencil;
	import net.xuele.view.menu.view.ItemResBox;
	import net.xuele.view.menu.view.ItemSave;
	import net.xuele.view.menu.view.ItemSetTime;
	import net.xuele.view.menu.view.ItemTools;
	import net.xuele.view.menu.view.ItemUpScore;
	import net.xuele.view.menu.view.Thickness;
	
	public class ItemFactory implements IMenuFactory
	{
		
		public function ItemFactory()
		{
		}
		/**
		 * 菜单类型 
		 * 0：选择颜色，1：高亮，2：输入文字，3：铅笔，4：画直线
		 * 5：橡皮，6：点名，7：计时器，8：工具，9：打开资源盒
		 * 10：习题作业，11：提分神器，12：保存，13：最大化,14:鼠标
		 */
		public function createMenu(param:int):IItem
		{
			var item:IItem;
			switch(param){
				case 0:
					item=new ItemColor();
					break;
				case 1:
					item=new ItemHighLight(param);
					break;
				case 2:
					item=new ItemInput(param);
					break;
				case 3:
					item=new ItemPencil(param);
					break;
				case 4:
					item=new ItemDraw(param);
					break;
				case 5:
					item=new ItemEraser(param);
					break;
				case 6:
					item=new ItemCallName(param);
					break;
				case 7:
					item=new ItemSetTime(param);
					break;
				case 8:
					item=new ItemTools(param);
					break;
				case 9:
					item=new ItemResBox(param);
					break;
				case 10:
					item=new ItemHomework(param);
					break;
				case 11:
					item=new ItemUpScore(param);
					break;
				case 12:
					item=new ItemSave(param);
					break;
				case 13:
					item=new ItemFullScreen(param);
					break;
				case 14:
					item=new ItemMouse(param);
					break;
			}
			
			return item;
		}
		public function createThickness(value:int):IItem
		{
			var item:IItem=new Thickness(value);
			return item;
		}
	}
}