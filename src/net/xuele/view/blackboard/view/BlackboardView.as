package net.xuele.view.blackboard.view
{
	import org.flexlite.domUI.components.Group;
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
			
		}
	}
}