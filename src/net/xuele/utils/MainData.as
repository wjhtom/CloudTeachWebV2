package net.xuele.utils
{

	public class MainData
	{
		public static var _version:String="2.0.1";
		/**
		 * 教师类型
		 * 1：编辑，2：授课，3：分享预览 ，4：新增课件
		 */
		public static var _teachType:int=4;
		/**
		 * 课件id 
		 */
		public static var _coursewaresId:String;
		/**
		 * 课程id 
		 */
		public static var _unitId:String;
		/**
		 * 课程名称 
		 */
		public static var _unitName:String;
		/**
		 * 用户id 
		 */
		public static var _userId:String;
		/**
		 * 学校id 
		 */
		public static var _schoolId:String;
		/**
		 * 课件名称 
		 */
		public static var _coursewaresName:String;
		/**
		 * 是否在线
		 * true：在线，flase：离线 
		 */
		public static var _isOnline:Boolean;
		/**
		 * 课件名称 
		 */
		public static var _shoukeName:String;
		/**
		 * 场景总宽 
		 */
		public static var _stageWidth:Number;
		/**
		 * 场景总高 
		 */
		public static var _stageHeight:Number;
		/**
		 * 授课黑板信息，这是一个二维数组[页码[内容]，页码[内容]] 
		 */
		public static var pagesDataAry:Array=[];
		/**
		 * 用户导入的资源 
		 */
		public static var myResourcesAry:Array=[];
		/**
		 * 系统默认资源 
		 */
		public static var systemResourcesAry:Array=[];
		/**
		 * 教师班级信息 
		 */
		public static var teachInfoAry:Array=[];
		/**
		 * 讨论作业 
		 */
		public static var talkworkAry:Array=[];
		/**
		 * 电子作业 
		 */
		public static var homeworkAry:Array=[];
		
		/**
		 * 当前鼠标类型
		 * 0：鼠标，1：铅笔，2：画直线，3：橡皮，4：文字，5：高亮 ,6:资源内画笔，7：资源内橡皮
		 */
		public static var _mouseType:int=0;
		/**
		 * 用于存放UI文件 
		 */
		public static var uiArray:Array=[];
		public function MainData()
		{
		}
	}
}