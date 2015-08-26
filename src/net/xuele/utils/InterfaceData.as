package net.xuele.utils
{
	public class InterfaceData
	{
		/**
		 * 接口列表 
		 */
		public static var _interfaceListURL:String="http://asset.xueleyun.com/g/flash/skconfig.xml?t="+String(new Date().time);
		/**
		 * 所有资源接口
		 * 参数：kcid 
		 */
		public static var _allResourcesURL:String="";
		/**
		 * 编辑，授课时调用获取资源
		 * 参数：id,kcid 
		 */
		public static var _teacherEditURL:String="";
		/**
		 * 课件分享时预览
		 * 参数：id,kcid 
		 */
		public static var _teacherShareURL:String="";
		/**
		 *  保存课件
		 *  参数：content,id,kcid
		 */
		public static var _saveURL:String="";
		/**
		 * 自动保存
		 * 参数：content,id,kcid 
		 */
		public static var _autoSaveURL:String="";
		/**
		 * 电子课本内容
		 * 参数： kcid
		 */
		public static var _dzkbInfoURL:String="";
		/**
		 * 班级
		 */
		public static var _getClassURL:String="";
		/**
		 * 电子作业
		 */
		public static var _getHomeworkURL:String="";
		/**
		 * 学生列表
		 */
		public static var _getStudentListURl:String="";
		/**
		 * 学生作业内容
		 */
		public static var _getStudentContentURL:String="";
		/**
		 * 讨论作业
		 * 参数：kcid,g,c 
		 */
		public static var _talkworkURL:String="";
		/**
		 * 教师信息
		 * 参数：kcid 
		 */
		public static var _teacherClassURL:String="";
		/**
		 * 获取系统资源 
		 */
		public static var _systemResURL:String="";
		/**
		 * 外部UI文件 
		 */
		public static var _uiURL:String="http://asset.xueleyun.com/g/flash/skui.swf?ver="+MainData._version;
		/**
		 * 文件下载预览地址 
		 */
		public static var _downURL:String="http://dl.xueleyun.com/"
		public function InterfaceData()
		{
		}
	}
}