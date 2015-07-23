package net.xuele.view.blackboard.view
{
	import flash.events.MouseEvent;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.view.pages.utils.InputUtil;
	import net.xuele.view.pages.utils.PagesData;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.InputShow;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResTransform;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.core.DomGlobals;
	import org.flexlite.domUI.events.UIEvent;
	
	public class BlackboardView extends Group
	{
		public function BlackboardView()
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
			var rect:Rect=new Rect;
			rect.width=stage.stageWidth;
			rect.height=stage.stageHeight;
			rect.fillAlpha=1;
			rect.fillColor=0x2F6964;
			this.addElement(rect);
			rect.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		private function clickHandler(e:MouseEvent):void
		{
			if(ResData._currentEditRes!=null){
				ResTransform.removeTransRes();
			}
			if(MainData._mouseType==4){
				if(PagesData._currentInput==null)
				{
					InputUtil.startInput();
				}else{
					
					InputUtil.stopInput();
				}
				
			}
		}
	}
}