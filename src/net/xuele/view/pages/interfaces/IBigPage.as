package net.xuele.view.pages.interfaces
{
	import net.xuele.view.resources.interfaces.IResShow;
	
	import org.flexlite.domUI.core.IVisualElement;
	
	public interface IBigPage extends IVisualElement
	{
		function createUI():void;
		/**
		 * 创建缩略图 
		 * 
		 */
		function createSmallPage():void;
		/**
		 * 添加资源 
		 * @param res
		 * 
		 */
		function addRes(res:IResShow):void;
		function removeListener():void;
	}
}