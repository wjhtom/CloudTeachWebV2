package net.xuele.view.resources.interfaces
{
	public interface IResShowFactory
	{
		function createRes():IResShow;
		function removeRes(res:IResShow):void;
	}
}