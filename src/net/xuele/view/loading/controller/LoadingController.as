package net.xuele.view.loading.controller
{
	import net.xuele.view.loading.model.LoadingModel;
	import net.xuele.view.loading.utils.LoadingData;
	
	import org.flexlite.domUI.components.ProgressBar;

	public class LoadingController
	{
		private var _model:LoadingModel
		public function LoadingController(m:LoadingModel)
		{
			_model=m;
		}
		public function setProValue(bar:ProgressBar):void
		{
			bar.value=LoadingData.loadingNum;
		}
	}
}