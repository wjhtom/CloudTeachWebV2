package net.xuele.vo
{
	
	public class ContentVo extends ResourceVo
	{
		/**
		 * X坐标 
		 */
		public var _x:Number;
		/**
		 * Y坐标 
		 */
		public var _y:Number;
		/**
		 * 索引 
		 */
		public var _index:Number;
		/**
		 * 是否打开状态 
		 */
		public var _isOpen:int;
		public var _property:PropertyVo;
		public function ContentVo()
		{
			super();
		}
	}
}