package net.xuele.utils
{
	import net.xuele.view.blackboard.utils.BlackboarData;
	import net.xuele.vo.ContentVo;
	import net.xuele.vo.HomeworkVo;
	import net.xuele.vo.PropertyVo;
	import net.xuele.vo.ResourceVo;
	import net.xuele.vo.StudentWorkVo;
	import net.xuele.vo.TalkworkVo;
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
				resVo._id=obj.resources[i].id;
				resVo._mid=obj.resources[i].mid;
				resVo._type=obj.resources[i].type;
				resVo._name=obj.resources[i].nm;
				resVo._fileCode=obj.resources[i].code;
				resVo._path=obj.resources[i].url;
				resVo._ex=obj.resources[i].ex;
				ResourcesData._allResAry.push(resVo);
				switch(resVo._mid){
					case 1:
						ResourcesData._otherAry.push(resVo);
						break;
					case 2:
						ResourcesData._pptAry.push(resVo);
						break;
					case 3:
						ResourcesData._wordAry.push(resVo);
						break;
					case 4:
						ResourcesData._imgAry.push(resVo);
						break;
					case 5:
						ResourcesData._movieAry.push(resVo);
						break;
					case 6:
						ResourcesData._sndVidAry.push(resVo);
						break;
					default:
						break;
				}
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
					contentVo._type=obj.pages[i][j].type;
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
					}else{
						contentVo._property=new PropertyVo;
						contentVo._property._type=true;
						contentVo._property.height=obj.pages[i][j].property.height;
						contentVo._property.width=obj.pages[i][j].property.width;
						contentVo._path=obj.pages[i][j].property.path;
					}
					MainData.pagesDataAry[i].push(contentVo);
				}
				
			}
			MainData.myResourcesAry=[];
			len=obj.resources.length;
			for(i=0;i<len;i++){
				var myResVo:ResourceVo=new ResourceVo;
				myResVo._id=obj.resources[i].id;
				myResVo._type=obj.resources[i].type;
				myResVo._name=obj.resources[i].nm;
				myResVo._path=obj.resources[i].url;
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
				teacherVo._name=obj.list[i].name;
				teacherVo._g=obj.list[i].g;
				teacherVo._c=obj.list[i].c;
				MainData.teachInfoAry.push(teacherVo);
			}
		}
		/**
		 * 电子作业 
		 * 
		 */
		public static function readHomework(str:String):void
		{
			var obj:Object=JSON.parse(str);
			MainData.homeworkAry=[];
			var len:int=obj.qlist.length;
			for(var i:int=0;i<len;i++){
				var homeVo:HomeworkVo=new HomeworkVo;
				homeVo._id=obj.qlist[i].id;
				homeVo._type=obj.qlist[i].type;
				homeVo._content=obj.qlist[i].content;
				homeVo._tlistAry=[];
				var len1:int=obj.qlist[i].tlist.length;
				for(var j:int=0;j>len1;j++){
					var studentVo:StudentWorkVo=new StudentWorkVo;
					studentVo._userID=obj.qlist[i].tlist[j].userid;
					studentVo._name=obj.qlist[i].tlist[j].name;
					studentVo._fileAry=[];
					var len2:int=obj.qlist[i].tlist[j].file.length;
					for(var k:int=0;k<len2;k++){
						var fileVo:ResourceVo=new ResourceVo;
						fileVo._path=obj.qlist[i].tlist[j].file[k].url;
						fileVo._type=obj.qlist[i].tlist[j].file[k].type;
						fileVo._ex=obj.qlist[i].tlist[j].file[k].ex;
						studentVo._fileAry.push(fileVo);
					}
					homeVo._tlistAry.push(studentVo);
				}
				MainData.homeworkAry.push(homeVo);
			}
		}
		/**
		 * 讨论作业 
		 * 
		 */
		public static function readTalkwork(str:String):void
		{
			var obj:Object=JSON.parse(str);
			var len:int=obj.dis.length;
			for(var i:int=0;i<len;i++){
				var talkVo:TalkworkVo=new TalkworkVo;
				talkVo._id=obj.dis[i].id;
				talkVo._content=obj.dis[i].content;
				MainData.talkworkAry.push(talkVo);
			}
		}
	}
}