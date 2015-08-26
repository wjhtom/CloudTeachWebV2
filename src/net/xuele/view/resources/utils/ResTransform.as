/**************************************
 *            资源缩放变形                                      *
 * ************************************/
package net.xuele.view.resources.utils
{
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.ResMenu;
	
	import org.flexlite.domUI.components.Group;

	/**
	 * 资源编辑 
	 * @author jianhua
	 * 
	 */
	public class ResTransform
	{
		private static var resMenu:ResMenu;
		public function ResTransform()
		{
		}
		/**
		 * 设置资源编辑状态 
		 * @param res
		 * 
		 */
		public static function setTransRes(res:IResShow):void
		{
			ResData._currentTools.target=Group(res);
			ResData._currentTools.registration=new Point(ResData._currentTools.boundsCenter.x,ResData._currentTools.boundsCenter.y);
//			CommondView.currentTool=currTool;
			ResData._currentEditRes=res;
			resMenu=new ResMenu;
			CommondView.resShowView.addElement(resMenu);
			resMenu.addEventListener(Event.ENTER_FRAME,menuEnterHandler);
			
		}
		private static function menuEnterHandler(e:Event):void
		{
			var rect:Rectangle=Group(ResData._currentEditRes).getRect(Group(ResData._currentEditRes).stage)
			if(rect.width>resMenu.width){
				resMenu.x=rect.x+(rect.width-resMenu.width)/2;
			}else{
				resMenu.x=rect.x-(resMenu.width-rect.width)/2;
			}
			resMenu.y=rect.y+rect.height+2;
		}
		/**
		 * 解除资源编辑状态 
		 * 
		 */
		public static function removeTransRes():void
		{
			if(ResData._currentEditRes==null){
				return;
			}
			if(MainData._mouseType==6||MainData._mouseType==7){
				ResDrawUtil.stopDrawPencil();
			}
			ResData._currentTools.moveEnabled=true;
			ResData._currentEditRes.dispatchEvent(new ResEvent(ResEvent.ADDRESLISTENER));
			ResData._currentTools.target=null;
			ResData._currentEditRes=null;
			if(resMenu!=null){
				resMenu.removeEventListener(Event.ENTER_FRAME,menuEnterHandler);
				CommondView.resShowView.removeElement(resMenu);
			}
		}
		/**
		 * 重置资源 
		 * 
		 */
		public static function resetRes():void
		{
			var origReg:Point = ResData._currentTools.registration;
			
			ResData._currentTools.globalMatrix = new Matrix();
			
			var regDiff:Point = origReg.subtract(ResData._currentTools.registration);
			
			var toolMatrix:Matrix = ResData._currentTools.toolMatrix;
			toolMatrix.tx += regDiff.x;
			toolMatrix.ty += regDiff.y;
			ResData._currentTools.toolMatrix = toolMatrix;
			
			ResData._currentTools.apply();
		}
		public static function setResRotation(v:Number):void
		{
			if(ResData._currentEditRes==null){
				return;
			}
			ResData._currentTools.customRotation(v);
		}
	}
}