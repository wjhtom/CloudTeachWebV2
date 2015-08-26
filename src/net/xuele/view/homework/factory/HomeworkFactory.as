package net.xuele.view.homework.factory
{
	import net.xuele.view.homework.interfaces.IAttachmentContent;
	import net.xuele.view.homework.interfaces.IClass;
	import net.xuele.view.homework.interfaces.IStudent;
	import net.xuele.view.homework.interfaces.IWork;
	import net.xuele.view.homework.view.AttachmentIcon;
	import net.xuele.view.homework.view.ClassContent;
	import net.xuele.view.homework.view.StudentContent;
	import net.xuele.view.homework.view.WorkContent;
	import net.xuele.vo.HomeworkClassVo;
	import net.xuele.vo.HomeworkListVo;
	import net.xuele.vo.ResourceVo;
	import net.xuele.vo.StudentVo;

	public class HomeworkFactory
	{
		public function HomeworkFactory()
		{
		}
		public static function createWork(vo:HomeworkListVo):IWork
		{
			return new WorkContent(vo);
		}
		public static function createStudent(vo:StudentVo):IStudent
		{
			return new StudentContent(vo);
		}
		public static function createClass(vo:HomeworkClassVo):IClass
		{
			return new ClassContent(vo);
		}
		public static function createWorkContent(vo:ResourceVo):IAttachmentContent
		{
			return new AttachmentIcon(vo)
		}
	}
}