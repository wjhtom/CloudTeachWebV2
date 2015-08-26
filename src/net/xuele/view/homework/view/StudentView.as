package net.xuele.view.homework.view
{
	import flash.events.MouseEvent;
	
	import net.xuele.utils.InterfaceData;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.utils.ReadJSON;
	import net.xuele.view.homework.factory.HomeworkFactory;
	import net.xuele.view.homework.interfaces.IAttachmentContent;
	import net.xuele.view.homework.interfaces.IStudent;
	import net.xuele.view.homework.utils.HomeworkData;
	import net.xuele.view.homework.utils.HomeworkUtils;
	import net.xuele.vo.ResourceVo;
	import net.xuele.vo.StudentVo;
	import net.xuele.vo.StudentWorkVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.TextArea;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.ScrollPolicy;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.VerticalLayout;
	import org.flexlite.domUtils.DomLoader;
	
	/**
	 * 学生作业详情 
	 * @author jianhua
	 * 
	 */
	public class StudentView extends Group
	{
		/**
		 * 学生列表 
		 */
		private var _studentGroup:Group;
		/**
		 * 附件列表 
		 */
		private var _attachmentsGroup:Group;
		/**
		 * 学生作业内容 
		 */
		private var _studentContentGroup:Group;
		/**
		 * 单个作业详情 
		 */
		private var _workContentGroup:Group;
		/**
		 * 主容器 
		 */
		private var _mainGroup:Group;
		/**
		 *  学生描述
		 */
		private var _contentInfo:TextArea;
		/**
		 * 当前学生 
		 */
		private var _currentStudent:IStudent;
		private var _returnBtn:McButton;
		private var _closeBtn:McButton;
		private var _currentAttachment:IAttachmentContent;
		public function StudentView()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			loadStudentList();
		}
		private function init():void
		{
			createUI();
			addListener();
		}
		private function loadStudentList():void
		{
//			var url:String=InterfaceData._getStudentListURl+"?classId="+HomeworkData.currentClassVo._classID+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
			var url:String="http://www.xueleyun.com/cloudteach/coursewares/extfl/getworkclasslist?workId=0fd10776ca7842a78ea873a805dd9e5b&userId=FA52E4F922866A6384BA3D5EB1D813F1&schoolId=9A0E8CE68426EE1E3BF2FF83A8908AB7";
			url="data/homeworkStudent.txt"
			DomLoader.loadText(url,onLoadData,PopUtils.loadingPro,PopUtils.IOError);
		}
		private function onLoadData(data:String):void
		{
			if(data!=null){
				ReadJSON.readHomeworkStudent(data);
				if(HomeworkData.studentListAry.length>0){
					init();
				}else{
					PublicOperate.setAlert("错误","当前作业下学生");
				}
			}else{
				PublicOperate.setAlert("加载出错","学生列表加载失败！");
			}
		}
		private function createUI():void
		{
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("StudentListBg");
			this.addElement(bg);
			
			var studentLayout:VerticalLayout=new VerticalLayout;
			studentLayout.gap=0;
			var attachmentsLayout:HorizontalLayout=new HorizontalLayout;
			attachmentsLayout.gap=10;
			var studentContentLayout:VerticalLayout=new VerticalLayout;
			studentContentLayout.gap=10;
			studentContentLayout.horizontalAlign=HorizontalAlign.CENTER;
			var mainLayout:HorizontalLayout=new HorizontalLayout;
			mainLayout.gap=0;
			
			this._mainGroup=new Group;
			this._mainGroup.layout=mainLayout;
			this._studentGroup=new Group;
//			this._studentGroup.width=120;
//			this._studentGroup.height=495;
			this._studentGroup.layout=studentLayout;
			this._studentContentGroup=new Group;
			this._studentContentGroup.width=618;
			this._studentContentGroup.height=495;
			this._studentContentGroup.layout=studentContentLayout;
			this._attachmentsGroup=new Group;
			this._attachmentsGroup.width=590;
			this._attachmentsGroup.height=50;
			this._attachmentsGroup.layout=attachmentsLayout;
			
			
			var scroller:Scroller=new Scroller;
			scroller.width=120;
			scroller.height=495;
			scroller.horizontalScrollPolicy=ScrollPolicy.OFF;
			
			this._contentInfo=new TextArea;
			this._contentInfo.selectable=false;
			this._contentInfo.horizontalScrollPolicy=ScrollPolicy.OFF;
			this._contentInfo.width=590;
			this._contentInfo.height=80;
			this._workContentGroup=new Group;
			this._workContentGroup.width=590;
			this._workContentGroup.height=310;
			
			this._mainGroup.addElement(scroller);
			scroller.viewport=this._studentGroup;
			this._mainGroup.addElement(this._studentContentGroup);
			this._studentContentGroup.addElement(this._contentInfo);
			this._studentContentGroup.addElement(this._attachmentsGroup);
			this._attachmentsGroup.horizontalCenter=0;
			this._studentContentGroup.addElement(this._workContentGroup);
			
			var len:int=HomeworkData.studentListAry.length;
			for(var i:int=0;i<len;i++){
				var student:IStudent=HomeworkFactory.createStudent(HomeworkData.studentListAry[i]);
				this._studentGroup.addElement(student);
				student.addEventListener(MouseEvent.CLICK,studentClickHandler);
				if(i==0){
					this._currentStudent=student;
					student.isSelected=true;
				}
			}
			if(len>0){
				loadStudentContent(HomeworkData.studentListAry[0])
			}
			this.addElement(this._mainGroup);
			this._mainGroup.top=40;
			
			this._returnBtn=new McButton;
			this._returnBtn.skinName=PublicOperate.getUI("HomeworkReturn","movieclip");
			this.addElement(_returnBtn);
			this._closeBtn=new McButton;
			this._closeBtn.skinName=PublicOperate.getUI("HomeworkClose","movieclip");
			this.addElement(this._closeBtn);
			this._returnBtn.top=10;
			this._returnBtn.right=40;
			this._closeBtn.top=10;
			this._closeBtn.right=10;
			
			
		}
		private function studentClickHandler(e:MouseEvent):void
		{
			if(this._currentStudent==IStudent(e.currentTarget)){
				return;
			}
			var num:int=this._attachmentsGroup.numElements;
			for(var i:int=0;i<num;i++){
				IAttachmentContent(_attachmentsGroup.getElementAt(i)).removeEventListener(MouseEvent.CLICK,attachmentClickHandler);
			}
			this._attachmentsGroup.removeAllElements();
			this._currentStudent.unSelect();
			IStudent(e.currentTarget).selected();
			this._currentStudent=IStudent(e.currentTarget);
			loadStudentContent(this._currentStudent.studentVo);
		}
		private function loadStudentContent(stVo:StudentVo):void
		{
			PopUtils.createLoading();
			var url:String=InterfaceData._getStudentContentURL+"?workId="+HomeworkData.currentWorkVo._id+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
			url="data/StudentWork.txt";
			DomLoader.loadText(url,onComp,PopUtils.loadingPro,PopUtils.IOError);
		}
		private function onComp(data:String):void
		{
			this._currentStudent.studentVo._workVo=ReadJSON.readHomeworkContent(data);
			if(this._currentStudent.studentVo._workVo!=null){
				setStudentContent(this._currentStudent.studentVo._workVo);
			}
		}
		/**
		 * 设置学生作业 
		 * 
		 */
		private function setStudentContent(swVo:StudentWorkVo):void
		{
			this._contentInfo.text=swVo.workInfo;
			var len:int=swVo.attachmentsAry.length;
			if(len==0){
				return;
			}
			for(var i:int=0;i<len;i++){
				var content:IAttachmentContent=HomeworkFactory.createWorkContent(swVo.attachmentsAry[i]);
				this._attachmentsGroup.addElement(content);
				content.addEventListener(MouseEvent.CLICK,attachmentClickHandler);
				if(i==0){
					this._currentAttachment=content;
					content.isSelect=true;
				}
			}
			setWorkContent(swVo.attachmentsAry[0]);
		}
		private function attachmentClickHandler(e:MouseEvent):void
		{
			if(IAttachmentContent(e.currentTarget).isSelect){
				return;
			}
			this._currentAttachment.unSelect();
			IAttachmentContent(e.currentTarget).select();
			this._currentAttachment=IAttachmentContent(e.currentTarget)
			setWorkContent(IAttachmentContent(e.currentTarget).resVo);
		}
		private function setWorkContent(rVo:ResourceVo):void
		{
			switch(getWorkType(rVo._ex)){
				case 1:
					var imgWork:ImageWork=new ImageWork(rVo);
					this._workContentGroup.addElement(imgWork);
					imgWork.horizontalCenter=0;
					imgWork.verticalCenter=0;
					break;
				case 2:
					var sndWork:SoundWork=new SoundWork(rVo._path);
					this._workContentGroup.addElement(sndWork);
					sndWork.horizontalCenter=0;
					sndWork.verticalCenter=0;
					break;
				case 3:
					var vidWork:VideoWork=new VideoWork(rVo);
					this._workContentGroup.addElement(vidWork);
					vidWork.horizontalCenter=0;
					vidWork.verticalCenter=0;
					break;
				case 4:
					break;
				case 5:
					break;
			}
		}
		private function addListener():void
		{
			_returnBtn.addEventListener(MouseEvent.CLICK,returnHandler);
			_closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
		}
		private function removeListener():void
		{
			_returnBtn.removeEventListener(MouseEvent.CLICK,returnHandler);
			_closeBtn.removeEventListener(MouseEvent.CLICK,closeHandler);
		}
		private function returnHandler(e:MouseEvent):void
		{
			removeListener();
			HomeworkUtils.closeStudentList();
			HomeworkUtils.openClassList();
		}
		private function closeHandler(e:MouseEvent):void
		{
			removeListener();
			HomeworkUtils.closeStudentList();
		}
		/**
		 * 获取作业类型 
		 * @param ex
		 * @return 1图片，2声音，3视频，4文档，5动画
		 * 
		 */
		private function getWorkType(ex:String):int
		{
			var type:int=0;
			switch(ex){
				case "png":
				case "jpeg":
				case "bmp":
				case "jpg":
					type=1;
					break;
				case "txt":
				case "doc":
				case "docx":
				case "xls":
				case "xlsx":
				case "ppt":
				case "pptx":
				case "pdf":
					type=4;
					break;
				case "mp3":
				case "wav":
				case "wma":
					type=2;
					break;
				case "flv":
				case "avi":
				case "mpeg":
				case "mpg":
				case "mp4":
				case "rmvb":
				case "wmv":
				case "mkv":
				case "3gp":
				case "mov":
				case "navi":
				case "rm":
					type=3;
					break;
				case "swf":
					type=5;
					break;
			}
			return type;
		}
		
			
	}
}