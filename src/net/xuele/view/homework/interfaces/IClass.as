package net.xuele.view.homework.interfaces
{
	import net.xuele.vo.HomeworkClassVo;
	
	import org.flexlite.domUI.core.IVisualElement;

	public interface IClass extends IVisualElement
	{
		function get classVo():HomeworkClassVo;
		function get isSelected():Boolean;
		function selectClass():void;
		function unSelectClass():void;
		
			
	}
}