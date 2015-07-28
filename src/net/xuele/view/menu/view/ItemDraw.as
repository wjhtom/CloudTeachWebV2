package net.xuele.view.menu.view
{
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.menu.utils.MenuData;

	/**
	 * 画直线 
	 * @author jianhua
	 * 
	 */
	public class ItemDraw extends ItemView
	{
		public function ItemDraw(t:int)
		{
			super(t);
		}
		override protected function itemClick():void
		{
			PublicOperate.setMouseType(2);
			this._UIMovie.gotoAndStop(1);
			MenuData._currentMenu=this._UIMovie;
		}
	}
}