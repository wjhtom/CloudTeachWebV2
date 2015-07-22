package net.xuele.view.resources.resShow
{
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.events.UIEvent;
	
	public class InputMenu extends Group
	{
		public function InputMenu()
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
			
		}
		
	}
}