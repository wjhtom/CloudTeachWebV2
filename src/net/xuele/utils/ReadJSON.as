package net.xuele.utils
{
	
	import net.xuele.view.blackboard.utils.BlackboarData;
	import net.xuele.vo.ContentVo;
	import net.xuele.vo.PropertyVo;
	import net.xuele.vo.ResourceVo;
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
			if(obj.state==-1){
				return;
			}
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
				resVo._ex=obj.resources[i].extension;
				resVo._path=PublicOperate.getResURL(resVo._ex,resVo._fileCode);
				resVo._fileType=obj.resources[i].fileType;
				ResourcesData._allResAry.push(resVo);
			}
		}
		/**
		 * 保存的课件资源 
		 * 
		 */
		public static function readShoukeInfo(str:String):void
		{
			var obj:Object=JSON.parse(str);
			BlackboarData.bg=obj.bg;
			BlackboarData.style=obj.style;
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
					if(obj.pages[i].type=="6"){
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
						contentVo._property.path=obj.pages[i][j].property.path;
					}
					MainData.pagesDataAry[i].push(contentVo);
				}
				
			}
			MainData.myResourcesAry=[];
			len=obj.resources.length;
			for(i=0;i<len;i++){
				var myResVo:ResourceVo=new ResourceVo;
				myResVo._id=obj.resources[i].id;
				myResVo._fileCode=obj.resources[i].code;
				myResVo._type=obj.resources[i].type;
				myResVo._name=obj.resources[i].nm;
				myResVo._ex=obj.resources[i].ex;
				myResVo._path=PublicOperate.getResURL(myResVo._ex,myResVo._fileCode);
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
			MainData.systemResourcesAry=[];
			var len:int=obj.resources.length;
			for(var i:int=0;i<len;i++){
				var res:ResourceVo=new ResourceVo;
				res._fileCode=obj.resources[i].code;
				res._name=obj.resources[i].nm;
				res._ex=obj.resources[i].ex;
				res._id=obj.resources[i].id;
				res._path=PublicOperate.getResURL(res._ex,res._fileCode);
			}
		}
		
		
	}
}