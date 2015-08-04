package net.xuele.view.menu.view
{
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.menu.factory.MenuFactory;
	import net.xuele.view.menu.interfaces.IItem;
	import net.xuele.view.menu.utils.MenuData;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.utils.callLater;
	
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
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("MenuBg");
			this.addElement(bg);
			bg.bottom=0;
			
			
			var itemLayout:HorizontalLayout=new HorizontalLayout;
			itemLayout.gap=5;
			
			itemGroup=new Group;
			itemGroup.layout=itemLayout;
			
			if(MainData._teachType==2){
				var setTime:IItem=MenuFactory.createItem(7);
				itemGroup.addElement(setTime);
				
				var callName:IItem=MenuFactory.createItem(6);
				itemGroup.addElement(callName);
			}
			
			
			
			var eraser:IItem=MenuFactory.createItem(4);
			itemGroup.addElement(eraser);
			
			var pencil:IItem=MenuFactory.createItem(2);
			itemGroup.addElement(pencil);
			
			var draw:IItem=MenuFactory.createItem(3);
			itemGroup.addElement(draw);
			
			var color:Group=new ItemColor;
			itemGroup.addElement(color);
			
			var input:IItem=MenuFactory.createItem(5);
			itemGroup.addElement(input);
			
			if(MainData._teachType==2){
				var highlight:IItem=MenuFactory.createItem(1);
				itemGroup.addElement(highlight);
			}
			
			var mouse:IItem=MenuFactory.createItem(14);
			itemGroup.addElement(mouse);
			MenuData._mouseMouse=mouse;
			
			if(MainData._teachType==2){
				var tools:IItem=MenuFactory.createItem(8);
				itemGroup.addElement(tools);
			}
			
			
			itemGroup.addElement(createEmpty());
			
			if(MainData._teachType==1){
				var resBox:IItem=MenuFactory.createItem(9);
				itemGroup.addElement(resBox);
			}
			
			if(MainData._teachType==1 || MainData._teachType==2){
				var upScore:IItem=MenuFactory.createItem(11);
				itemGroup.addElement(upScore);
				
				var homework:IItem=MenuFactory.createItem(10);
				itemGroup.addElement(homework);
			}
			
			if(MainData._teachType==1){
				var save:IItem=MenuFactory.createItem(12);
				itemGroup.addElement(save);
			}
			
			var fullScreen:IItem=MenuFactory.createItem(13);
			this.addElement(fullScreen);
			fullScreen.right=5;
			fullScreen.bottom=2;
			
			this.addElement(itemGroup);
			itemGroup.horizontalCenter=0;
			
			callLater(setMouseInfo,null,2);
 		}
		private function setMouseInfo():void
		{
			PublicOperate.setMouseType(0);
//			MenuData._currentMenu=MenuData._mouseMouse.contentMovie;
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