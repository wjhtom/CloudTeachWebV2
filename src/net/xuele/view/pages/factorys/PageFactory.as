package net.xuele.view.pages.factorys
{
	import net.xuele.commond.CommondView;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.pages.interfaces.IPageFactory;
	import net.xuele.view.pages.view.PageView;
	
	public class PageFactory implements IPageFactory
	{
		public function PageFactory()
		{
		}
		
		public function createPage():IBigPage
		{
			return new PageView;
		}
		
		public function removePage(page:IBigPage):void
		{
			CommondView.resShowView.removeElement(page);
		}
	}
}