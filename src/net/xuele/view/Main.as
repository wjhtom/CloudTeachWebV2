package net.xuele.view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
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
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
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
			createPage();
			createPageNum();
		}
		private function createBG():void
		{
			var bg:BlackboardView=new BlackboardView;
			this._bgGroup.addElement(bg);
		}
		private function createMenu():void
		{
			var layout:VerticalLayout=new VerticalLayout;
			layout.gap=0;
			this._menuGroup.layout=layout;
			var menuPop:Group=new Group;
			this._menuGroup.addElement(menuPop);
			var menu:MenuView=new MenuView();
			this._menuGroup.addElement(menu);
//			menu.horizontalCenter=0;
//			menu.bottom=0;
			CommondView.menuView=menuPop;
		}
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
			var timer:Timer=new Timer(20,1);
			timer.addEventListener(TimerEvent.TIMER,function(e:TimerEvent):void{getDrawView(e,page)});
			timer.start();
			
		}
		private function getDrawView(e:TimerEvent,page:IBigPage):void
		{
			Timer(e.target).removeEventListener(TimerEvent.TIMER,function(e:TimerEvent):void{getDrawView(e,page)});
			DrawData._currentCanvas=page.drawGroup;
		}
		private function createPageNum():void
		{
			var leftPageNum:PageNumView=new PageNumView;
			_pageNumGroup.addElement(leftPageNum);
			leftPageNum.left=0;
			if(MainData._teachType!=1){
				var rightPageNum:PageNumView=new PageNumView;
				_pageNumGroup.addElement(rightPageNum);
				rightPageNum.right=0;
			}
		}
		
	}
}