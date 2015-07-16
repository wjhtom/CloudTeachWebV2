package net.xuele.view.resources.interfaces
{
	import net.xuele.vo.ContentVo;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.core.IVisualElement;
	import org.flexlite.domUI.core.UIComponent;

	public interface IResShow extends IVisualElement
	{
		
		/**
		 * 创建新资源 
		 * 用于从资源盒拖出
		 * @param resVo
		 * 
		 */
		function createUI(resVo:ResourceVo):void;
		/**
		 * 打开保存的资源
		 * 用于初使化课件时用
		 * @param contentVo
		 */
		function createResInfo(contentVo:ContentVo):void;
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
		/**
		 * 是否缩小 
		 * @return 
		 * 
		 */
		function get isOpen():Boolean;
		/**
		 * 是否缩小 
		 * @return 
		 * 
		 */
		function set isOpen(value:Boolean):void;
		/**
		 * 获取鼠标拖动区域 
		 * @return 
		 * 
		 */
		function get dragGroup():UIComponent;
			
	}
}