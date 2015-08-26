package net.xuele.view.homework.controller
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	
	public class HomeworkController extends EventDispatcher
	{
		private static var isClose:Boolean=false;
		private static var _control:HomeworkController;
		public function HomeworkController(target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function get control():HomeworkController
		{
			if(HomeworkController._control==null){
				HomeworkController.isClose=true;
				HomeworkController._control=new HomeworkController;
				HomeworkController.isClose=false;
			}
			return HomeworkController._control;
		}
	}
}