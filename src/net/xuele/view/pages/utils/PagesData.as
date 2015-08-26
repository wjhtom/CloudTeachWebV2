package net.xuele.view.pages.utils
{
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.resources.interfaces.IResShow;

	public class PagesData
	{
		/**
		 * 当前显示页 
		 */
		public static var _currentPage:IBigPage;
		/**
		 * 最大页数 
		 */
		public static const MAXPAGENUM:int=15;
		/**
		 * 当前总页数 
		 */
		public static var _currentPageNum:int=0;
		/**
		 * 页面内容，[IBigPage,IBigPage,IBigPage...] 
		 */
		public static var _pagesAry:Array=[];
		/**
		 * 当前页id 
		 */
		public static var _currentPageID:int;
		/**
		 * 当前输入 
		 */
		public static var _currentInput:IResShow;
		/**
		 * 当前页码
		 */
		public static var _selectPageNum:int;
		public function PagesData()
		{
		}
	}
}