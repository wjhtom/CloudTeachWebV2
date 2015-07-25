package net.xuele.view.resources.interfaces
{
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.core.IVisualElement;

	public interface IResBox extends IVisualElement
	{
		function createUI():void;
		function removeListener():void;
		/**
		 * 选择 
		 * 
		 */
		function selected():void;
		/**
		 * 取消选择 
		 * 
		 */
		function unSelect():void;
		function get resVo():ResourceVo;
		/**
		 * 关闭鼠标动作 
		 * 
		 */
//		function closeMouseEvent():void;
	}
}