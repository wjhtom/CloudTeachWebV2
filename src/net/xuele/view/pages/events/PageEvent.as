package net.xuele.view.pages.events
{
	import flash.events.Event;
	
	public class PageEvent extends Event
	{
		public static const SELECTSMALLPAGE:String="selectSmallPage";
		public function PageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}