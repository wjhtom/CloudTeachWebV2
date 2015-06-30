package net.xuele.view.loading
{
	import flash.events.Event;
	
	public class LoadingEvent extends Event
	{
		public static const CHANGEPROVALUE:String="changeProValue";
		public function LoadingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}