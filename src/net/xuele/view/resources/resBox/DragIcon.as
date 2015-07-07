package net.xuele.view.resources.resBox
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResBox;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.utils.ResShowUtil;
	import net.xuele.view.resources.utils.ResUtils;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	
	public class DragIcon extends Group implements IResBox
	{
		private var _resVo:ResourceVo;
		private var _resFactory:ResFactory;
		public function DragIcon(resVo:ResourceVo)
		{
			super();
			this._resVo=resVo;
			this._resFactory=new ResFactory;
			createUI();
		}
		
		private var _ico:UIAsset;
		public function createUI():void
		{
			_ico=ResUtils.getResIcon("");
			_ico.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			_ico.addEventListener(MouseEvent.RELEASE_OUTSIDE,mouseUpHandler);
			var icoTimer:Timer=new Timer(20,1);
			icoTimer.addEventListener(TimerEvent.TIMER,timerHandler);
			icoTimer.start();
		}
		private function timerHandler(e:TimerEvent):void
		{
			Timer(e.target).removeEventListener(TimerEvent.TIMER,timerHandler);
			this.addElement(_ico);
			_ico.x=mouseX-_ico.width/2;
			_ico.y=mouseY-_ico.height/2;
			_ico.startDrag();
		}
		private function mouseUpHandler(e:MouseEvent):void
		{
			_ico.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			_ico.removeEventListener(MouseEvent.RELEASE_OUTSIDE,mouseUpHandler);
			_ico.addEventListener(MouseEvent.RELEASE_OUTSIDE,mouseUpHandler);
			_ico.stopDrag();
			this.removeElement(_ico);
			if(e.stageY<290){
//				var res:IResShow=this._resFactory.createResShow(this._resVo);
				ResShowUtil.createResShow(_resVo);
			}
		}
		public function removeListener():void
		{
			
		}
		
		public function selected():void
		{
		}
		
		public function reSelect():void
		{
		}
		
		public function get resVo():ResourceVo
		{
			return this._resVo;
		}
	}
}