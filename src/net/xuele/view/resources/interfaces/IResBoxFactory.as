package net.xuele.view.resources.interfaces
{
	import net.xuele.vo.ResourceVo;

	public interface IResBoxFactory
	{
		function createResBox(resVo:ResourceVo):IResBox;
		function createResShow(resVo:ResourceVo):IResShow;
	}
}