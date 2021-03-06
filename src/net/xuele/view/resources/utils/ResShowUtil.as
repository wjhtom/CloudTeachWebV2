package net.xuele.view.resources.utils
{
	
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.utils.getTimer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	

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
			CommondView.contentView.addRes(res,false);
		}
		public static function removeResShow(domain:Group,res:IResShow):void
		{
			if(res.isOpen){
				//从黑板上删除
				var at:int=IBigPage(domain.parent).resAry.indexOf(res);
				if(at>=0){
					IBigPage(domain.parent).resAry.splice(at,1);
				}
				_factory.removeResShow(domain,res);
				SoundMixer.stopAll();
			}else{
				//从缩小图中删除
			}
		}
		
	}
}