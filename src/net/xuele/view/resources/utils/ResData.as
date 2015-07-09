package net.xuele.view.resources.utils
{
	import com.senocular.display.TransformTool;
	
	import net.xuele.view.resources.interfaces.IResShow;

	public class ResData
	{
		/**
		 * 0:系统资源，1：用户资源 
		 */
		public static var _currentResBox:int=0;
		/**
		 * 导入资源类型 0：全部
		 */
		public static var _currentResAll:int=0;
		/**
		 * 当前编辑资源 
		 */
		public static var _currentEditRes:IResShow;
		/**
		 *  
		 */
		public static var _currentTools:TransformTool;
		public function ResData()
		{
		}
	}
}