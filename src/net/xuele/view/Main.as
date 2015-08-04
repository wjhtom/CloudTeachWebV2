package net.xuele.view
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.commond.CommondFactory;
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.view.blackboard.view.BlackboardView;
	import net.xuele.view.draw.utils.DrawData;
	import net.xuele.view.menu.view.MenuView;
	import net.xuele.view.pages.factorys.PageFactory;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.pages.interfaces.IPageFactory;
	import net.xuele.view.pages.utils.PagesData;
	import net.xuele.view.pages.view.PageNumView;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.vo.ContentVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.VerticalLayout;
	import org.flexlite.domUI.utils.callLater;
	
	public class Main extends Group
	{
		private var _bgGroup:Group;
		private var _contentGroup:Group;
//		private var _drawGroup:Group;
		private var _menuGroup:Group;
		private var _pageNumGroup:Group;
		public function Main()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			this.width=stage.stageWidth;
			this.height=stage.stageHeight;
		}
		public function createUI():void
		{
			MainData._teachType=1;
			
			_bgGroup=new Group;
			this.addElement(_bgGroup);
			_bgGroup.name="bg";
			
			_contentGroup=new Group;
//			this._contentGroup.width=stage.stageWidth;
//			this._contentGroup.height=588;
			_contentGroup.width=stage.stageWidth;
			_contentGroup.height=stage.stageHeight-50;
			this.addElement(_contentGroup);
			_contentGroup.name="content";
			_contentGroup.horizontalCenter=0;
			_contentGroup.top=0;
			_contentGroup.mouseEnabled=false;
			CommondView.resShowView=this._contentGroup;
			
			
//			_drawGroup=new Group;
//			_drawGroup.width=stage.stageWidth;
//			_drawGroup.height=588;
//			_drawGroup.addElement(rect);
//			this.addElement(_drawGroup);
//			_drawGroup.name="draw";
//			_drawGroup.horizontalCenter=0;
//			_drawGroup.top=0;
//			CommondView.drawView=_drawGroup;
//			DrawData._currentCanvas=_drawGroup;
			
			
			_menuGroup=new Group;
			_menuGroup.horizontalCenter=0;
			_menuGroup.bottom=0;
			this.addElement(_menuGroup);
			
			_pageNumGroup=new Group;
			this.addElement(_pageNumGroup);
			_pageNumGroup.mouseEnabled=false;
				
			createBG();
			createMenu();
			if(MainData.myResourcesAry.length>0&&MainData.pagesDataAry.length>0){
				createPageInfo();
			}else{
				createPage();
			}
			createPageNum();
			
		}
		private function setPageInfo():void
		{
			
		}
		private function createBG():void
		{
			var bg:BlackboardView=new BlackboardView;
			this._bgGroup.addElement(bg);
		}
		/**
		 * 创建主功能区菜单 
		 * 
		 */
		private function createMenu():void
		{
			var layout:VerticalLayout=new VerticalLayout;
			layout.gap=0;
			this._menuGroup.layout=layout;
			var menuPop:Group=new Group;
			this._menuGroup.addElement(menuPop);
			menuPop.width=stage.stageWidth;
			var menu:MenuView=new MenuView();
			this._menuGroup.addElement(menu);
//			menu.horizontalCenter=0;
//			menu.bottom=0;
			CommondView.menuView=menuPop;
			this._menuGroup.mouseEnabled=false;
			menu.mouseEnabled=false;
		}
		/**
		 * 创建页面 
		 * 
		 */
		private function createPage():void
		{
			var factory:IPageFactory=new PageFactory;
			CommondFactory._pageFactory=factory;
			var page:IBigPage=factory.createPage();
			CommondView.resShowView.addElement(page);
			Group(page).mouseEnabled=false;
			page.createUI();
			CommondView.contentView=page;
			PagesData._currentPage=page;
			PagesData._currnetPageNum++;
			PagesData._currentPageID=0;
			PagesData._pagesAry.push(page);
			var timer:Timer=new Timer(20,1);
			timer.addEventListener(TimerEvent.TIMER,getDrawView);
			timer.start();
		}
		private function getDrawView(e:TimerEvent):void
		{
			Timer(e.target).removeEventListener(TimerEvent.TIMER,getDrawView);
			DrawData._currentCanvas=CommondView.contentView.drawGroup;
		}
		/**
		 * 创建页码 
		 * 
		 */
		private function createPageNum():void
		{
			var leftPageNum:PageNumView=new PageNumView;
			_pageNumGroup.addElement(leftPageNum);
			leftPageNum.left=0;
			leftPageNum.bottom=30;
			if(MainData._teachType!=1){
				var rightPageNum:PageNumView=new PageNumView;
				_pageNumGroup.addElement(rightPageNum);
				rightPageNum.right=0;
			}
		}
		/**
		 * 页面初使化 
		 * 
		 */
		private function createPageInfo():void
		{
			PagesData._currnetPageNum=MainData.pagesDataAry.length;
			var factory:IPageFactory=new PageFactory;
			CommondFactory._pageFactory=factory;
			for(var i:int=0;i<PagesData._currnetPageNum;i++){
				var page:IBigPage=factory.createPage();
				page.createUI();
				PagesData._pagesAry.push(page);
			}
			CommondView.contentView=IBigPage(PagesData._pagesAry[0]);
			PagesData._currentPage=IBigPage(PagesData._pagesAry[0]);
			PagesData._currentPageID=0;
			
			CommondView.resShowView.addElement(IBigPage(PagesData._pagesAry[0]));
			Group(IBigPage(PagesData._pagesAry[0])).mouseEnabled=false;
			callLater(setPageInfoRes,null,2);
			
		}
		private function setPageInfoRes():void
		{
			DrawData._currentCanvas=CommondView.contentView.drawGroup;
			ResData._currentTools=IBigPage(PagesData._pagesAry[0]).defaultTools;
			var resFactory:ResFactory=new ResFactory;
			var len:int=MainData.pagesDataAry.length
			for(var i:int=0;i<len;i++){
				var len1:int=MainData.pagesDataAry[i].length;
				for(var j:int=0;j<len1;j++){
					trace(ContentVo(MainData.pagesDataAry[i][j])._name)
					var res:IResShow=resFactory.createResInfo(ContentVo(MainData.pagesDataAry[i][j]));
					IBigPage(PagesData._pagesAry[i]).addRes(res,true);
					
				}
			}
		}
		
	}
}