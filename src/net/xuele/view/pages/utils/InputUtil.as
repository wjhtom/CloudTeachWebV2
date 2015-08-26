package net.xuele.view.pages.utils
{
	import flash.events.Event;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.InputMenu;
	import net.xuele.view.resources.resShow.InputShow;
	import net.xuele.view.resources.utils.ResShowUtil;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.DomGlobals;
	import org.flexlite.domUI.utils.callLater;

	/**
	 * 文字输入 
	 * @author jianhua
	 * 
	 */
	public class InputUtil
	{
		private static var _inputMenu:InputMenu;
		public function InputUtil()
		{
		}
		/**
		 * 开始输入文字 
		 * 
		 */
		public static function startInput():void
		{
			if(PagesData._currentInput!=null){
				stopInput();
			}
			if(IBigPage(CommondView.contentView).resAry.length>=10){
				PublicOperate.setAlert("资源已满","当前页面资源数已满，请添加新页面");
				return;
			}
			var factory:ResFactory=new ResFactory;
			var inputRes:IResShow=factory.createResShow();
			CommondView.contentView.addRes(inputRes,false);
			PagesData._currentInput=inputRes;
			if(IBigPage(CommondView.contentView).resAry.length<=10){
				createInputMenu();
			}
			
			
		}
		
		/**
		 * 停止输入文字 
		 * 
		 */
		public static function stopInput():void
		{
			if(PagesData._currentInput!=null){
				InputShow(PagesData._currentInput)._contentText.selectable=false;
				InputShow(PagesData._currentInput).dispatchEvent(new ResEvent(ResEvent.ADDINPUTLISTENER));
				InputShow(PagesData._currentInput).clearBg();
				if(InputShow(PagesData._currentInput)._contentText.text.length==0){
					
					ResShowUtil.removeResShow(IBigPage(CommondView.contentView).resGroup,PagesData._currentInput)
				}
				DomGlobals.stage.focus = null;
				PagesData._currentInput=null;
			}
			removeInputMenu();
			
		}
		/**
		 * 创建文本编辑器 
		 * 
		 */
		public static function createInputMenu():void
		{
			_inputMenu=new InputMenu;
			CommondView.resShowView.addElement(_inputMenu);
			
			_inputMenu.visible=false;
			
			callLater(showInputMenu,null,5);
		}
		private static function showInputMenu():void
		{
			_inputMenu.visible=true;
			if(InputShow(PagesData._currentInput)._contentText!=null){
				_inputMenu.setBold=InputShow(PagesData._currentInput)._contentText.bold;
				_inputMenu.setColor=InputShow(PagesData._currentInput)._contentText.textColor;
				_inputMenu.setItalic=InputShow(PagesData._currentInput)._contentText.italic;
				_inputMenu.setUnderline=InputShow(PagesData._currentInput)._contentText.underline;
				_inputMenu.setSize=InputShow(PagesData._currentInput)._contentText.size;
				_inputMenu.addEventListener(Event.ENTER_FRAME,inputMenuEnter);
			}
		}
		private static function inputMenuEnter(e:Event):void
		{
			if(_inputMenu.width>PagesData._currentInput.width){
				_inputMenu.x=PagesData._currentInput.x-(_inputMenu.width-PagesData._currentInput.width)/2;
			}else{
				_inputMenu.x=PagesData._currentInput.x+(PagesData._currentInput.width-_inputMenu.width)/2;
			}
			_inputMenu.y=PagesData._currentInput.y+PagesData._currentInput.height;
			if(PagesData._currentInput.x+PagesData._currentInput.width>MainData._stageWidth){
				PagesData._currentInput.x=MainData._stageWidth-PagesData._currentInput.width;
			}
			if(PagesData._currentInput.y+PagesData._currentInput.height>MainData._stageHeight-70){
				PagesData._currentInput.y=MainData._stageHeight-PagesData._currentInput.height-70;
			}
		}
		/**
		 * 关闭文本编辑器 
		 * 
		 */
		public static function removeInputMenu():void
		{
			if(_inputMenu!=null){
				_inputMenu.removeEventListener(Event.ENTER_FRAME,inputMenuEnter);
				CommondView.resShowView.removeElement(_inputMenu);
				_inputMenu=null;
			}
		}
		
	}
}