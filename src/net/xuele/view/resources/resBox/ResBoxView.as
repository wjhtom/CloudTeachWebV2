package net.xuele.view.resBox.view
{
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.events.UIEvent;
	
	/**
	 * 用户资源盒 
	 * @author jianhua
	 * 
	 */
	public class ResBoxView extends Group
	{
		public function ResBoxView()
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
			
		}
		private function systemRes():void
		{
			
		}
		private function userRes():void
		{
			
		}
	}
}