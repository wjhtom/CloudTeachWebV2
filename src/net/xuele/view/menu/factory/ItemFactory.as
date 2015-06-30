package net.xuele.view.menu.factory
{
	import net.xuele.view.menu.interfaces.IItem;
	import net.xuele.view.menu.interfaces.IMenuFactory;
	import net.xuele.view.menu.view.ItemView;
	
	public class ItemFactory implements IMenuFactory
	{
		
		public function ItemFactory()
		{
		}
		public function createMenu(param:int):IItem
		{
			var item:IItem=new ItemView(param);
			return item;
		}
	}
}