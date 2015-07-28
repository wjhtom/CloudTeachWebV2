package net.xuele.view.menu.view
{
	import net.xuele.commond.CommondView;
	import net.xuele.view.menu.utils.MenuData;
	import net.xuele.view.resources.resBox.ResBoxView;

	/**
	 * 资源盒 
	 * @author jianhua
	 * 
	 */
	public class ItemResBox extends ItemView
	{
		public function ItemResBox(t:int)
		{
			super(t);
		}
		override protected function itemClick():void
		{
			if(MenuData._isResBoxShow){
				super.itemClick();
				MenuData._isResBoxShow=false;
				return;
			}
			super.itemClick();
			var resBox:ResBoxView=new ResBoxView;
			CommondView.menuView.addElement(resBox);
			MenuData._isResBoxShow=true;
			resBox.horizontalCenter=0;
		}
	}
}