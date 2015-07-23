package net.xuele.view.menu.view
{
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.pages.utils.InputUtil;

	/**
	 * 输入文字 
	 * @author jianhua
	 * 
	 */
	public class ItemInput extends ItemView
	{
		public function ItemInput(t:int)
		{
			super(t);
		}
		override protected function itemClick():void
		{
			if(MainData._mouseType!=4){
				super.itemClick();
			}
			PublicOperate.setMouseType(4);
			if(stage.displayState==StageDisplayState.FULL_SCREEN){
				stage.displayState=StageDisplayState.NORMAL;
				this._UIMovie.gotoAndStop(0);
			}else{
				stage.displayState=StageDisplayState.FULL_SCREEN;
				stage.scaleMode=StageScaleMode.EXACT_FIT;
				this._UIMovie.gotoAndStop(1);
			}
		}
	}
}