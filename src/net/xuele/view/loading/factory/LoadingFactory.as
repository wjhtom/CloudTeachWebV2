package net.xuele.view.loading.factory
{
	import flash.events.Event;
	
	import net.xuele.interfaces.IPop;
	import net.xuele.interfaces.IPopFactory;
	import net.xuele.view.loading.LoadingEvent;
	import net.xuele.view.loading.controller.LoadingController;
	import net.xuele.view.loading.model.LoadingModel;
	import net.xuele.view.loading.view.LoadingPop;
	
	public class LoadingFactory implements IPopFactory
	{
		private var _loadingModel:LoadingModel;
		private var _loadingController:LoadingController;
		private var _loadingView:LoadingPop;
		public function LoadingFactory()
		{
		}
		public function createPop():IPop
		{
			this._loadingModel=new LoadingModel;
			this._loadingController=new LoadingController(this._loadingModel);
			return new LoadingPop(this._loadingModel,this._loadingController);
		}
	}
}