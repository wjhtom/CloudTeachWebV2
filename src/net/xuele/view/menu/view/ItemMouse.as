package net.xuele.view.menu.view
{
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.menu.utils.MenuData;

	/**
	 * 鼠标 
	 * @author jianhua
	 * 
	 */
	public class ItemMouse extends ItemView
	{
		public function ItemMouse(t:int)
		{
			super(t);
		}
		override protected function itemClick():void
		{
			super.itemClick();
			PublicOperate.setMouseType(0);
			this._UIMovie.gotoAndStop(1);
			MenuData._currentMenu=this._UIMovie;
			
		}
	}
}