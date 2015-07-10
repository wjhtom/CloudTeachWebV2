package net.xuele.view.resources.resShow
{
	
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	
	/**
	 * 可编辑资源容器
	 * @author jianhua
	 * 
	 */
	public class EditResBase extends Group implements IResShow
	{
		protected var _resGroup:Group;
		private var _drawGroup:Group;
		protected var _resVo:ResourceVo;
		public function EditResBase()
		{
			super();
			
		}
		
		public function createUI(resVo:ResourceVo):void
		{
			this._resVo=resVo;
			var timer:Timer=new Timer(20,1);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void
		{
			Timer(e.target).removeEventListener(TimerEvent.TIMER,timerHandler);
			init();
		}
		
		private function init():void
		{
			
			this._resGroup=new Group;
			this.addElement(this._resGroup);
			this._drawGroup=new Group;
			this.addElement(this._drawGroup);
//			this._drawGroup.width=200;
//			this._drawGroup.height=300;
			
			createRes();
		}
		public function removeListener():void
		{
		}
		/**
		 * 创建资源 
		 * 
		 */
		protected function createRes():void
		{
		}
		
		
		public function get drawGroup():Group
		{
			return this._drawGroup;
		}
	}
}

