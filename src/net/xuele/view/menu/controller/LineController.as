package net.xuele.view.menu.controller
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class LineController extends EventDispatcher
	{
		private static var isClose:Boolean=false;
		private static var _control:LineController;
		public function LineController(target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function get control():LineController
		{
			if(LineController._control==null){
				LineController.isClose=true;
				LineController._control=new LineController;
				LineController.isClose=false;
			}
			return LineController._control;
		}
	}
}