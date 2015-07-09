package net.xuele.view.resources.resShow
{
	import flash.events.MouseEvent;
	
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResDrawUtil;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
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
		private function createCom():void
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
			createUI();
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
			ResData._currentEditRes.resetRes();
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
				ResDrawUtil.drawPencil(ResData._currentEditRes.drawGroup,0);
			}
		}
		
		private function eraseHandler(e:MouseEvent):void
		{
			if(_isPencil){
				_isPencil=false;
			}
			_isErase=!_isErase;
			if(_isErase){
				ResDrawUtil.drawPencil(ResData._currentEditRes.drawGroup,1);
			}
		}
	}
}