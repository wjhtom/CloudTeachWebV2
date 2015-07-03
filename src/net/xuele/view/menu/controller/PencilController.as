package net.xuele.view.menu.controller
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	
	public class PencilController extends EventDispatcher
	{
		private static var isClose:Boolean=false;
		private static var _control:PencilController;
		public function PencilController(target:IEventDispatcher=null)
		{
			super(target);
			if (PencilController.isClose == false) {
				throw new Error("ControlCenter:无法实例化");
			}
		}
		public static function get control():PencilController
		{
			if(PencilController._control==null){
				PencilController.isClose=true;
				PencilController._control=new PencilController;
				PencilController.isClose=false;
			}
			return PencilController._control;
		}
	}
}