package net.xuele.view
{
	import net.xuele.view.blackboard.view.BlackboardView;
	import net.xuele.view.menu.controller.MenuController;
	import net.xuele.view.menu.view.MenuView;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.events.UIEvent;
	
	public class Main extends Group
	{
		private var _bgGroup:Group;
		private var _contentGroup:Group;
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
			_contentGroup.width=stage.stageWidth;
			_contentGroup.height=stage.stageHeight;
			this.addElement(_contentGroup);
			_menuGroup=new Group;
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
			var controller:MenuController=new MenuController;
			var menu:MenuView=new MenuView(controller);
			this._contentGroup.addElement(menu);
			menu.bottom=0;
		}
		private function createPage():void
		{
			
		}
		
	}
}