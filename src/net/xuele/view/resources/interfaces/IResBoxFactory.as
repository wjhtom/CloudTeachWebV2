package net.xuele.view.resources.interfaces
{
	import net.xuele.vo.ResourceVo;

	public interface IResBoxFactory
	{
		function createRes(resVo:ResourceVo):IResBox;
	}
}