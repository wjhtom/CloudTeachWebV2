package net.xuele.view.resources.events
{
	import flash.events.Event;
	
	public class ResEvent extends Event
	{
		public static const LOADRESCOM:String="loadResCom";
		public static const ADDRESLISTENER:String="addResListener";
		public function ResEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}