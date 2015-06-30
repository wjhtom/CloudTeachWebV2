package net.xuele.view.menu.interfaces
{
	import net.xuele.view.menu.controller.MenuController;

	public interface IMenuFactory
	{
		function createMenu(c:MenuController,param:int):IItem;
	}
}