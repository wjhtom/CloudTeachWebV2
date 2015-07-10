package net.xuele.view.resources.resShow
{
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResDrawUtil;
	import net.xuele.view.resources.utils.ResTransform;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	/**
	 * 图片PPT等资源操作菜单 （重置，铅笔，橡皮）
	 * @author jianhua
	 * 
	 */
	public class ResMenu extends Group
	{
		private var resetBtn:McButton;
		private var editBtn:McButton;
		private var pencilBtn:McButton;
		private var eraseBtn:McButton;
		
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
			_menuGroup=new Group;
			var menuLayout:HorizontalLayout=new HorizontalLayout;
			menuLayout.gap=0;
			_menuGroup.layout=menuLayout;
			this.addElement(_menuGroup);
			createUI();
			addListener();
		}
		private function createUI():void
		{
			resetBtn=new McButton;
			resetBtn.skinName=PublicOperate.getUI("ResReset","movieclip");
			pencilBtn=new McButton;
			pencilBtn.skinName=PublicOperate.getUI("MenuPencil","movieclip");
			eraseBtn=new McButton;
			eraseBtn.skinName=PublicOperate.getUI("MenuEraser","movieclip");
			this._menuGroup.addElement(resetBtn);
			this._menuGroup.addElement(pencilBtn);
			this._menuGroup.addElement(eraseBtn);
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
			ResTransform.resetRes();
		}
		private var _isErase:Boolean=false;
		private var _isPencil:Boolean=false;
		private function pencilHandler(e:MouseEvent):void
		{
			if(_isErase){
				_isErase=false;
			}
			_isPencil=!_isPencil;
			if(_isPencil){
				PublicOperate.setMouseType(6);
				ResDrawUtil.drawPencil(ResData._currentEditRes.drawGroup);
			}else{
				PublicOperate.setMouseType(0);
				ResDrawUtil.stopDrawPencil();
			}
		}
		
		private function eraseHandler(e:MouseEvent):void
		{
			if(_isPencil){
				_isPencil=false;
			}
			_isErase=!_isErase;
			if(_isErase){
				if(ResData._currentTools!=null){
					ResData._currentTools.moveEnabled=false;
				}
				PublicOperate.setMouseType(7);
				ResDrawUtil.drawPencil(ResData._currentEditRes.drawGroup);
			}else{
				PublicOperate.setMouseType(0);
				ResDrawUtil.stopDrawPencil();
			}
		}
	}
}