package net.xuele.interfaces
{
	import org.flexlite.domUI.core.IVisualElement;

	public interface IPop extends IVisualElement
	{
		function createUI():void;
		function removeUI():void;
	}
}