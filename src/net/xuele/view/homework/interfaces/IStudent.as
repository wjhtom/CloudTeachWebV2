package net.xuele.view.homework.interfaces
{
	import net.xuele.vo.StudentVo;
	
	import org.flexlite.domUI.core.IVisualElement;

	public interface IStudent extends IVisualElement
	{
		function get studentVo():StudentVo;
		function selected():void;
		function unSelect():void;
		function get isSelected():Boolean;
		function set isSelected(v:Boolean):void;
	}
}