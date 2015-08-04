package net.xuele.view.resources.control
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	public class ResControl extends EventDispatcher
	{
		private static var isClose:Boolean=false;
		private static var _control:ResControl;
		public function ResControl(target:IEventDispatcher=null)
		{
			super(target);
			if (ResControl.isClose == false) {
				throw new Error("ControlCenter:无法实例化");
			}
		}
		public static function get control():ResControl
		{
			if(ResControl._control==null){
				ResControl.isClose=true;
				ResControl._control=new ResControl;
				ResControl.isClose=false;
			}
			return ResControl._control;
		}
	}
}