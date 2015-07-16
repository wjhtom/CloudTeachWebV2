package net.xuele.view.pages.utils
{
	import net.xuele.view.pages.interfaces.IBigPage;

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
		public static var _currnetPageNum:int=0;
		/**
		 * 页面内容，[IBigPage,IBigPage,IBigPage...] 
		 */
		public static var _pagesAry:Array=[];
		public function PagesData()
		{
		}
	}
}