package net.xuele.view.resources.resShow
{
	import flash.events.Event;
	import flash.text.TextFormatAlign;
	
	import net.xuele.view.resources.events.ResEvent;
	
	import org.flexlite.domUI.components.EditableText;
	import org.flexlite.domUI.components.Rect;

	public class InputShow extends ResBase
	{
		private var _inputText:EditableText;
		private var _bg:Rect;
		public function InputShow()
		{
			super();
		}
		override protected function init():void
		{
			createUI();
		}
		private function createUI():void
		{
			_bg=new Rect;
			_bg.fillAlpha=0;
			_bg.fillColor=0xffffff;
			_bg.strokeAlpha=1;
			_bg.strokeColor=0x808080;
			_bg.strokeWeight=1;
			this.addElement(_bg);
			_inputText=new EditableText;
			_inputText.textAlign=TextFormatAlign.LEFT;
			_inputText.fontFamily="宋体";
			_inputText.text="";
			_inputText.size=36;
			this.addElement(_inputText);
			_inputText.bottom=10;
			_inputText.right=10;
			_inputText.setFocus();
			this._dragRect=_inputText;
			setTextStorke();
			this.dispatchEvent(new ResEvent(ResEvent.LOADRESCOM));
			_inputText.addEventListener(Event.CHANGE,textChangeHandler);
		}
		private function textChangeHandler(e:Event):void
		{
			setTextStorke();
		}
		private function setTextStorke():void
		{
			_inputText.width=_inputText.textWidth+30;
			_inputText.height=_inputText.textHeight+10;
			_bg.width=_inputText.width;
			_bg.height=_inputText.height;
		}
		/**
		 * 获取文本 
		 * @return 
		 * 
		 */
		public function get _contentText():EditableText
		{
			return _inputText;
		}
		/**
		 * 更新外框 
		 * 
		 */
		public function updataShow():void
		{
			setTextStorke();
		}
		public function clearBg():void
		{
			_bg.fillAlpha=0;
			_bg.strokeAlpha=0;
		}
		public function setStroke():void
		{
			_bg.strokeAlpha=1;
		}
		
	}
}