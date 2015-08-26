package net.xuele.view.menu.view
{
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextFormatAlign;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.InterfaceData;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.menu.utils.MenuData;
	
	import org.flexlite.domUI.components.EditableText;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	

	/**
	 * 保存 
	 * @author jianhua
	 * 
	 */
	public class ItemSave extends ItemView
	{
		public function ItemSave(t:int)
		{
			super(t);
		}
		override protected function itemClick():void
		{
			if(stage.displayState==StageDisplayState.FULL_SCREEN){
				stage.displayState=StageDisplayState.NORMAL;
				MenuData._fullScreenUI.gotoAndStop(0);
			}
			createAffirm();
		}
		private var _saveGroup:Group;
		private var _okBtn:McButton;
		private var _cancelBtn:McButton;
		private var _nameTxt:EditableText;
		private function createAffirm():void
		{
			_saveGroup=new Group;
			var saveBg:UIAsset=new UIAsset;
			saveBg.skinName=PublicOperate.getUI("SaveBg");
			_nameTxt=new EditableText;
			_nameTxt.textAlign=TextFormatAlign.LEFT;
			_nameTxt.width=180;
			_nameTxt.height=18;
			_nameTxt.maxChars=14;
			if(MainData._coursewaresName!=""){
				_nameTxt.text=MainData._coursewaresName;
			}
			
			var txtBg:Rect=new Rect;
			txtBg.width=_nameTxt.width;
			txtBg.height=_nameTxt.height;
			txtBg.strokeAlpha=0.85;
			txtBg.strokeColor=0xcccccc;
			txtBg.fillAlpha=0;
			var titleTxt:Label=new Label;
			titleTxt.text="课件名："
			titleTxt.textAlign=TextFormatAlign.LEFT;
			_okBtn=new McButton;
			_okBtn.skinName=PublicOperate.getUI("SaveOKBtn","movieclip");
			_cancelBtn=new McButton;
			_cancelBtn.skinName=PublicOperate.getUI("SaveCancelBtn","movieclip");
			
			
			_saveGroup.addElement(saveBg);
			_saveGroup.addElement(titleTxt);
			titleTxt.left=10;
			titleTxt.top=20;
			_saveGroup.addElement(txtBg);
			txtBg.horizontalCenter=0;
			txtBg.verticalCenter=0;
			_saveGroup.addElement(_nameTxt);
			_nameTxt.horizontalCenter=0;
			_nameTxt.verticalCenter=0;
			_saveGroup.addElement(_okBtn);
			_okBtn.bottom=5;
			_okBtn.right=80;
			_saveGroup.addElement(_cancelBtn);
			_cancelBtn.bottom=5;
			_cancelBtn.right=10;
			
			
			_okBtn.addEventListener(MouseEvent.CLICK,okHandler);
			_cancelBtn.addEventListener(MouseEvent.CLICK,cancelHandler);
			
			CommondView.menuView.addElement(_saveGroup);
			_saveGroup.bottom=0;
			_saveGroup.right=150;
			_nameTxt.setFocus();
		}
		private function okHandler(e:MouseEvent):void
		{
			if(_nameTxt.text==""){
				PublicOperate.setAlert("内容为空","请命名后再保存！");
				return;
			}
			MainData._coursewaresName=_nameTxt.text;
			saveData();
		}
		private function cancelHandler(e:MouseEvent):void
		{
			closeAffirmPage();
			
		}
		private function closeAffirmPage():void
		{
			_okBtn.removeEventListener(MouseEvent.CLICK,okHandler);
			_cancelBtn.removeEventListener(MouseEvent.CLICK,cancelHandler);
			CommondView.menuView.removeElement(_saveGroup);
		}
		private function saveData():void
		{
			var str:String=PublicOperate.savePageData();
			
			var sendLoader:URLLoader = new URLLoader();
			var myRequest:URLRequest = new URLRequest();
			var v:URLVariables = new URLVariables();
			
			v.content = str;
			if(MainData._coursewaresId==null){
				v.coursewaresId="";
			}else{
				v.coursewaresId=MainData._coursewaresId;
			}
//			v.coursewaresId="e77a854853f74a6cacbf18c0510022a4";
			v.coursewaresName=_nameTxt.text;//
			v.userId=MainData._userId;
			v.schoolId=MainData._schoolId;
			v.unitId=MainData._unitId;
			myRequest.url = InterfaceData._saveURL;
			myRequest.data = v;
			myRequest.method = URLRequestMethod.POST;
			
			
			sendLoader.load(myRequest);
			sendLoader.addEventListener(Event.COMPLETE, sendComHandler);
			sendLoader.addEventListener(IOErrorEvent.IO_ERROR,PopUtils.IOError);
		}
		private function sendComHandler(e:Event):void 
		{
			var obj:Object=JSON.parse(e.target.data);
			trace(e.target.data)
			switch(obj.state){
				case "1":
					trace("提交成功")
					if(obj.id){
						MainData._coursewaresId=obj.id;
					}
					PublicOperate.setAlert("成功","保存成功！");
					closeAffirmPage();
					break;
				case "0":
					trace("提交失败")
					break;
				default:
					break;
			}
		}	
	}
}