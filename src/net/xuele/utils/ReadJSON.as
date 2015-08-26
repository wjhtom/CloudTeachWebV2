package net.xuele.utils
{
	
	import net.xuele.view.blackboard.utils.BlackboarData;
	import net.xuele.view.homework.utils.HomeworkData;
	import net.xuele.vo.ContentVo;
	import net.xuele.vo.HomeworkClassVo;
	import net.xuele.vo.HomeworkListVo;
	import net.xuele.vo.PropertyVo;
	import net.xuele.vo.ResourceVo;
	import net.xuele.vo.StudentVo;
	import net.xuele.vo.StudentWorkVo;
	import net.xuele.vo.TeacherInfoVo;

	public class ReadJSON
	{
		public function ReadJSON()
		{
		}
		/**
		 * 所有资源 
		 * 
		 */
		public static function readAllResources(str:String):void
		{
			
			var obj:Object=JSON.parse(str);
			trace(JSON.stringify(obj))
			if(obj.state==0){
				ResourcesData._allResAry=[];
				return;
			}
			ResourcesData._allResAry=[];
			var len:int=obj.resources.length;
			if(len==0){
				return;
			}
			for(var i:int=0;i<len;i++){
				if(obj.resources[i].ex=="rar"||obj.resources[i].ex=="zip"||obj.resources[i].ex=="7z"){
					continue;
				}
				var resVo:ResourceVo=new ResourceVo;
				resVo._id=obj.resources[i].diskId;
//				resVo._mid=obj.resources[i].mid;
//				resVo._type=obj.resources[i].type;
				resVo._name=obj.resources[i].name;
				resVo._fileCode=obj.resources[i].fileUri;
				resVo._ex=String(obj.resources[i].extension).toLowerCase();
				resVo._path=PublicOperate.getResURL(resVo._ex,resVo._fileCode);
				resVo._fileType=obj.resources[i].fileType;
				resVo._from=1;
				ResourcesData._allResAry.push(resVo);
			}
		}
		/**
		 * 保存的课件资源 
		 * 
		 */
		public static function readShoukeInfo(str:String):void
		{
//			var myPattern:RegExp=/\\\"/g;
//			str=str.replace(myPattern,'"')
			trace(str)
			var obj:Object=JSON.parse(str);
			if(obj.state==0){
				MainData.pagesDataAry=[];
				MainData.myResourcesAry=[];
				return;
			}
			MainData._coursewaresName=obj.coursewaresName;
			BlackboarData.bg=obj.bgID;
			BlackboarData.style=obj.bgStyle;
			MainData.pagesDataAry=[];
			var len:int=obj.pages.length;
			for(var i:int=0;i<len;i++){
				MainData.pagesDataAry[i]=[];
				var len1:int=obj.pages[i].length;
				for(var j:int=0;j<len1;j++){
					var contentVo:ContentVo=new ContentVo;
//					contentVo._type=obj.pages[i][j].type;
					contentVo._name=obj.pages[i][j].text;
					contentVo._x=obj.pages[i][j].x;
					contentVo._y=obj.pages[i][j].y;
					contentVo._isOpen=obj.pages[i][j].isOpen;
					contentVo._index=obj.pages[i][j].index;
					contentVo._place=obj.pages[i][j].place;
					if(obj.pages[i][j].type==6){
						contentVo._property=new PropertyVo;
						contentVo._property._type=false;
						contentVo._property.size=obj.pages[i][j].property.size;
						contentVo._property.color=obj.pages[i][j].property.color;
						contentVo._property.bold=obj.pages[i][j].property.bold;
						contentVo._property.italic=obj.pages[i][j].property.italic;
						contentVo._property.underline=obj.pages[i][j].property.underline;
					}else{
						contentVo._property=new PropertyVo;
						contentVo._property._type=true;
						contentVo._property.height=obj.pages[i][j].property.height;
						contentVo._property.width=obj.pages[i][j].property.width;
						contentVo._property.fileType=obj.pages[i][j].property.fileType;
						contentVo._property.ex=obj.pages[i][j].property.ex;
						contentVo._property.fileCode=obj.pages[i][j].property.code;
						contentVo._property.from=obj.pages[i][j].property.from;
						if(contentVo._property.from==1){
							contentVo._property.path=PublicOperate.getResURL(obj.pages[i][j].property.ex,obj.pages[i][j].property.code);
						}else{
							contentVo._property.path=obj.pages[i][j].property.path;
							contentVo._property.smallImg=obj.pages[i][j].property.smallImg;
							
						}
						trace(contentVo._property.path,"===",contentVo._property.fileCode)
					}
					
					MainData.pagesDataAry[i].push(contentVo);
				}
				
			}
			MainData.myResourcesAry=[];
			len=obj.resources.length;
			for(i=0;i<len;i++){
				var myResVo:ResourceVo=new ResourceVo;
//				myResVo._id=obj.resources[i].id;
				myResVo._fileCode=obj.resources[i].fileCode;
//				myResVo._type=obj.resources[i].type;
				myResVo._name=obj.resources[i].name;
				myResVo._ex=String(obj.resources[i].ex).toLowerCase();
				myResVo._fileType=obj.resources[i].fileType;
				myResVo._path=PublicOperate.getResURL(myResVo._ex,myResVo._fileCode);
				myResVo._from=1;
				MainData.myResourcesAry.push(myResVo);
			}
		}
		/**
		 * 教师信息 
		 * 
		 */
		public static function readTeacherClass(str:String):void
		{
			var obj:Object=JSON.parse(str);
			if(obj.state==0){
				MainData.teachInfoAry=[];
				return;
			}
			MainData.teachInfoAry=[];
			var len:int=obj.list.length;
			for(var i:int=0;i<len;i++){
				var teacherVo:TeacherInfoVo=new TeacherInfoVo;
				teacherVo._name=obj.list[i].className;
				teacherVo._classID=obj.list[i].classId;
				teacherVo._g=obj.list[i].year;
				teacherVo._c=obj.list[i].codeSharing;
				MainData.teachInfoAry.push(teacherVo);
			}
		}
		/**
		 * 获取系统资源 
		 * @param str
		 * 
		 */
		public static function readSystemRes(str:String):void
		{
			var obj:Object=JSON.parse(str);
			if(obj.status==0){
				MainData.systemResourcesAry=[];
				return;
			}
			trace(str)
			MainData.systemResourcesAry=[];
			var len:int=obj.resources.length;
			for(var i:int=0;i<len;i++){
				var res:ResourceVo=new ResourceVo;
				res._name=obj.resources[i].name;
				res._path=obj.resources[i].bigimg;
				res._smallImgURL=obj.resources[i].smallimg;
				res._ex=String(obj.resources[i].extension).toLowerCase();
				res._from=2;
				res._fileCode=obj.resources[i].fileUri;
				MainData.systemResourcesAry.push(res);
			}
		}
		
		public static function readClassRes(str:String):void
		{
			var obj:Object=JSON.parse(str);
			trace(JSON.stringify(obj))
			if(obj.state==0){
				MainData.myResourcesAry=[];
				return;
			}
			MainData.myResourcesAry=[];
			var len:int=obj.resources.length;
			if(len==0){
				return;
			}
			for(var i:int=0;i<len;i++){
				if(obj.resources[i].ex=="rar"||obj.resources[i].ex=="zip"||obj.resources[i].ex=="7z"){
					continue;
				}
				var resVo:ResourceVo=new ResourceVo;
				resVo._id=obj.resources[i].diskId;
				resVo._name=obj.resources[i].name;
				resVo._fileCode=obj.resources[i].fileUri;
				resVo._ex=String(obj.resources[i].extension).toLowerCase();
				resVo._path=PublicOperate.getResURL(resVo._ex,resVo._fileCode);
				resVo._fileType=obj.resources[i].fileType;
				resVo._from=1;
				MainData.myResourcesAry.push(resVo);
			}
		}
		
		/**
		 * 电子作业列表 
		 * 
		 */
		public static function readHomeworkList(str:String):void
		{
			var obj:Object=JSON.parse(str);
			if(obj.state==0){
				return;
			}
			HomeworkData.workListAry=[];
			var len:int=obj.list.length;
			for(var i:int=0;i<len;i++){
				var len1:int=obj.list[i].itemList.length;
				for(var j:int=0;j<len1;j++){
					var workVo:HomeworkListVo=new HomeworkListVo;
					workVo._id=obj.list[i].workId;
					workVo._content=obj.list[i].itemList[j].context;
					workVo._voiceContext=obj.list[i].itemList[j].voiceContext;
					workVo._assignTime=obj.list[i].publishTime;
					workVo._attachmentsAry=[];
					var len2:int=obj.list[i].itemList[j].fileList.length;
					for(var k:int=0;k<len2;k++){
						var resVo:ResourceVo=new ResourceVo;
						resVo._ex=obj.list[i].itemList[j].fileList[k].extension;
						resVo._name=obj.list[i].itemList[j].fileList[k].name;
						resVo._fileCode=obj.list[i].itemList[j].fileList[k].fileUri;
						resVo._id=obj.list[i].itemList[j].fileList[k].diskId;
						workVo._attachmentsAry.push(resVo);
					}
					HomeworkData.workListAry.push(workVo);
				}
				
			}
		}
		/**
		 * 电子作业班级 
		 * 
		 */
		public static function readHomeworkClass(str:String):void
		{
			var obj:Object=JSON.parse(str);
			if(obj.state==0){
				return;
			}
			HomeworkData.classListAry=[];
			var len:int=obj.list.length;
			for(var i:int=0;i<len;i++){
				var classVo:HomeworkClassVo=new HomeworkClassVo;
				classVo._classID=obj.list[i].classId;
				classVo._className=obj.list[i].className;
				classVo._year=obj.list[i].year;
				classVo._codeSharing=obj.list[i].codeSharing;
				classVo._classIcon=InterfaceData._downURL+obj.list[i].mImage;
				HomeworkData.classListAry.push(classVo);
			}
		}
		/**
		 * 电子作业学生列表 
		 * 
		 */
		public static function readHomeworkStudent(str:String):void
		{
			var obj:Object=JSON.parse(str);
			if(obj.state==0){
				return;
			}
			HomeworkData.studentListAry=[];
			var len:int=obj.list.length;
			for(var i:int=0;i<len;i++){
				var studentVo:StudentVo=new StudentVo;
				studentVo._userID=obj.list[i].studentId;
				studentVo._name=obj.list[i].studentName;
				HomeworkData.studentListAry.push(studentVo);
			}
		}
		/**
		 * 某个学生电子作业内容 
		 * 
		 */
		public static function readHomeworkContent(str:String):StudentWorkVo
		{
			var obj:Object=JSON.parse(str);
			if(obj.state==0){
				return null;
			}
			var workContent:StudentWorkVo=new StudentWorkVo;
			workContent.workInfo=obj.context;
			workContent.attachmentsAry=[];
			var len:int=obj.list.length;
			for(var i:int=0;i<len;i++){
				var rVo:ResourceVo=new ResourceVo;
				rVo._id=obj.list[i].diskId;
				rVo._name=obj.list[i].name;
				rVo._ex=obj.list[i].extension;
				rVo._fileCode=obj.list[i].fileUri;
				rVo._path=PublicOperate.getResURL(rVo._ex,rVo._fileCode)
				workContent.attachmentsAry.push(rVo);
			}
			return workContent;
		}
		
	}
}