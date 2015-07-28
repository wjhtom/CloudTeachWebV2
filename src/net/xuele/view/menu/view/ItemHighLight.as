package net.xuele.view.menu.view
{
	import net.xuele.view.menu.utils.MenuData;

	/**
	 * 设置高亮 
	 * @author jianhua
	 * 
	 */
	public class ItemHighLight extends ItemView
	{
		public function ItemHighLight(t:int)
		{
			super(t);
		}
		override protected function itemClick():void
		{
			this._UIMovie.gotoAndStop(1);
			MenuData._currentMenu=this._UIMovie;
		}
	}
}