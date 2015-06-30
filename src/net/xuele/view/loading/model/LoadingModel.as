package net.xuele.view.loading.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class LoadingModel extends EventDispatcher
	{
		public function LoadingModel(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}