package net.xuele.view.resources.interfaces
{
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.core.IVisualElement;

	public interface IResShow extends IVisualElement
	{
		/**
		 * 编辑资源（图片资源用） 
		 * 
		 */
		function editRes():void;
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
		 * 开始拖动 
		 * 
		 */
		function startResDrag():void;
		/**
		 * 停止拖动 
		 * 
		 */
		function stopResDrag():void;
	}
}