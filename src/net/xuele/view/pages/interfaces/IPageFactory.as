package net.xuele.view.pages.interfaces
{
	public interface IPageFactory
	{
		function createPage():IBigPage;
		function removePage(page:IBigPage):void;
	}
}