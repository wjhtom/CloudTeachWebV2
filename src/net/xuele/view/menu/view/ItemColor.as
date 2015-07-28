package net.xuele.view.menu.view
{
	
	import fl.controls.ColorPicker;
	import fl.events.ColorPickerEvent;
	
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.draw.utils.DrawData;
	import net.xuele.view.menu.interfaces.IItem;
	import net.xuele.view.menu.utils.MenuData;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	
	/**
	 * 颜色 
	 * @author jianhua
	 * 
	 */
	public class ItemColor extends Group
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
		private function createUI():void
		{
//			rect=new Rect;
//			rect.width=45;
//			rect.height=45;
//			rect.fillColor=DrawData._currentColor;
//			rect.fillAlpha=1;
//			this.addElement(rect);
			var bg:UIMovieClip=new UIMovieClip;
			bg.skinName=PublicOperate.getUI("MenuColor","movieclip");
			this.addElement(bg);
			bg.gotoAndStop(0);
			
			var color:ColorPicker=new ColorPicker;
			var ui:UIAsset=new UIAsset;
			ui.skinName=color;
			this.addElement(ui);
			ui.width=bg.width;
			ui.height=bg.height;
			ui.mouseChildren=true;
			ui.alpha=0;
			color.addEventListener(ColorPickerEvent.CHANGE,selectColorHandler)
		}
		private function selectColorHandler(e:ColorPickerEvent):void
		{
			DrawData._currentColor=e.color;
		}
		
	}
}