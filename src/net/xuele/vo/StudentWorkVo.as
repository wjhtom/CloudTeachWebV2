package net.xuele.vo
{
	/**
	 * 学生作业详情 
	 * @author jianhua
	 * 
	 */
	public class StudentWorkVo
	{
		/**
		 * 作业ID 
		 */
		public var workID:String;
		/**
		 *  作业描述
		 */
		public var workInfo:String;
		/**
		 *  附件列表[resourceVo,resourceVo,resourceVo,resourceVo...]
		 */
		public var attachmentsAry:Array=[];
		public function StudentWorkVo()
		{
		}
	}
}