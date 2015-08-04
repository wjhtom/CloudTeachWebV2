package net.xuele.view.pages.interfaces
{
	import com.senocular.display.TransformTool;
	
	import net.xuele.view.pages.view.SmallResView;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.ImageShow;
	
	import org.flexlite.domUI.components.Group;
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
		 * @param create:是否从保存数据保存，（true:从保存数据创建。false:鼠标拖出来创建）
		 */
		function addRes(res:IResShow,create:Boolean):void;
		/**
		 * 获取当前页画布 
		 * @return 
		 * 
		 */
		function get drawGroup():Group;
		/**
		 * 获取资源容器 
		 * @return 
		 * 
		 */
		function get resGroup():Group;
		function get defaultTools():TransformTool;
		/**
		 * 从缩略图拉到黑板上 
		 * @param res
		 * 
		 */
		function getResFormSmallView(res:IResShow):void;
		function get resAry():Array;
		/**
		 * 小图容器
		 * @return 
		 * 
		 */
		function get smallResView():SmallResView;
		function removeListener():void;
	}
}