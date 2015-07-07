package net.xuele.view.resources.utils
{
	
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import net.xuele.commond.CommondView;
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
		public static function createResShow(resVo:ResourceVo):void
		{
			var res:IResShow=_factory.createResShow(resVo);
			CommondView.resShowView.addElement(res);
			if(res is ImageShow || res is DocShow){
				res.horizontalCenter=0;
				res.top=0;
			}else{
				res.x=CommondView.resShowView.mouseX;
				res.y=CommondView.resShowView.mouseY;
			}
			res.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			res.addEventListener(MouseEvent.MOUSE_UP,upHandler);
		}
		private static var downTime:Number;
		private static function downHandler(e:MouseEvent):void
		{
			downTime=getTimer();
			IResShow(e.currentTarget).startResDrag();
		}
		private static function upHandler(e:MouseEvent):void
		{
			if(getTimer()-downTime<150){
				IResShow(e.currentTarget).editRes();
			}
			IResShow(e.currentTarget).stopResDrag();
		}
	}
}