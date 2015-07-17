package net.xuele.view.pages.view
{
	import com.senocular.display.TransformTool;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.menu.view.DelMovie;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResShowUtil;
	import net.xuele.view.resources.utils.ResTransform;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.UIComponent;
	
	public class PageView extends Group implements IBigPage
	{
		private var _drawGroup:Group;
		private var _resGroup:Group;
		private const _maxResNum:int=10;
		private var _delMC:DelMovie;
		
		private var _smallResView:SmallResView;
		
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
			Timer(e.target).removeEventListener(TimerEvent.TIMER,timerHandler);
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
			
			_smallResView=new SmallResView;
			this.addElement(_smallResView);
			addListener();
		}
		private function addListener():void
		{
		}
		public function addRes(res:IResShow):void
		{
			if(this._resGroup.numElements>=this._maxResNum){
				PublicOperate.setAlert("资源已满","当前页面资源数已满，请添加新页面");
				return;
			}
			this._resGroup.addElement(res);
			res.resID=res.name;
			res.addEventListener(ResEvent.LOADRESCOM,loadResComHandler);
			
		}
		private function loadResComHandler(e:ResEvent):void
		{
			var res:IResShow=IResShow(e.currentTarget);
			if(res is ImageShow || res is DocShow){
				var rect:Rectangle=Group(res).getBounds(this.stage);
				res.x=(stage.stageWidth-rect.width)/2;
				res.y=0;
			}else{
				res.x=this.mouseX;
				res.y=this.mouseY;
			}
			Group(res).mouseEnabled=false;
			res.isOpen=true;
			res.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			res.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
			res.dragGroup.addEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
		}
		private  var downTime:Number;
		private  function downHandler(e:MouseEvent):void
		{
			var tempRes:IResShow=IResShow(UIComponent(e.currentTarget).parent);
			if(ResData._currentEditRes!=null){
				ResTransform.removeTransRes();
			}
			_resGroup.setElementIndex(tempRes,_resGroup.numElements-1);
			if(tempRes is ImageShow || tempRes is DocShow){
				downTime=getTimer();
			}
//			if(ResData._currentEditRes==null){
				_delMC=new DelMovie;
				this.addElement(_delMC);
				_delMC.right=0;
				_delMC.bottom=0;
//			}
			Group(tempRes).startDrag();
			
		}
		private  function upHandler(e:MouseEvent):void
		{
			var tempRes:IResShow=IResShow(UIComponent(e.currentTarget).parent);
//			var tempRes:IResShow=_resShow;
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
			if(_delMC!=null){
				if(_delMC.hitTestPoint(this.mouseX,this.mouseY,true)){
					ResShowUtil.removeResShow(this._resGroup,tempRes);
				}
				this.removeElement(_delMC);
				_delMC=null;
			}
			Group(tempRes).stopDrag();
			
		}
		private  function addListenerHandler(e:ResEvent):void
		{
			var res:IResShow=IResShow(e.target);
			res.removeEventListener(ResEvent.ADDRESLISTENER,addListenerHandler);
			res.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			res.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
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
		public function get defaultTools():TransformTool
		{
			return this.defaultTool;
		}
	}
}