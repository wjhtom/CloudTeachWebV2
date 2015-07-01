package net.xuele.view.menu.factory
{
	import net.xuele.view.menu.interfaces.IItem;

	public class MenuFactory
	{
		public function MenuFactory()
		{
		}
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