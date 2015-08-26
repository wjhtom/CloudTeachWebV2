package net.xuele.view.menu.view
{
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	
	import net.xuele.view.menu.utils.MenuData;
	

	/**
	 * 全屏 
	 * @author jianhua
	 * 
	 */
	public class ItemFullScreen extends ItemView
	{
		public function ItemFullScreen(t:int)
		{
			super(t);
		}
		override protected function itemClick():void
		{
//			super.itemClick();
			if(stage.displayState==StageDisplayState.FULL_SCREEN){
				stage.displayState=StageDisplayState.NORMAL;
				this._UIMovie.gotoAndStop(0);
			}else{
				stage.displayState=StageDisplayState.FULL_SCREEN;
				stage.scaleMode=StageScaleMode.EXACT_FIT;
				this._UIMovie.gotoAndStop(1);
			}
//			stage.align=StageAlign.TOP;
			MenuData._fullScreenUI=this._UIMovie;
			
		}
	}
}