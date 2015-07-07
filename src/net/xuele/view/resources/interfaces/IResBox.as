package net.xuele.view.resources.interfaces
{
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.core.IVisualElement;

	public interface IResBox extends IVisualElement
	{
		function createUI():void;
		function removeListener():void;
		function selected():void;
		function reSelect():void;
		function get resVo():ResourceVo;
		/**
		 * 关闭鼠标动作 
		 * 
		 */
//		function closeMouseEvent():void;
	}
}