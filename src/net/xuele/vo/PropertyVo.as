package net.xuele.vo
{
	public class PropertyVo
	{
		/**
		 * 内容类型：
		 * true:资源型，false:文本型 
		 */
		public var _type:Boolean=true;
		private var _width:Number;
		private var _height:Number;
		private var _path:String;
		private var _size:Number;
		private var _color:Object;
		private var _italic:Boolean;
		private var _bold:Boolean;
		public function PropertyVo()
		{
		}
		public function set width(v:Number):void
		{
			if(this._type){
				this._width=v;
			}else{
				new Error("文本类型没有width属性");
			}
			
		}
		public function get width():Number
		{
			if(this._type){
				return _width;
			}else{
				new Error("文本类型没有width属性");
				return null;
			}
		}
		public function set height(v:Number):void
		{
			if(this._type){
				_height=v;
			}else{
				new Error("文本类型没有height属性");
			}
		}
		public function get height():Number
		{
			if(this._type){
				return _height;
			}else{
				new Error("文本类型没有height属性");
				return null;
			}
		}
		public function set path(v:String):void
		{
			if(this._type){
				_path=v;
			}else{
				new Error("文本类型没有path属性");
				
			}
		}
		public function get path():String
		{
			if(this._type){
				return _path;
			}else{
				new Error("文本类型没有path属性");
				return null;
			}
		}
		public function set size(v:Number):void
		{
			if(this._type){
				new Error("资源类型没有size属性");
			}else{
				this._size=v;
			}
		}
		public function get size():Number
		{
			if(this._type){
				new Error("资源类型没有size属性");
				return null;
			}else{
				return _size;
			}
		}
		public function set color(v:Object):void
		{
			if(this._type){
				new Error("资源类型没有color属性");
				
			}else{
				this._color=v;
			}
		}
		public function get color():Object
		{
			if(this._type){
				new Error("资源类型没有color属性");
				return null;
			}else{
				return this._color
			}
		}
		public function set italic(v:Boolean):void
		{
			if(this._type){
				new Error("资源类型没有italic属性");
			}else{
				this._italic=v;
			}
		}
		public function get italic():Boolean
		{
			if(this._type){
				new Error("资源类型没有italic属性");
				return null;
			}else{
				return _italic;
			}
		}
		public function set bold(v:Boolean):void
		{
			if(this._type){
				new Error("资源类型没有bold属性");
			}else{
				this._bold=v;
			}
		}
		public function get bold():Boolean
		{
			if(this._type){
				new Error("资源类型没有bold属性");
				return null;
			}else{
				return this._bold;
			}
		}
	}
}