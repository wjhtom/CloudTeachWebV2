package net.xuele.vo
{
	public class ResourceVo
	{
		public var _fileCode:String;
		public var _id:String;
		public var _mid:String;
		/**
		 * 类型
		 * 1:ppt,2:img,3:sound,4:flv,5:swf 
		 */
		public var _type:String;
		/**
		 * 资源路径 
		 */
		public var _path:String;
		/**
		 * 资源后缀 
		 */
		public var _ex:String;
		/**
		 * 资源名称 
		 */
		public var _name:String;
		public function ResourceVo()
		{
		}
	}
}