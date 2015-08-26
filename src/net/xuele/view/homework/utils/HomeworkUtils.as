package net.xuele.view.homework.utils
{
	import net.xuele.commond.CommondView;
	import net.xuele.view.homework.view.ClassView;
	import net.xuele.view.homework.view.StudentView;
	import net.xuele.view.homework.view.WorkView;

	public class HomeworkUtils
	{
		public function HomeworkUtils()
		{
		}
		private static var _homeworkView:WorkView;
		private static var _classView:ClassView;
		private static var _studentView:StudentView;
		public static function openHomeworkList():void
		{
			if(_homeworkView==null){
				_homeworkView=new WorkView;
				CommondView.popView.addElement(_homeworkView);
				_homeworkView.horizontalCenter=0;
				_homeworkView.verticalCenter=20;
			}
		}
		public static function openClassList():void
		{
			if(_classView==null){
				_classView=new ClassView;
				CommondView.popView.addElement(_classView);
				_classView.horizontalCenter=0;
				_classView.verticalCenter=20;
			}
			
		}
		public static function openStudentList():void
		{
			if(_studentView==null){
				_studentView=new StudentView;
				CommondView.popView.addElement(_studentView);
				_studentView.horizontalCenter=0;
				_studentView.verticalCenter=0;
			}
			
		}
		public static function closeHomeworkList():void
		{
			if(_homeworkView!=null){
				CommondView.popView.removeElement(_homeworkView);
				_homeworkView=null;
			}
		}
		public static function closeClassList():void
		{
			if(_classView!=null){
				CommondView.popView.removeElement(_classView);
				_classView=null;
			}
		}
		public static function closeStudentList():void
		{
			if(_studentView!=null){
				CommondView.popView.removeElement(_studentView);
				_studentView=null;
			}
		}
		
	}
}