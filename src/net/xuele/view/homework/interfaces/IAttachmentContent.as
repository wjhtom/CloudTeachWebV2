package net.xuele.view.homework.interfaces
{
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.core.IVisualElement;
	
	public interface IAttachmentContent extends IVisualElement
	{
		function get resVo():ResourceVo;
		function select():void
		function unSelect():void
		function get isSelect():Boolean
		function set isSelect(v:Boolean):void
	}
}