package net.xuele.view.pages.view
{
	import net.xuele.view.pages.interfaces.IPageNum;
	
	import org.flexlite.domUI.components.Group;
	
	public class PageNum extends Group implements IPageNum
	{
		public function PageNum()
		{
			super();
		}
		
		public function selectedPage():void
		{
		}
		
		public function unSelectedPage():void
		{
		}
		
		public function get pageID():int
		{
			return 0;
		}
	}
}