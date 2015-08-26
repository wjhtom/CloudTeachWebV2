package net.xuele.view.resources.resShow
{
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.utils.MatrixTransformer;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResDrawUtil;
	import net.xuele.view.resources.utils.ResTransform;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.VerticalAlign;
	
	/**
	 * 图片PPT等资源操作菜单 （重置，铅笔，橡皮）
	 * @author jianhua
	 * 
	 */
	public class ResMenu extends Group
	{
		private var resetBtn:McButton;
		private var editBtn:McButton;
		private var pencilBtn:UIMovieClip;
		private var eraseBtn:UIMovieClip;
		
		private var _menuGroup:Group;
		public function ResMenu()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		
		private function init():void
		{
			
			createUI();
			addListener();
		}
		private function createUI():void
		{
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("ResEditBg");
			this.addElement(bg);
			
			_menuGroup=new Group;
			var menuLayout:HorizontalLayout=new HorizontalLayout;
			menuLayout.gap=15;
			menuLayout.verticalAlign=VerticalAlign.MIDDLE;
			_menuGroup.layout=menuLayout;
			
			this.addElement(_menuGroup);
			_menuGroup.verticalCenter=_menuGroup.horizontalCenter=0;
			
			resetBtn=new McButton;
			resetBtn.skinName=PublicOperate.getUI("ResReset","movieclip");
			pencilBtn=new UIMovieClip
			pencilBtn.skinName=PublicOperate.getUI("ResPencil","movieclip");
			eraseBtn=new UIMovieClip;
			eraseBtn.skinName=PublicOperate.getUI("ResEraser","movieclip");
			this._menuGroup.addElement(resetBtn);
			this._menuGroup.addElement(pencilBtn);
			this._menuGroup.addElement(eraseBtn);
			pencilBtn.gotoAndStop(0);
			eraseBtn.gotoAndStop(0);
		}
		private function addListener():void
		{
			resetBtn.addEventListener(MouseEvent.CLICK,resetHandler);
			pencilBtn.addEventListener(MouseEvent.CLICK,pencilHandler);
			eraseBtn.addEventListener(MouseEvent.CLICK,eraseHandler);
		}
		private function removeMenu():void
		{
			resetBtn.removeEventListener(MouseEvent.CLICK,resetHandler);
			pencilBtn.removeEventListener(MouseEvent.CLICK,pencilHandler);
			eraseBtn.removeEventListener(MouseEvent.CLICK,eraseHandler);
			this.removeAllElements();
		}
		private function resetHandler(e:MouseEvent):void
		{
//			ResData._currentTools.customRotation(90);
//			EditResBase(ResData._currentEditRes).resRotation=Math.ceil(MatrixTransformer.getRotation(ResData._currentTools.globalMatrix));
//			trace(EditResBase(ResData._currentEditRes).resRotation)
//			return;
			ResData._currentEditRes.drawGroup.removeAllElements();
			ResTransform.resetRes();
		}
		private var _isErase:Boolean=false;
		private var _isPencil:Boolean=false;
		private function pencilHandler(e:MouseEvent):void
		{
			if(_isErase){
				_isErase=false;
				eraseBtn.gotoAndStop(0);
			}
			_isPencil=!_isPencil;
			if(_isPencil){
				pencilBtn.gotoAndStop(2);
				PublicOperate.setMouseType(6);
				ResDrawUtil.drawPencil(ResData._currentEditRes.drawGroup);
			}else{
				pencilBtn.gotoAndStop(0);
				PublicOperate.setMouseType(0);
				ResDrawUtil.stopDrawPencil();
			}
		}
		
		private function eraseHandler(e:MouseEvent):void
		{
			if(_isPencil){
				_isPencil=false;
				pencilBtn.gotoAndStop(0);
			}
			_isErase=!_isErase;
			if(_isErase){
				if(ResData._currentTools!=null){
					ResData._currentTools.moveEnabled=false;
				}
				eraseBtn.gotoAndStop(2);
				PublicOperate.setMouseType(7);
				ResDrawUtil.drawPencil(ResData._currentEditRes.drawGroup);
			}else{
				eraseBtn.gotoAndStop(0);
				PublicOperate.setMouseType(0);
				ResDrawUtil.stopDrawPencil();
			}
		}
	}
}