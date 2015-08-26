package net.xuele.view.menu.utils
{
	import net.xuele.utils.MainData;
	import net.xuele.view.menu.interfaces.IItem;
	
	import org.flexlite.domUI.components.UIMovieClip;

	public class MenuData
	{
		
		/**
		 * 是否正在输入 
		 */
		public static var _isInput:Boolean=false;
		/**
		 * 资源盒子是否打开 
		 */
		public static var _isResBoxShow:Boolean=false;
		public static var _currentMenu:UIMovieClip;
		public static var _mouseMouse:IItem;
		public static var _fullScreenUI:UIMovieClip;
//		public static var _pencilMouse:IItem;
//		public static var _drawMouse:IItem;
//		public static var _eraseMouse:IItem;
		public static var _inputMouse:IItem;
//		public static var _highlightMouse:IItem;
		public function MenuData()
		{
		}
	}
}