package net.xuele.view.resources.utils
{
	import flash.geom.Point;
	
	import net.xuele.commond.CommondView;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.interfaces.IResShow;
	
	import org.flexlite.domUI.components.Group;

	/**
	 * 资源编辑 
	 * @author jianhua
	 * 
	 */
	public class ResTransform
	{
		public function ResTransform()
		{
		}
		public static function setTransRes(res:IResShow):void
		{
			ResData._currentTools.target=Group(res);
			ResData._currentTools.registration=new Point(ResData._currentTools.boundsCenter.x,ResData._currentTools.boundsCenter.y);
//			CommondView.currentTool=currTool;
			ResData._currentEditRes=res;
		}
		public static function removeTransRes():void
		{
			if(ResData._currentEditRes==null){
				return;
			}
			ResData._currentEditRes.dispatchEvent(new ResEvent(ResEvent.ADDRESLISTENER));
			ResData._currentTools.target=null;
			ResData._currentEditRes=null;
		}
	}
}