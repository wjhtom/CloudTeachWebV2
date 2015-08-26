package net.xuele
{
	import flash.display.Loader;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.InterfaceData;
	import net.xuele.utils.MainData;
	import net.xuele.utils.MainTheme;
	import net.xuele.utils.MyCrypto;
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.utils.ReadJSON;
	import net.xuele.utils.ReadXML;
	import net.xuele.view.Main;
	
	import org.flexlite.domCore.Injector;
	import org.flexlite.domUI.components.Alert;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.Theme;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.managers.SystemManager;
	import org.flexlite.domUtils.Debugger;
	import org.flexlite.domUtils.DomLoader;
	
	
	public class FlexLiteManager extends SystemManager
	{
		private var _popGroup:Group;
		private var _mainGroup:Main;
		public function FlexLiteManager()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			Debugger.initialize(stage);
			Injector.mapClass(Theme,MainTheme);
			if(MainData._isOnline){
				if(MainData._unitId==null||MainData._userId==null || isNaN(MainData._teachType) || MainData._schoolId==null || MainData._unitName==null){
					PublicOperate.setAlert("参数出错","网页传参出错！unitID="+MainData._unitId+"|unitName="+MainData._unitName+"|type="+MainData._teachType+"|schoolID="+MainData._schoolId+"|unitName="+MainData._unitName);
					return;
				}
			}else{
				MainData._teachType=1;
				MainData._unitName="Lesson 1 Hello!";
				MainData._coursewaresId="b5a63618a6464737939280fcedd096d2";
				MainData._userId="265143510212";
				MainData._schoolId="SchoolIDQATestsm55";
			}
			MainData._stageWidth=stage.stageWidth;
			MainData._stageHeight=stage.stageHeight;
			createUI();
			loadInterfaceXML();
		}
		private function loadInterfaceXML():void
		{
			PopUtils.createLoading();
			if(MainData._isOnline){
				DomLoader.loadXML(InterfaceData._interfaceListURL,onInterfaceXML,PopUtils.loadingPro,PopUtils.IOError);
			}else{
				//InterfaceData._interfaceListURL="data/config.xml";
				DomLoader.loadXML(InterfaceData._interfaceListURL,onInterfaceXML,PopUtils.loadingPro,PopUtils.IOError);
			}
		}
		private function onInterfaceXML(data:XML):void
		{
			ReadXML.readInterfaceXML(data);
			
			if(MainData._isOnline){
				InterfaceData._allResourcesURL+="?unitId="+MainData._unitId+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
				InterfaceData._teacherEditURL+="?coursewaresId="+MainData._coursewaresId+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
				InterfaceData._teacherClassURL+="?userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
				InterfaceData._teacherShareURL+="?coursewaresId="+MainData._coursewaresId+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
//				InterfaceData._systemResURL+="?kcid="+MainData._unitId+"&t="+String(new Date().time);
				InterfaceData._systemResURL+="?kcid="+MainData._unitId+"&t="+String(new Date().time);
				
			}else{
				InterfaceData._allResourcesURL="data/GetFileByUnitCodeByWebC.txt";//"http://cloudteach.app.xuele.net/coursewares/extfl/disklist?userId=265143510212&schoolId=SchoolIDQATestsm55&unitId=020001001004009001001&fileType=4&extType=0";//"data/GetFileByUnitCodeByWebC.txt";
				InterfaceData._teacherEditURL="data/CoursewareGetByID.txt";
				InterfaceData._teacherClassURL="data/GetTeacherClass.txt";
				InterfaceData._systemResURL="http://ebookfile.xueleyun.com/fzkbList.ashx?kcid=010004002001001001002";
			}
			
			/*
			MainData._isOnline=true;
			MainData._teachType=4;
			MainData._unitName="Lesson 1 Hello!";
			MainData._coursewaresId="b5a63618a6464737939280fcedd096d2";
			MainData._userId="265143510212";
			MainData._schoolId="SchoolIDQATestsm55";
			InterfaceData._allResourcesURL+="?unitId="+MainData._unitId+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
			InterfaceData._teacherEditURL+="?coursewaresId="+MainData._coursewaresId+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
			InterfaceData._teacherClassURL+="?userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
			InterfaceData._teacherShareURL+="?coursewaresId="+MainData._coursewaresId+"&userId="+MainData._userId+"&schoolId="+MainData._schoolId+"&t="+String(new Date().time);
			InterfaceData._systemResURL+="?kcid="+MainData._unitId+"&t="+String(new Date().time);
			*/
			loadJSONData();
		}
		private function loadJSONData():void
		{
			
			if(MainData._teachType==3){
				var urlAry:Array=[InterfaceData._teacherShareURL,InterfaceData._teacherClassURL,InterfaceData._systemResURL];
			}else if(MainData._teachType==4){
				var clsResURL:String=InterfaceData._allResourcesURL+"&fileType=6";
				urlAry=[InterfaceData._teacherClassURL,InterfaceData._systemResURL,clsResURL];
			}else{
				urlAry=[InterfaceData._teacherEditURL,InterfaceData._teacherClassURL,InterfaceData._systemResURL];
			}
			
			DomLoader.loadMultiTexts(urlAry,onJSONData,onCurrnetJSONCom,PopUtils.loadingPro,PopUtils.IOError)
		}
		private function onCurrnetJSONCom(data:String,n:int):void
		{
			PopUtils.createLoading();
		}
		private function onJSONData(data:Array):void
		{
			if(MainData._teachType!=4){
				if(data[0]==null||data[0]==""){
					data[0]=JSON.stringify({"state":0});
				}
				if(data[1]==null||data[1]==""){
					data[1]=JSON.stringify({"state":0});
				}
				if(data[2]==null||data[2]==""){
					data[2]=JSON.stringify({"state":0});
				}
//				if(data[3]==null||data[3]==""){
//					data[3]=JSON.stringify({"state":0});
//				}
//				ReadJSON.readAllResources(data[0]);
				ReadJSON.readShoukeInfo(data[0]);
				ReadJSON.readTeacherClass(data[1]);
				ReadJSON.readSystemRes(data[2]);
			}else{
				if(data[0]==null){
					data[0]=JSON.stringify({"state":0});
				}
				if(data[1]==null){
					data[1]=JSON.stringify({"state":0});
				}
				if(data[2]==null){
					data[2]=JSON.stringify({"status":0});
				}
//				if(data[3]==null){
//					data[3]=JSON.stringify({"state":0});
//				}
//				ReadJSON.readAllResources(data[0]);
				ReadJSON.readTeacherClass(data[0]);
				ReadJSON.readSystemRes(data[1]);
				ReadJSON.readClassRes(data[2]);
			}
			loadUI();
		}
		private function loadUI():void
		{
//			InterfaceData._uiURL="data/skui.swf"
			DomLoader.loadLoader(InterfaceData._uiURL,onUI,PopUtils.loadingPro,PopUtils.IOError);
		}
		private var timer:Timer;
		private function onUI(data:Loader):void
		{
			MainData.uiArray[0]=data;
			if(this._mainGroup.stage){
				this._mainGroup.createUI();
			}else{
				timer=new Timer(1000,1);
				timer.addEventListener(TimerEvent.TIMER,timerHandler);
				timer.start();
			}
		}
		private function timerHandler(e:TimerEvent):void
		{
			timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			this._mainGroup.createUI();
		}
		private function createUI():void
		{
			this._mainGroup=new Main;
			this.addElement(_mainGroup);
			this._popGroup=new Group;
			this.addElement(_popGroup);
			_popGroup.width=stage.stageWidth;
			_popGroup.height=stage.stageHeight;
			CommondView.popView=this._popGroup;
			CommondView.mainView=this._mainGroup;
		}
	}
}