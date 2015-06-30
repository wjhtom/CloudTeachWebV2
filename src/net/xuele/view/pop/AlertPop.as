package net.xuele.view.pop
{
	import flash.events.MouseEvent;
	
	import net.xuele.interfaces.IPop;
	import net.xuele.utils.PopUtils;
	
	import org.flexlite.domUI.components.Alert;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.events.CloseEvent;
	import org.flexlite.domUI.events.UIEvent;
	
	/**
	 * 弹出警告 
	 * @author jianhua
	 * 
	 */
	public class AlertPop extends Group implements IPop
	{
		private var _alertInfo:String;
		public function AlertPop(str)
		{
			super();
			this._alertInfo=str;
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
//			createUI();
		}
		public function createUI():void
		{
//			var rect:Rect=new Rect;
//			rect.width=100;
//			rect.height=100;
//			rect.fillAlpha=1;
//			rect.fillColor=0xff0000;
//			this.addElement(rect);
			if(this._alertInfo!=""){
				alert=Alert.show(this._alertInfo,"错误",close);
			}else{
				var alert:Alert=Alert.show("未知错误","错误",close);
			}
		}
		private function close(e:CloseEvent):void
		{
			removeUI();
		}
		public function removeUI():void
		{
			PopUtils.upPop(this);
		}
			
	}
}