package net.xuele.view.menu.factory
{
	import net.xuele.view.menu.controller.MenuController;
	import net.xuele.view.menu.interfaces.IItem;

	public class MenuFactory
	{
		public function MenuFactory()
		{
		}
		public static function createItem(c:MenuController,value:int):IItem
		{
			var factory:ItemFactory=new ItemFactory;
			return factory.createMenu(c,value);
		}
	}
}