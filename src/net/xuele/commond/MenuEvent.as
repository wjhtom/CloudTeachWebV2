package net.xuele.commond
{
	import flash.events.Event;
	
	public class MenuEvent extends Event
	{
		public static const HIDETHICKNESS:String="hideThickness";
		public static const HIDETLINESTYLE:String="hideLineStyle";
		public function MenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}