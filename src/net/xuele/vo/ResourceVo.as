package net.xuele.vo
{
	public class ResourceVo
	{
		public var _fileCode:String;
		public var _id:String;
//		public var _mid:String;
		/**
		 * 类型
		 * 1:ppt,2:img,3:sound,4:flv,5:swf 
		 */
//		public var _type:String;
		/**
		 * 与网站页面上对应的资源分类 （课件，教案，学案，习题，课程素材，其他）
		 */
		public var _fileType:String;
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
		/**
		 * 资源来源（1：云盘资源，2：系统资源） 
		 */
		public var _from:int;
		/**
		 * 缩略图地址 
		 */
		public var _smallImgURL:String;
		public function ResourceVo()
		{
		}
	}
}