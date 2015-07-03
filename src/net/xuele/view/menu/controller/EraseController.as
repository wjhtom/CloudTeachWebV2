package net.xuele.view.menu.controller
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class EraseController extends EventDispatcher
	{
		private static var isClose:Boolean=false;
		private static var _control:EraseController;
		public function EraseController(target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function get control():EraseController
		{
			if(EraseController._control==null){
				EraseController.isClose=true;
				EraseController._control=new EraseController;
				EraseController.isClose=false;
			}
			return EraseController._control;
		}
	}
}