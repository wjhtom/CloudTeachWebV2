package net.xuele.view.resources.resShow
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.vo.ContentVo;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.core.UIComponent;
	
	public class ResBase extends Group implements IResShow
	{
		protected var _resGroup:Group;
		protected var _resVo:ResourceVo;
		protected var _contentVo:ContentVo;
		protected var _isOpen:Boolean;
		protected var _dragRect:UIComponent;
		protected var _resID:String;
		/**
		 * 初使化还是新建（true：初使化，false：新建）
		 */
		protected var _isCreate:Boolean=false;
		public function ResBase()
		{
			super();
		}
		
		public function createUI(resVo:ResourceVo):void
		{
			this._resVo=resVo;
			this._isCreate=false;
			getThisStage();
		}
		public function createResInfo(contentVo:ContentVo):void
		{
			this._contentVo=contentVo;
			this._isCreate=true;
			getThisStage();
		}
			
		private function getThisStage():void
		{
			var timer:Timer=new Timer(20,1);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void
		{
			Timer(e.target).removeEventListener(TimerEvent.TIMER,timerHandler);
//			createDragRect();
			init();
		}
		
		protected function init():void
		{
			
		}
		public function removeListener():void
		{
		}
		public function get isOpen():Boolean
		{
			return this._isOpen;
		}
		public function set isOpen(value:Boolean):void
		{
			this._isOpen=value;
		}
		public function get drawGroup():Group
		{
			return null;
		}
		public function get dragGroup():UIComponent
		{
			if(_dragRect!=null){
				return _dragRect;
			}else{
				return null;
			}
		}
		public function set resID(v:String):void
		{
			this._resID=v;
		}
		public function get resID():String
		{
			return this._resID;
		}
	}
}