package net.xuele.view.resources.resShow
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import net.xuele.utils.PopUtils;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUtils.DomLoader;
	
	
	/**
	 * 文档显示 
	 * @author jianhua
	 * 
	 */
	public class DocShow extends EditResBase
	{
		public function DocShow()
		{
			super();
		}
		override protected function createRes():void
		{
			PopUtils.createLoading();
			this._resVo._path="";
			var loader:URLLoader=new URLLoader;
			var requst:URLRequest=new URLRequest;
			
		}
	}
}