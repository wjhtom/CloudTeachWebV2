package net.xuele.vo
{
	/**
	 * 电子作业 
	 * @author jianhua
	 * 
	 */
	public class HomeworkListVo
	{
		public var _id:String;
		/**
		 * 作业描述 
		 */
		public var _content:String;
		/**
		 * 附件列表[ResourceVo,ResourceVo...] 
		 */
		public var _attachmentsAry:Array=[];
		/**
		 * 布置作业的时间 
		 */
		public var _assignTime:String;
		/**
		 * 口语作业专用 
		 */
		public var _voiceContext:String="";
		public function HomeworkListVo()
		{
		}
	}
}