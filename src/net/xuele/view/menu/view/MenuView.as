package net.xuele.view.menu.view
{
	import net.xuele.view.menu.controller.MenuController;
	import net.xuele.view.menu.factory.MenuFactory;
	import net.xuele.view.menu.interfaces.IItem;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	public class MenuView extends Group
	{
		private var itemGroup:Group;
		private var _controller:MenuController;
		public function MenuView(c:MenuController)
		{
			super();
			this._controller=c;
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			createUI();
		}
		private function createUI():void
		{
			var itemLayout:HorizontalLayout=new HorizontalLayout;
			itemLayout.gap=1;
			
			itemGroup=new Group;
			itemGroup.layout=itemLayout;
			
			var color:IItem=MenuFactory.createItem(_controller,0);
			itemGroup.addElement(color);
			itemGroup.addElement(createEmpty());
			var highlight:IItem=MenuFactory.createItem(_controller,1);
			itemGroup.addElement(highlight);
			var pencil:IItem=MenuFactory.createItem(_controller,2);
			itemGroup.addElement(pencil);
			var draw:IItem=MenuFactory.createItem(_controller,3);
			itemGroup.addElement(draw);
			var eraser:IItem=MenuFactory.createItem(_controller,4);
			itemGroup.addElement(eraser);
			var input:IItem=MenuFactory.createItem(_controller,5);
			itemGroup.addElement(input);
			var callName:IItem=MenuFactory.createItem(_controller,6);
			itemGroup.addElement(callName);
			var setTime:IItem=MenuFactory.createItem(_controller,7);
			itemGroup.addElement(setTime);
			itemGroup.addElement(createEmpty());
			var tools:IItem=MenuFactory.createItem(_controller,8);
			itemGroup.addElement(tools);
			var resBox:IItem=MenuFactory.createItem(_controller,9);
			itemGroup.addElement(resBox);
			var homework:IItem=MenuFactory.createItem(_controller,10);
			itemGroup.addElement(homework);
			var upScore:IItem=MenuFactory.createItem(_controller,11);
			itemGroup.addElement(upScore);
			var save:IItem=MenuFactory.createItem(_controller,12);
			itemGroup.addElement(save);
			var fullScreen:IItem=MenuFactory.createItem(_controller,13);
			itemGroup.addElement(fullScreen);
			
			this.addElement(itemGroup);
		}
		private function createEmpty():Rect
		{
			var rect:Rect=new Rect;
			rect.width=45;
			rect.height=45;
			rect.fillAlpha=0;
			rect.fillColor=0x000000;
			return rect;
		}
	}
}