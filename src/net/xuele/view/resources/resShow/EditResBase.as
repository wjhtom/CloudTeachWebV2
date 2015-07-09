package net.xuele.view.resources.resShow
{
	
	import com.senocular.display.TransformTool;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResDrawUtil;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	
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
		
		
		public function resetRes():void
		{
		}
		public function get drawGroup():Group
		{
			return this._drawGroup;
		}
		
	}
}

