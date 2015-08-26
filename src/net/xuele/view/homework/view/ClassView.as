package net.xuele.view.homework.view
{
	import flash.events.MouseEvent;
	
	import net.xuele.utils.InterfaceData;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.utils.ReadJSON;
	import net.xuele.view.homework.factory.HomeworkFactory;
	import net.xuele.view.homework.interfaces.IClass;
	import net.xuele.view.homework.utils.HomeworkData;
	import net.xuele.view.homework.utils.HomeworkUtils;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.ColumnAlign;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.TileLayout;
	import org.flexlite.domUI.layouts.VerticalAlign;
	import org.flexlite.domUtils.DomLoader;
	
	public class ClassView extends Group
	{
		/**
		 * 返回按钮 
		 */
		private var _returnBtn:McButton;
		/**
		 * 选中 
		 */
		private var _okBtn:McButton;
		/**
		 * 取消 
		 */
		private var _cancelBtn:McButton;
		private var _currentSelect:IClass;
		public function ClassView()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			loadData();
		}
		private function init():void
		{
			_currentSelect=null;
			createUI();
			addListener();
		}
		private function loadData():void
		{
//			var url:String=InterfaceData._getClassURL+"?workId="+HomeworkData.currentWorkVo._id+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time)
			var url:String="http://www.xueleyun.com/cloudteach/coursewares/extfl/getworkstudentlist?classId=3195b943cb4e405c98ec393b3cb3ef81&userId=162906292706&schoolId=xueleceshioscar1"
			url="data/homeworkClass.txt";
			DomLoader.loadText(url,onLoadCom,PopUtils.loadingPro,PopUtils.IOError);
		}
		private function onLoadCom(data:String):void
		{
			if(data!=null){
				ReadJSON.readHomeworkClass(data);
				if(HomeworkData.classListAry.length>0){
					init();
				}else{
					PublicOperate.setAlert("","该作业未分配班级");
				}
			}else{
				PublicOperate.setAlert("加载错误","班级信息加载错误");
			}
		}
		private function createUI():void
		{
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("SelectClassBg");
			this.addElement(bg);
			
			this._returnBtn=new McButton;
			this._returnBtn.skinName=PublicOperate.getUI("HomeworkReturn","movieclip");
			this._okBtn=new McButton;
			this._okBtn.skinName=PublicOperate.getUI("OKBtn","movieclip");
			this._cancelBtn=new McButton;
			this._cancelBtn.skinName=PublicOperate.getUI("CancelBtn","movieclip");
			this.addElement(this._returnBtn);
			this.addElement(this._okBtn);
			this.addElement(this._cancelBtn);
			this._returnBtn.top=10;
			this._returnBtn.right=10;
			this._okBtn.bottom=10;
			this._okBtn.right=110;
			this._cancelBtn.bottom=10;
			this._cancelBtn.right=10;
			
			var scroller:Scroller=new Scroller;
			scroller.width=790;
			scroller.height=270;
			var listGroup:Group=new Group;
			var listLayout:TileLayout=new TileLayout;
			listLayout.columnAlign=ColumnAlign.JUSTIFY_USING_WIDTH;
			listLayout.requestedColumnCount=4;
			listLayout.horizontalAlign=HorizontalAlign.CENTER;
			listLayout.verticalAlign=VerticalAlign.MIDDLE;
			listGroup.layout=listLayout;
			
			var len:int=HomeworkData.classListAry.length;
			for(var i:int=0;i<len;i++){
				var clsContent:IClass=HomeworkFactory.createClass(HomeworkData.classListAry[i]);
				listGroup.addElement(clsContent);
				clsContent.addEventListener(MouseEvent.CLICK,selectClassHandler);
			}
			scroller.viewport=listGroup;
			this.addElement(scroller);
			scroller.horizontalCenter=0;
			scroller.verticalCenter=40;
		}
		private function addListener():void
		{
			_returnBtn.addEventListener(MouseEvent.CLICK,returnHandler);
			_okBtn.addEventListener(MouseEvent.CLICK,okHandler);
			_cancelBtn.addEventListener(MouseEvent.CLICK,cancelHandler);
		}
		private function removeListener():void
		{
			_returnBtn.removeEventListener(MouseEvent.CLICK,returnHandler);
			_okBtn.removeEventListener(MouseEvent.CLICK,okHandler);
			_cancelBtn.removeEventListener(MouseEvent.CLICK,cancelHandler);
		}
		private function selectClassHandler(e:MouseEvent):void
		{
			if(_currentSelect==IClass(e.currentTarget)){
				return;
			}
			if(_currentSelect!=null){
				_currentSelect.unSelectClass();
			}
			_currentSelect=IClass(e.currentTarget);
			_currentSelect.selectClass();
			HomeworkData.currentClassVo=_currentSelect.classVo;
			
		}
		private function returnHandler(e:MouseEvent):void
		{
			removeListener();
			HomeworkUtils.closeClassList();
			HomeworkUtils.openHomeworkList();
		}
		private function okHandler(e:MouseEvent):void
		{
			if(this._currentSelect==null){
				PublicOperate.setAlert("请选择班级","您未选择班级，请选择班级后继续");
				return;
			}
			removeListener();
			HomeworkUtils.closeClassList();
			HomeworkUtils.openStudentList();
		}
		private function cancelHandler(e:MouseEvent):void
		{
			removeListener();
			HomeworkUtils.closeClassList();
		}
	}
}