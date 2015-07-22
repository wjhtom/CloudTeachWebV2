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
		function createUI(resVo:ResourceVo=null):void;
		/**
		 * 打开保存的资源
		 * 用于初使化课件时用
		 * @param contentVo
		 */
		function createResInfo(contentVo:ContentVo=null):void;
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
		/**
		 * 设置当前资源ID 
		 * @param v
		 * 
		 */
		function set resID(v:String):void;
		/**
		 * 获取当前资源ID 
		 * @return 
		 * 
		 */
		function get resID():String;
		/**
		 * 设置缩放比例 X
		 * @param v
		 * 
		 */
		function set resScaleX(v:Number):void;
		/**
		 *  获取缩放比例X
		 * @return 
		 * 
		 */
		function get resScaleX():Number;
		/**
		 * 设置缩放比例Y 
		 * @param v
		 * 
		 */
		function set resScaleY(v:Number):void;
		/**
		 * 获取缩放比例Y 
		 * @return 
		 * 
		 */
		function get resScaleY():Number;
			
	}
}