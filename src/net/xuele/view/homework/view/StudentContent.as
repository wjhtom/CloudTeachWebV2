package net.xuele.view.homework.view
{
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	
	import net.xuele.view.homework.interfaces.IStudent;
	import net.xuele.vo.StudentVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.VerticalAlign;
	
	/**
	 * 学生姓名 
	 * 
	 */
	public class StudentContent extends Group implements IStudent
	{
		private var _bg:Rect;
		private var _sVo:StudentVo;
		private var _nameLabel:Label;
		private var _isSelected:Boolean=false;
		public function StudentContent(sVo:StudentVo)
		{
			super();
			_sVo=sVo;
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			this.width=120;
			this.height=30;
			createUI();
			addListener();
		}
		private function createUI():void
		{
			this._bg=new Rect;
			this._bg.fillAlpha=1;
			if(_isSelected){
				this._bg.fillColor=0xe3e3e3;
			}else{
				this._bg.fillColor=0xf6f6f6;
			}
			this._bg.percentWidth=this._bg.percentHeight=100;
			this.addElement(this._bg);
			this._nameLabel=new Label;
			this._nameLabel.size=14;
			this._nameLabel.textAlign=TextFormatAlign.CENTER;
			this._nameLabel.textColor=0x000000;
			this._nameLabel.text=this._sVo._name;
			this.addElement(this._nameLabel);
			this._nameLabel.horizontalCenter=0;
			this._nameLabel.verticalCenter=0;
			this._nameLabel.verticalAlign=VerticalAlign.MIDDLE;
		}
		private function addListener():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER,rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT,rollOutHandler);
		}
		private function rollOverHandler(e:MouseEvent):void
		{
			if(_isSelected){
				return;
			}
			this._bg.fillColor=0xe3e3e3;
		}
		private function rollOutHandler(e:MouseEvent):void
		{
			if(_isSelected){
				return;
			}
			this._bg.fillColor=0xf6f6f6;
		}
		public function selected():void
		{
			if(_isSelected){
				_isSelected=false;
				this._bg.fillColor=0xf6f6f6;
			}else{
				_isSelected=true;
				this._bg.fillColor=0xe3e3e3;
			}
			
		}
		public function unSelect():void
		{
			if(!_isSelected){
				return;
			}
			_isSelected=false;
			this._bg.fillColor=0xf6f6f6;
		}
		public function get studentVo():StudentVo
		{
			return this._sVo;
		}
		public function set isSelected(v:Boolean):void
		{
			_isSelected=v;
		}
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
	}
}