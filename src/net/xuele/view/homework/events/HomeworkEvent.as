package net.xuele.view.homework.events
{
	import flash.events.Event;
	
	public class HomeworkEvent extends Event
	{
		public static const OPENCLASSLIST:String="openClassList";
		public static const OPENSTUDENTLIST:String="openStudentList";
		public static const EXPORTRES:String="exportRes";
		public function HomeworkEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}