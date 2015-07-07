package net.xuele.view
{
	import net.xuele.commond.CommondView;
	import net.xuele.view.blackboard.view.BlackboardView;
	import net.xuele.view.draw.utils.DrawData;
	import net.xuele.view.menu.view.MenuView;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
	public class Main extends Group
	{
		private var _bgGroup:Group;
		private var _contentGroup:Group;
		private var _drawGroup:Group;
		private var _menuGroup:Group;
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
			
			_bgGroup=new Group;
			this.addElement(_bgGroup);
			
			_contentGroup=new Group;
			this._contentGroup.width=920;
			this._contentGroup.height=588;
			_contentGroup.width=stage.stageWidth;
			_contentGroup.height=stage.stageHeight-50;
			this.addElement(_contentGroup);
			_contentGroup.horizontalCenter=0;
			_contentGroup.top=0;
			CommondView.resShowView=this._contentGroup;
			
			_drawGroup=new Group;
			_drawGroup.width=stage.stageWidth;
			_drawGroup.height=588;
			var rect:Rect=new Rect;
			rect.width=100;
			rect.height=400;
			rect.fillAlpha=1;
			rect.fillColor=0xff0000;
			_drawGroup.addElement(rect);
//			rect.horizontalCenter=0;
			rect.bottom=0;
			this.addElement(_drawGroup);
//			_drawGroup.horizontalCenter=0;
			_drawGroup.top=0;
			CommondView.drawView=_drawGroup;
			DrawData._currentCanvas=_drawGroup;
			
			
			_menuGroup=new Group;
			_menuGroup.horizontalCenter=0;
			_menuGroup.bottom=0;
			this.addElement(_menuGroup);
			
			
				
			createBG();
			createMenu();
			createPage();
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
			
		}
		
	}
}