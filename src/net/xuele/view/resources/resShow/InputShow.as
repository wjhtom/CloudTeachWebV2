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
			_bg.fillAlpha=1;
			_bg.fillColor=0xffffff;
			_bg.strokeAlpha=1;
			_bg.strokeColor=0x808080;
			_bg.strokeWeight=1;
			this.addElement(_bg);
			_inputText=new EditableText;
			_inputText.textAlign=TextFormatAlign.LEFT;
			_inputText.fontFamily="宋体";
			_inputText.text="";
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
			_inputText.width=_inputText.textWidth+10;
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
		 * 获取文本内容 
		 * @return 
		 * 
		 */
		public function get _text():String
		{
			return _inputText.text;
		}
		/**
		 * 文本颜色 
		 * @param color
		 * 
		 */
		public function set _color(color:uint):void
		{
			if(this._inputText==null){
				return;
			}
			this._inputText.textColor=color;
		}
		public function get _color():uint
		{
			return this._inputText.textColor;
		}
		/**
		 * 是否粗体 
		 * @param v
		 * 
		 */
		public function set _bold(v:Boolean):void
		{
			if(this._inputText==null){
				return;
			}
			this._inputText.bold=v;
		}
		public function get _bold():Boolean
		{
			return this._inputText.bold;
		}
		/**
		 * 是否斜体 
		 * @param v
		 * 
		 */
		public function set _italic(v:Boolean):void
		{
			if(this._inputText==null){
				return;
			}
			this._inputText.italic=v;
		}
		public function get _italic():Boolean
		{
			return this._inputText.italic;
		}
		/**
		 * 是否下划线 
		 * @param v
		 * 
		 */
		public function set _underLine(v:Boolean):void
		{
			if(this._inputText==null){
				return;
			}
			this._inputText.underline=v;
		}
		public function get _underLine():Boolean
		{
			return this._inputText.underline;
		}
		/**
		 * 文本字号 
		 * @param v
		 * 
		 */
		public function set _textSize(v:uint):void
		{
			if(this._inputText==null){
				return;
			}
			this._inputText.size=v;
		}
		public function get _textSize():uint
		{
			return this._inputText.size;
		}
		public function clearBg():void
		{
			_bg.fillAlpha=0;
			_bg.strokeAlpha=0;
		}
		
	}
}