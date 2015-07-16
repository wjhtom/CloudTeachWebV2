package net.xuele.view.pages.interfaces
{
	import org.flexlite.domUI.core.IVisualElement;

	public interface IPageNum extends IVisualElement
	{
		function selectedPage():void;
		function unSelectedPage():void;
		function get pageID():int;
		
	}
}