package net.xuele.view.menu.view
{
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
			
		}
	}
}