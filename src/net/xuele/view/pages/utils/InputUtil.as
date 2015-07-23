package net.xuele.view.pages.utils
{
	import flash.events.Event;
	
	import net.xuele.commond.CommondView;
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
			var factory:ResFactory=new ResFactory;
			var inputRes:IResShow=factory.createResShow();
			CommondView.contentView.addRes(inputRes);
			PagesData._currentInput=inputRes;
			if(IBigPage(CommondView.contentView).resGroup.numElements<12){
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
			_inputMenu.addEventListener(Event.ENTER_FRAME,inputMenuEnter);
			callLater(showInputMenu,null,2);
		}
		private static function showInputMenu():void
		{
			_inputMenu.visible=true;
		}
		private static function inputMenuEnter(e:Event):void
		{
			if(_inputMenu.width>PagesData._currentInput.width){
				_inputMenu.x=PagesData._currentInput.x-(_inputMenu.width-PagesData._currentInput.width)/2;
			}else{
				_inputMenu.x=PagesData._currentInput.x+(PagesData._currentInput.width-_inputMenu.width)/2;
			}
			_inputMenu.y=PagesData._currentInput.y+PagesData._currentInput.height;
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