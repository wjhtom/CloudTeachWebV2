package net.xuele.view.homework.utils
{
	import net.xuele.vo.HomeworkClassVo;
	import net.xuele.vo.HomeworkListVo;
	import net.xuele.vo.StudentVo;

	public class HomeworkData
	{
		/**
		 * 当前作业类型：1预习，4电子作业，7口语作业 
		 */
		public static var currentWorkType:int;
		
		public static var currentWorkVo:HomeworkListVo;
		public static var currentClassVo:HomeworkClassVo;
		public static var currentStudentVo:StudentVo;
		
		public static var workListAry:Array=[];
		public static var classListAry:Array=[];
		public static var studentListAry:Array=[];
		public function HomeworkData()
		{
		}
	}
}