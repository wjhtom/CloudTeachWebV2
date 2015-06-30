package net.xuele.factory
{
	import net.xuele.interfaces.IPop;
	import net.xuele.interfaces.IPopFactory;
	import net.xuele.view.pop.AlertPop;
	
	public class AlertFactory implements IPopFactory
	{
		private var alert:AlertPop;
		private var _alertInfo:String;
		public function AlertFactory(str:String)
		{
			_alertInfo=str;
		}
		
		public function createPop():IPop
		{
			alert=new AlertPop(_alertInfo);
			return alert;
		}
	}
}