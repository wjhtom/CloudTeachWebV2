package net.xuele.view.homework.view
{
	import flash.events.MouseEvent;
	
	import net.xuele.utils.InterfaceData;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.utils.ReadJSON;
	import net.xuele.view.homework.factory.HomeworkFactory;
	import net.xuele.view.homework.utils.HomeworkData;
	import net.xuele.view.homework.utils.HomeworkUtils;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.ScrollPolicy;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.VerticalLayout;
	import org.flexlite.domUtils.DomLoader;
	
	public class WorkView extends Group
	{
		private var _closeBtn:McButton;
		public function WorkView()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			HomeworkData.currentWorkType
			loadData(4);
		}
		private function loadData(t:int):void
		{
			PopUtils.createLoading();
//			var url:String=InterfaceData._getHomeworkURL+"?unitId="+MainData._unitId+"&workType="+t+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
			var url:String="http://www.xueleyun.com/cloudteach/coursewares/extfl/worklist?schoolId=9A0E8CE68426EE1E3BF2FF83A8908AB7&unitId=010001001001001001001&userId=FA52E4F922866A6384BA3D5EB1D813F1&workType=4"
			url="data/homeworkList.txt"
			DomLoader.loadText(url,onLoadCom,PopUtils.loadingPro,PopUtils.IOError);
		}
		private function onLoadCom(data:String):void
		{
			if(data!=null){
				ReadJSON.readHomeworkList(data);
				if(HomeworkData.workListAry.length>0){
					init();
				}else{
					PublicOperate.setAlert("","当前没有电子作业");
				}
			}else{
				PublicOperate.setAlert("加载出错！","作业列表未加载成功");
			}
		}
		private function init():void
		{
			createUI();
			addListener();
		}
		private function createUI():void
		{
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("SelectWorkBg");
			this.addElement(bg);
			
			this._closeBtn=new McButton;
			this._closeBtn.skinName=PublicOperate.getUI("HomeworkClose","movieclip");
			this.addElement(this._closeBtn);
			this._closeBtn.top=10;
			this._closeBtn.right=10;
			
			var scroller:Scroller=new Scroller;
			scroller.width=765;
			scroller.height=365;
			scroller.horizontalScrollPolicy=ScrollPolicy.OFF;
			var listGroup:Group=new Group;
			var listLayout:VerticalLayout=new VerticalLayout;
			listGroup.layout=listLayout;
			var len:int=HomeworkData.workListAry.length;
			for(var i:int=0;i<len;i++){
				listGroup.addElement(HomeworkFactory.createWork(HomeworkData.workListAry[i]));
			}
			scroller.viewport=listGroup;
			this.addElement(scroller);
			scroller.top=40;
			scroller.horizontalCenter=0;
		}
		private function addListener():void
		{
			this._closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
		}
		private function removeListener():void
		{
			this._closeBtn.removeEventListener(MouseEvent.CLICK,closeHandler);
		}
		private function closeHandler(e:MouseEvent):void
		{
			removeListener();
			HomeworkUtils.closeHomeworkList();
		}
	}
}