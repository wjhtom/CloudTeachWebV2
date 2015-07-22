package net.xuele.view.pages.utils
{
	import net.xuele.commond.CommondView;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResShow;
	
	import org.flexlite.domUI.core.DomGlobals;

	/**
	 * 文字输入 
	 * @author jianhua
	 * 
	 */
	public class InputUtil
	{
		public function InputUtil()
		{
		}
		public static function startInput():void
		{
			if(PagesData._currentInput!=null){
				stopInput();
			}
			var factory:ResFactory=new ResFactory;
			var inputRes:IResShow=factory.createResShow();
			CommondView.contentView.addRes(inputRes);
			PagesData._currentInput=inputRes;
			
		}
		public static function stopInput():void
		{
			if(PagesData._currentInput!=null){
				PagesData._currentInput=null;
			}
		}
	}
}