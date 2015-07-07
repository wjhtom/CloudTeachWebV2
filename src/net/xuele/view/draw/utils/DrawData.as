package net.xuele.view.draw.utils
{
	import org.flexlite.domUI.components.Group;

	public class DrawData
	{
		/**
		 * 当前用于绘图的画布 
		 */
		public static var _currentCanvas:Group;
		/**
		 * 画笔粗细 
		 */
		public static var _pencilThickness:int=1;
		/**
		 * 橡皮粗细 
		 */
		public static var _eraseThickness:int=1;
		/**
		 * 画笔粗细是否显示 
		 */
		public static var _pencilThicknessShow:Boolean=false;
		/**
		 * 橡皮粗细是否显示 
		 */
		public static var _eraseThicknessShow:Boolean=false;
		/**
		 * 直线样式是否显示 
		 */
		public static var _lineStyleShow:Boolean=false;
		/**
		 * 当前颜色 
		 */
		public static var _currentColor:uint=0x000000;
		/**
		 * 直线样式
		 * 0：箭头直线，1：虚线，2：直线，3：双直线，4：波浪线
		 */
		public static var _lineType:int;
		public function DrawData()
		{
		}
	}
}