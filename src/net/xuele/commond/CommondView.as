package net.xuele.commond
{
	import com.senocular.display.TransformTool;
	
	import net.xuele.view.pages.interfaces.IBigPage;
	
	import org.flexlite.domUI.components.Group;

	public class CommondView
	{
		public static var popView:Group;
		public static var mainView:Group;
		public static var drawView:Group;
		public static var menuView:Group;
		public static var resShowView:Group;
		public static var contentView:IBigPage;
		public static var currentTool:TransformTool;
		public function CommondView()
		{
		}
	}
}