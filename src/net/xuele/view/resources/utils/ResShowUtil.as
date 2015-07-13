package net.xuele.view.resources.utils
{
	
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.vo.ResourceVo;
	

	public class ResShowUtil
	{
		public function ResShowUtil()
		{
		}
		private static var _factory:ResFactory=new ResFactory;
		private static var _res:IResShow;
		public static function createResShow(resVo:ResourceVo):void
		{
			var res:IResShow=_factory.createResShow(resVo);
			CommondView.contentView.addRes(res);
		}
		public static function removeResShow(res:IResShow):void
		{
			res.removeListener();
			if(res.isOpen){
				//从黑板上删除
			}else{
				//从缩小图中删除
			}
		}
		
	}
}