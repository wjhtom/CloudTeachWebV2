package net.xuele.view.menu.view
{
	import net.xuele.utils.InterfaceData;
	import net.xuele.view.homework.utils.HomeworkUtils;

	/**
	 * 习题作业 
	 * @author jianhua
	 * 
	 */
	public class ItemHomework extends ItemView
	{
		public function ItemHomework(t:int)
		{
			super(t);
		}
		override protected function itemClick():void
		{
			super.itemClick();
			
			HomeworkUtils.openHomeworkList();
		}
	}
}