package net.xuele.view.menu.interfaces
{
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.core.IVisualElement;

	public interface IItem extends IVisualElement
	{
		function createUI():void;
		function get contentMovie():UIMovieClip;
	}
}