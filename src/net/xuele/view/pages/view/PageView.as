package net.xuele.view.pages.view
{
	import com.senocular.display.TransformTool;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.menu.view.DelMovie;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResShowUtil;
	import net.xuele.view.resources.utils.ResTransform;
	
	import org.flexlite.domUI.components.Alert;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.UIComponent;
	
	public class PageView extends Group implements IBigPage
	{
		private var _drawGroup:Group;
		private var _resGroup:Group;
		private const _maxResNum:int=10;
		private var _delMC:DelMovie;
		
		private var _resShow:IResShow;
		public function PageView()
		{
			super();
		}
		public function createUI():void
		{
			var timer:Timer=new Timer(20,1);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void
		{
			Timer(e.currentTarget).removeEventListener(TimerEvent.TIMER,timerHandler);
			init();
		}
		
		private var defaultTool:TransformTool;
		// custom tool with some custom options
		private var customTool:TransformTool;
		private function init():void
		{
			defaultTool=new TransformTool;
			customTool=new TransformTool;
			ResData._currentTools=defaultTool;
			ResData._currentTools.skewEnabled=false;
			ResData._currentTools.constrainScale=true;
			ResData._currentTools.minScaleEnabled=true;
			ResData._currentTools.minScaleX=0.1;
			ResData._currentTools.minScaleY=0.1;
			trace(ResData._currentTools.boundsBottomLeft);
			
			this._resGroup=new Group;
			this.addElement(this._resGroup);
			this._resGroup.mouseEnabled=false;
			_resGroup.addElement(defaultTool);
			_resGroup.addElement(customTool);
			_resGroup.width=stage.stageWidth;
			_resGroup.height=stage.stageHeight-50;
			this._drawGroup=new Group;
			this._drawGroup.width=stage.stageWidth;
			this._drawGroup.height=stage.stageHeight;
			this._drawGroup.mouseEnabled=false;
			this._drawGroup.mouseChildren=false;
			this.addElement(_drawGroup);
			addListener();
		}
		private function addListener():void
		{
		}
		private function clickHandler(e:MouseEvent):void
		{
			trace(e.currentTarget);
		}
		public function addRes(res:IResShow):void
		{
			if(this._resGroup.numElements>=this._maxResNum){
				PublicOperate.setAlert("资源已满","当前页面资源数已满，请添加新页面");
				return;
			}
			_resShow=res;
			this._resGroup.addElement(_resShow);
//			if(res is ImageShow || res is DocShow){
			_resShow.addEventListener(ResEvent.LOADRESCOM,loadResComHandler);
//			}else{
//				res.x=this.mouseX;
//				res.y=this.mouseY;
//				res.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
//				res.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
//			}
			
		}
		private function loadResComHandler(e:ResEvent):void
		{
			if(_resShow is ImageShow || _resShow is DocShow){
				var rect:Rectangle=Group(_resShow).getBounds(this.stage);
				_resShow.x=(stage.stageWidth-rect.width)/2;
				_resShow.y=0;
			}else{
				_resShow.x=this.mouseX;
				_resShow.y=this.mouseY;
			}
			_resShow.isOpen=true;
			_resShow.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			_resShow.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
			_resShow.dragGroup.addEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
		}
		private  var downTime:Number;
		private  function downHandler(e:MouseEvent):void
		{
//			var tempRes:IResShow=IResShow(UIComponent(e.currentTarget).parent);
			if(_resShow is ImageShow || _resShow is DocShow){
				downTime=getTimer();
			}
			if(ResData._currentEditRes==null){
				_delMC=new DelMovie;
				this.addElement(_delMC);
				_delMC.right=0;
				_delMC.bottom=0;
			}
			Group(_resShow).startDrag();
			
		}
		private  function upHandler(e:MouseEvent):void
		{
//			var tempRes:IResShow=IResShow(UIComponent(e.currentTarget).parent);
			var tempRes:IResShow=_resShow;
			if(tempRes is ImageShow || tempRes is DocShow){
				if(getTimer()-downTime<150){
					if(ResData._currentEditRes!=null){
						ResTransform.removeTransRes();
					}
					tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
					tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_UP,upHandler);
					tempRes.addEventListener(ResEvent.ADDRESLISTENER,addListenerHandler);
					ResTransform.setTransRes(tempRes);
				}
			}
			if(_delMC.hitTestPoint(this.mouseX,this.mouseY,true)){
//				tempRes.removeListener();
//				this._resGroup.removeElement(tempRes);
				ResShowUtil.removeResShow(this._resGroup,tempRes);
			}
			this.removeElement(_delMC);
			Group(tempRes).stopDrag();
			
		}
		private  function addListenerHandler(e:ResEvent):void
		{
			_resShow.removeEventListener(ResEvent.ADDRESLISTENER,addListenerHandler);
			_resShow.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			_resShow.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
		}
		public function createSmallPage():void
		{
		}
		
		public function removeListener():void
		{
		}
		public function get drawGroup():Group
		{
			return _drawGroup;
		}
		public function get resGroup():Group
		{
			return _resGroup;
		}
	}
}