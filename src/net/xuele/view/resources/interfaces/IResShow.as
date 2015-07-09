package net.xuele.view.resources.interfaces
{
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.IVisualElement;

	public interface IResShow extends IVisualElement
	{
		
		/**
		 * 创建资源 
		 * @param resVo
		 * 
		 */
		function createUI(resVo:ResourceVo):void;
		/**
		 * 重置资源 
		 * 
		 */
		function resetRes():void;
		/**
		 * 移除事件 
		 * 
		 */
		function removeListener():void;
		/**
		 * 获取资源画布 
		 * @return 
		 * 
		 */
		function get drawGroup():Group;
	}
}