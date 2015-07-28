package net.xuele.view.menu.factory
{
	import net.xuele.view.menu.interfaces.IItem;

	public class MenuFactory
	{
		public function MenuFactory()
		{
		}
		
		/**
		 * 菜单类型 
		 * 0：选择颜色，1：高亮，2：输入文字，3：铅笔，4：画直线
		 * 5：橡皮，6：点名，7：计时器，8：工具，9：打开资源盒
		 * 10：习题作业，11：提分神器，12：保存，13：最大化,14:鼠标
		 */
		public static function createItem(value:int):IItem
		{
			var factory:ItemFactory=new ItemFactory;
			return factory.createMenu(value);
		}
		public static function createThickness(value:int):IItem
		{
			var factory:ItemFactory=new ItemFactory;
			return factory.createThickness(value);
		}
	}
}