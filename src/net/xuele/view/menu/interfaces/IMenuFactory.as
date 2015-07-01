package net.xuele.view.menu.interfaces
{

	public interface IMenuFactory
	{
		function createMenu(param:int):IItem;
		function createThickness(param:int):IItem;
	}
}