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
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResTransform;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.UIComponent;
	
	public class PageView extends Group implements IBigPage
	{
		private var _drawGroup:Group;
		private var _resGroup:Group;
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
			this._resGroup.addElement(res);
//			if(res is ImageShow || res is DocShow){
				res.addEventListener(ResEvent.LOADRESCOM,function(e:ResEvent):void{loadResComHandler(e,res)});
//			}else{
//				res.x=this.mouseX;
//				res.y=this.mouseY;
//				res.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
//				res.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
//			}
			
		}
		private function loadResComHandler(e:ResEvent,res:IResShow):void
		{
			if(res is ImageShow || res is DocShow){
				var rect:Rectangle=Group(res).getBounds(this.stage);
				res.x=(stage.stageWidth-rect.width)/2;
				res.y=0;
			}else{
				res.x=this.mouseX;
				res.y=this.mouseY;
			}
			res.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{downHandler(e,res)});
			res.dragGroup.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void{upHandler(e,res)});
			res.dragGroup.addEventListener(MouseEvent.RELEASE_OUTSIDE,function(e:MouseEvent):void{upHandler(e,res)});
		}
		private  var downTime:Number;
		private  function downHandler(e:MouseEvent,res:IResShow):void
		{
//			var tempRes:IResShow=IResShow(UIComponent(e.currentTarget).parent);
			if(res is ImageShow || res is DocShow){
				downTime=getTimer();
			}
			Group(res).startDrag();
			
		}
		private  function upHandler(e:MouseEvent,res:IResShow):void
		{
//			var tempRes:IResShow=IResShow(UIComponent(e.currentTarget).parent);
			var tempRes:IResShow=res;
			if(tempRes is ImageShow || tempRes is DocShow){
				if(getTimer()-downTime<150){
					if(ResData._currentEditRes!=null){
						ResTransform.removeTransRes();
					}
					tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{downHandler(e,res)});
					tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void{upHandler(e,res)});
					tempRes.addEventListener(ResEvent.ADDRESLISTENER,addListenerHandler);
					ResTransform.setTransRes(tempRes);
				}
			}
			Group(tempRes).stopDrag();
		}
		private  function addListenerHandler(e:ResEvent):void
		{
			var res:IResShow=ResData._currentEditRes;
			ResData._currentEditRes.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{downHandler(e,res)});
			ResData._currentEditRes.dragGroup.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void{upHandler(e,res)});
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
	}
}