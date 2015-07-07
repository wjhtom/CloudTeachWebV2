package net.xuele.view.resources.resShow
{
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	
	/**
	 * 文档显示 
	 * @author jianhua
	 * 
	 */
	public class DocShow extends Group implements IResShow
	{
		public function DocShow()
		{
			super();
		}
		
		public function editRes():void
		{
		}
		
		public function createUI(resVo:ResourceVo):void
		{
		}
		
		public function resetRes():void
		{
		}
		
		public function removeListener():void
		{
		}
		
		public function startResDrag():void
		{
			
		}
		
		public function stopResDrag():void
		{
			
		}
	}
}