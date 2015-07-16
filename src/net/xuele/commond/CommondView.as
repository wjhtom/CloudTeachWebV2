package net.xuele.commond
{
	import com.senocular.display.TransformTool;
	
	import net.xuele.view.pages.interfaces.IBigPage;
	
	import org.flexlite.domUI.components.Group;

	public class CommondView
	{
		/**
		 * 弹出层 
		 */
		public static var popView:Group;
		/**
		 *  主显区，add所有内容，位于顶级
		 */
		public static var mainView:Group;
		/**
		 * 菜单显示 
		 */
		public static var menuView:Group;
		/**
		 * 页面显示区，用于add大页面(IBigPage)
		 */
		public static var resShowView:Group;
		/**
		 *  资源显示区，用于add各类资源
		 */
		public static var contentView:IBigPage;
		/**
		 * 当前处于编辑的资源 
		 */
		public static var currentTool:TransformTool;
		public function CommondView()
		{
		}
	}
}