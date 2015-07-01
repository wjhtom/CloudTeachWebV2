package net.xuele
{
	import flash.display.Loader;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.InterfaceData;
	import net.xuele.utils.MainData;
	import net.xuele.utils.MainTheme;
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.ReadJSON;
	import net.xuele.utils.ReadXML;
	import net.xuele.view.Main;
	
	import org.flexlite.domCore.Injector;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.Theme;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.managers.SystemManager;
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
			Injector.mapClass(Theme,MainTheme);
			createUI();
			loadInterfaceXML();
		}
		private function loadInterfaceXML():void
		{
			PopUtils.createLoading();
			if(MainData._isOnline){
				
			}else{
				DomLoader.loadXML(InterfaceData._interfaceListURL,onInterfaceXML,PopUtils.loadingPro,PopUtils.IOError);
			}
		}
		private function onInterfaceXML(data:XML):void
		{
			ReadXML.readInterfaceXML(data);
			InterfaceData._uiURL="data/ui.swf";
			InterfaceData._allResourcesURL="data/GetFileByUnitCodeByWebC.txt";
			InterfaceData._teacherEditURL="data/CoursewareGetByID.txt";
			InterfaceData._teacherClassURL="data/GetTeacherClass.txt";
			loadJSONData();
		}
		private function loadJSONData():void
		{
			MainData._teachType=1;
			if(MainData._teachType==3){
				var urlAry:Array=[InterfaceData._allResourcesURL,InterfaceData._teacherShareURL,InterfaceData._teacherClassURL];
			}else{
				urlAry=[InterfaceData._allResourcesURL,InterfaceData._teacherEditURL,InterfaceData._teacherClassURL];
			}
			if(MainData._isOnline){
				
			}else{
				DomLoader.loadMultiTexts(urlAry,onJSONData,onCurrnetJSONCom,PopUtils.loadingPro,PopUtils.IOError)
			}
		}
		private function onCurrnetJSONCom(data:String,n:int):void
		{
			PopUtils.createLoading();
		}
		private function onJSONData(data:Array):void
		{
			ReadJSON.readAllResources(data[0]);
			ReadJSON.readShoukeInfo(data[1]);
			ReadJSON.readTeacherClass(data[2]);
			loadUI();
		}
		private function loadUI():void
		{
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