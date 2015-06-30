package net.xuele.commond
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	
	public class CommonControl extends EventDispatcher
	{
		private static var isClose:Boolean=false;
		private static var _control:CommonControl;
		private static var _stage:Stage;
		public function CommonControl(target:IEventDispatcher=null)
		{
			super(target);
			if (CommonControl.isClose == false) {
				throw new Error("ControlCenter:无法实例化");
			}
		}
		public static function get control():CommonControl
		{
			if(CommonControl._control==null){
				CommonControl.isClose=true;
				CommonControl._control=new CommonControl;
				CommonControl.isClose=false;
			}
			return CommonControl._control;
		}
	}
}