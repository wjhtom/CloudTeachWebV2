package net.xuele.view.resources.factory
{
	import net.xuele.view.resources.interfaces.IResBox;
	import net.xuele.view.resources.interfaces.IResBoxFactory;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resBox.ResView;
	import net.xuele.vo.ResourceVo;
	
	public class ResFactory implements IResBoxFactory
	{
		public function ResFactory()
		{
		}
		
		public function createResBox(resVo:ResourceVo):IResBox
		{
			var resBox:IResBox=new ResView(resVo);
			return resBox;
		}
		public function createResShow(resVo:ResourceVo):IResShow
		{
			
			return null;
		}
	}
}