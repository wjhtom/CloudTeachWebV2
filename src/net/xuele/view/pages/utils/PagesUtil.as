package net.xuele.view.pages.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.draw.utils.DrawData;
	import net.xuele.view.pages.factorys.PageFactory;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.pages.interfaces.IPageFactory;
	import net.xuele.view.pages.view.PageView;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResTransform;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.utils.callLater;

	public class PagesUtil
	{
		public function PagesUtil()
		{
		}
		/**
		 * 切换页面 
		 * @param v 要显示的页面ID
		 * 
		 */
		public static function changeBigPage(v:int):void
		{
			if(ResData._currentEditRes!=null){
				ResTransform.removeTransRes();
			}
			CommondView.resShowView.removeElement(PagesData._currentPage);
			PagesData._currentPage=PagesData._pagesAry[v];
			trace(PagesData._currentPage,CommondView.resShowView,v,PagesData._pagesAry[v])
			CommondView.resShowView.addElement(PagesData._currentPage);
			PagesData._currentPageID=v;
			CommondView.contentView=PagesData._currentPage;
			ResData._currentTools=PagesData._currentPage.defaultTools;
			var timer:Timer=new Timer(20,1);
			timer.addEventListener(TimerEvent.TIMER,setCanvas);
			timer.start();
		}
		private static function setCanvas(e:TimerEvent):void
		{
			Timer(e.target).removeEventListener(TimerEvent.TIMER,setCanvas);
			DrawData._currentCanvas=CommondView.contentView.drawGroup;
		}
		public static function addPage():void
		{
			PublicOperate.setMouseType(0);
			var pageFactory:IPageFactory=new PageFactory;
			var page:IBigPage=pageFactory.createPage();
			
			Group(page).mouseEnabled=false;
			page.createUI();
			PagesData._pagesAry.push(page);
			PagesData._currnetPageNum++;
			changeBigPage(PagesData._currnetPageNum-1);
		}
		public static function delPage(v:int):void
		{
			trace(v,"PageUtils")
			PublicOperate.setMouseType(0);
			PagesData._pagesAry.splice(v,1);
			if(v>0){
				changeBigPage(v-1);
			}else{
				changeBigPage(v);
			}
			
			PagesData._currnetPageNum--;
		}
		/**
		 * 交换页面 
		 * 
		 */
		public static function exChangePage(currentID:int,changeID:int):void
		{
			
		}
	}
}