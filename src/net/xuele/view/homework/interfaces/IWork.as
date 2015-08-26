package net.xuele.view.homework.interfaces
{
	import net.xuele.vo.HomeworkListVo;
	
	import org.flexlite.domUI.core.IVisualElement;

	public interface IWork extends IVisualElement
	{
		function get workVo():HomeworkListVo;
	}
}