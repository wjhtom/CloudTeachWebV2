package net.xuele.view.menu.view
{
	import net.xuele.view.menu.factory.MenuFactory;
	import net.xuele.view.menu.interfaces.IItem;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	public class MenuView extends Group
	{
		private var itemGroup:Group;
		public function MenuView()
		{
			super();
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
			
			var color:IItem=MenuFactory.createItem(0);
			itemGroup.addElement(color);
			itemGroup.addElement(createEmpty());
			var mouse:IItem=MenuFactory.createItem(14);
			itemGroup.addElement(mouse);
			var highlight:IItem=MenuFactory.createItem(1);
			itemGroup.addElement(highlight);
			var pencil:IItem=MenuFactory.createItem(2);
			itemGroup.addElement(pencil);
			var draw:IItem=MenuFactory.createItem(3);
			itemGroup.addElement(draw);
			var eraser:IItem=MenuFactory.createItem(4);
			itemGroup.addElement(eraser);
			var input:IItem=MenuFactory.createItem(5);
			itemGroup.addElement(input);
			var callName:IItem=MenuFactory.createItem(6);
			itemGroup.addElement(callName);
			var setTime:IItem=MenuFactory.createItem(7);
			itemGroup.addElement(setTime);
			itemGroup.addElement(createEmpty());
			var tools:IItem=MenuFactory.createItem(8);
			itemGroup.addElement(tools);
			var resBox:IItem=MenuFactory.createItem(9);
			itemGroup.addElement(resBox);
			var homework:IItem=MenuFactory.createItem(10);
			itemGroup.addElement(homework);
			var upScore:IItem=MenuFactory.createItem(11);
			itemGroup.addElement(upScore);
			var save:IItem=MenuFactory.createItem(12);
			itemGroup.addElement(save);
			var fullScreen:IItem=MenuFactory.createItem(13);
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