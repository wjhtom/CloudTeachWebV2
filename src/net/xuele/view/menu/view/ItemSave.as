package net.xuele.view.menu.view
{
	import net.xuele.commond.CommondView;
	import net.xuele.utils.PublicOperate;

	/**
	 * 保存 
	 * @author jianhua
	 * 
	 */
	public class ItemSave extends ItemView
	{
		public function ItemSave(t:int)
		{
			super(t);
		}
		override protected function itemClick():void
		{
			PublicOperate.savePageData();
		}
	}
}