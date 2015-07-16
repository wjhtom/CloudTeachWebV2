package net.xuele.view.pages.view
{
	import flash.text.TextFormatAlign;
	
	import net.xuele.view.pages.interfaces.IPageNum;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.events.UIEvent;
	
	/**
	 * 页码 
	 * @author jianhua
	 * 
	 */
	public class PageNum extends Group implements IPageNum
	{
		private var _id:int;
		private var _bg:Rect;
		private var _idTxt:Label;
		public function PageNum(id:int)
		{
			super();
			this._id=id;
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
		}
		private function createUI():void
		{
			_bg=new Rect;
			_bg.fillAlpha=0;
			_bg.fillColor=0x000000;
			_bg.width=30;
			_bg.height=23;
			this.addElement(_bg);
			
			this._idTxt=new Label;
			_idTxt.textColor=0xffffff;
			_idTxt.fontFamily="宋体";
			_idTxt.size=12;
			_idTxt.textAlign=TextFormatAlign.CENTER;
			_idTxt.text=String(this._id+1);
			this.addElement(this._idTxt);
			_idTxt.horizontalCenter=0;
			_idTxt.verticalCenter=0;
		}
		public function selectedPage():void
		{
			this._bg.fillAlpha=0.5;
		}
		
		public function unSelectedPage():void
		{
			this._bg.fillAlpha=0;
		}
		
		public function get pageID():int
		{
			return this._id;
		}
	}
}