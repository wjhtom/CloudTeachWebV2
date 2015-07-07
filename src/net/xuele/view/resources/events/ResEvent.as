package net.xuele.view.resources.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ResEvent extends EventDispatcher
	{
		public static const LOADRESCOM:String="loadResCom";
		public function ResEvent(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}