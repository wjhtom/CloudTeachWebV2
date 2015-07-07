package net.xuele.view.resources.interfaces
{
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;

	public interface IResFactory
	{
		function createResBox(resVo:ResourceVo):IResBox;
		function removeResBox(domain:Group,res:IResBox):void;
		function createResShow(resVo:ResourceVo):IResShow;
		function removeResShow(domain:Group,res:IResShow):void;
	}
}