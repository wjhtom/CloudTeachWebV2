package net.xuele.view.menu.view
{
	import net.xuele.utils.PublicOperate;

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
		}
	}
}