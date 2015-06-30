package net.xuele.view.menu.view
{
	
	import fl.controls.ColorPicker;
	import fl.events.ColorPickerEvent;
	
	import net.xuele.view.menu.interfaces.IItem;
	import net.xuele.view.menu.utils.MenuData;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.events.UIEvent;
	
	/**
	 * 颜色 
	 * @author jianhua
	 * 
	 */
	public class ItemColor extends Group implements IItem
	{
		private var rect:Rect;
		public function ItemColor()
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
		public function createUI():void
		{
			rect=new Rect;
			rect.width=45;
			rect.height=45;
			rect.fillColor=MenuData._selectColor;
			rect.fillAlpha=1;
			this.addElement(rect);
			
			var color:ColorPicker=new ColorPicker;
			var ui:UIAsset=new UIAsset;
			ui.skinName=color;
			this.addElement(ui);
			ui.mouseChildren=true;
			ui.alpha=1;
			color.addEventListener(ColorPickerEvent.CHANGE,selectColorHandler)
		}
		private function selectColorHandler(e:ColorPickerEvent):void
		{
			trace("color",e.color);
			MenuData._selectColor=e.color;
			rect.fillColor=MenuData._selectColor;
		}
		public function click():void
		{
			
		}
		
		
	}
}