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
	import net.xuele.view.pages.utils.InputUtil;
	import net.xuele.view.pages.utils.PagesData;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.interfaces.IResBox;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.view.resources.resShow.InputShow;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.view.resources.utils.ResShowUtil;
	import net.xuele.view.resources.utils.ResTransform;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.UIComponent;
	import org.flexlite.domUI.utils.callLater;
	
	public class PageView extends Group implements IBigPage
	{
		private var _drawGroup:Group;
		private var _resGroup:Group;
		private const _maxResNum:int=12;
		private var _delMC:DelMovie;
		
		private var _smallResView:SmallResView;
		private var _resAry:Array;
		
		/**
		 * 是否从保存数据创建 
		 */
		private var _isCreate:Boolean;
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
			_resGroup.width=MainData._stageWidth;//stage.stageWidth;
			_resGroup.height=MainData._stageHeight-50;//stage.stageHeight-50;
			this._drawGroup=new Group;
			this._drawGroup.width=MainData._stageWidth;//stage.stageWidth;
			this._drawGroup.height=MainData._stageHeight-50;//stage.stageHeight-50;
//			this._drawGroup.width=910;
//			this._drawGroup.height=stage.stageHeight-90;
			this._drawGroup.mouseEnabled=false;
			this._drawGroup.mouseChildren=false;
			this.addElement(_drawGroup);
			
			_smallResView=new SmallResView;
			this.addElement(_smallResView);
			_resAry=[];
			addListener();
		}
		private function addListener():void
		{
		}
		/**
		 *  
		 * @param res
		 * @param create true:从保存数据创建，false:鼠标拖出来创建
		 * 
		 */
		public function addRes(res:IResShow,create:Boolean):void
		{
			if(this._resGroup.numElements>=this._maxResNum){
				PublicOperate.setAlert("资源已满","当前页面资源数已满，请添加新页面");
				return;
			}
			this._isCreate=create;
			this._resGroup.addElement(res);
			this._resAry.push(res);
			res.isOpen=true;
			res.resID=res.name;
			res.addEventListener(ResEvent.LOADRESCOM,loadResComHandler);
			
		}
		private function loadResComHandler(e:ResEvent):void
		{
			var res:IResShow=IResShow(e.currentTarget);
			if(_isCreate){
				setCreateInfo(res);
			}else{
				setResInfo(res);
			}
		}
		private function setCreateInfo(res:IResShow):void
		{
			res.x=res.conVo._x;
			res.y=res.conVo._y;
			res.isOpen=res.conVo._isOpen;
			res.resID=res.name;
			Group(res).mouseEnabled=false;
			res.resScaleY=1;
			res.resScaleX=1;
			if(res is InputShow){
				InputShow(res)._contentText.selectable=false;
				Group(res).doubleClickEnabled=true;
				res.dragGroup.removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
				res.dragGroup.removeEventListener(MouseEvent.MOUSE_UP,upHandler);
				res.dragGroup.removeEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
				res.dragGroup.removeEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
				Group(res).addEventListener(MouseEvent.DOUBLE_CLICK,textDoubleClick);
				res.addEventListener(ResEvent.ADDINPUTLISTENER,textMouseEnabled);
				InputShow(res).dispatchEvent(new ResEvent(ResEvent.ADDINPUTLISTENER));
			}else{
				res.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
				res.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
				res.dragGroup.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
				res.dragGroup.addEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
			}
			if(res.conVo._place!=-1){
				this._smallResView.resAry[res.conVo._place]={resShow:res,x:(100-45)/2,y:10+(45+10)*res.conVo._place};
			}
			if(res.conVo._isOpen==0){
				res.dragGroup.removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
				res.dragGroup.removeEventListener(MouseEvent.MOUSE_UP,upHandler);
				res.dragGroup.removeEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
				res.dragGroup.removeEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
				
				callLater(setSmallInfo,[res],0);
				
			}
		}
		private function setSmallInfo(res:IResShow):void
		{
			Group(res).validateNow();
			this._smallResView.addRes(res);
		}
			
		public function getResFormSmallView(res:IResShow):void
		{
			this._resGroup.addElement(res);
			Group(res).scaleX=res.resScaleX;
			Group(res).scaleY=res.resScaleY;
			setResInfo(res);
			this._smallResView.closeBox();
			if(res is InputShow){
				res.dispatchEvent(new ResEvent(ResEvent.ADDINPUTLISTENER));
			}
		} 
		private function setResInfo(res:IResShow):void
		{
			if(res is ImageShow || res is DocShow){
				var tempW:Number=CommondView.resShowView.width;
				var tempH:Number=CommondView.resShowView.height-50;
				if(res.width>=tempW&&res.height>=tempH){
					if(tempW/res.width>tempH/res.height){
						var scale:Number=tempH/res.height;
					}else{
						scale=tempW/res.width;
					}
				}else if(res.width>=tempW&&res.height<tempH){
					scale=tempW/res.width;
				}else if(res.width<tempW&&res.height>=tempH){
					scale=tempH/res.height;
				}else{
					scale=1;
				}
				Group(res).scaleX=Group(res).scaleY=scale;
				var rect:Rectangle=Group(res).getBounds(this.stage);
				res.x=(MainData._stageWidth-rect.width)/2;
				res.y=(MainData._stageHeight-rect.height)/2;
			}else{
				res.x=this.mouseX;
				res.y=this.mouseY;
			}
			Group(res).mouseEnabled=false;
			res.isOpen=true;
			if(res is InputShow){
				
				Group(res).doubleClickEnabled=true;
				res.dragGroup.removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
				res.dragGroup.removeEventListener(MouseEvent.MOUSE_UP,upHandler);
				res.dragGroup.removeEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
				res.dragGroup.removeEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
				Group(res).addEventListener(MouseEvent.DOUBLE_CLICK,textDoubleClick);
				res.addEventListener(ResEvent.ADDINPUTLISTENER,textMouseEnabled);
			}else{
				res.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
				res.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
				res.dragGroup.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
				res.dragGroup.addEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
			}
		}
		private function textDoubleClick(e:MouseEvent):void
		{
			trace("double");
			if(PagesData._currentInput!=null){
				InputUtil.stopInput();
			}
			var res:IResShow=IResShow(e.currentTarget);
			InputShow(res)._contentText.selectable=true;
			
			PagesData._currentInput=res;
			PublicOperate.setMouseType(4);
			InputShow(res).setStroke();
			InputUtil.createInputMenu();
			res.dragGroup.removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			res.dragGroup.removeEventListener(MouseEvent.MOUSE_UP,upHandler);
			res.dragGroup.removeEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
			res.dragGroup.removeEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
			res.addEventListener(ResEvent.ADDINPUTLISTENER,textMouseEnabled);
		}
		private function textMouseEnabled(e:ResEvent):void
		{
			var res:IResShow=IResShow(e.target);
			res.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			res.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
			res.dragGroup.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
			res.dragGroup.addEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
		}
		private  var downTime:Number;
		private var _mouseIsDown:Boolean=false;
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
				_delMC.right=50;
				_delMC.bottom=40;
//			}
			_mouseIsDown=true;
			Group(tempRes).startDrag();
			
		}
		
		private  function upHandler(e:MouseEvent):void
		{
			var tempRes:IResShow=IResShow(UIComponent(e.currentTarget).parent);
			if(tempRes is ImageShow || tempRes is DocShow){
				if(getTimer()-downTime<150){
					if(ResData._currentEditRes!=null){
						ResTransform.removeTransRes();
					}
					tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
					tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_UP,upHandler);
					tempRes.dragGroup.removeEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
					tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
					tempRes.addEventListener(ResEvent.ADDRESLISTENER,addListenerHandler);
					ResTransform.setTransRes(tempRes);
				}
			}
			if(_delMC!=null){
				if(_delMC.hitTestPoint(this.mouseX,this.mouseY,true)){
					var at:int=PagesData._currentPage.resAry.indexOf(tempRes);
					PagesData._currentPage.resAry.splice(at,1);
					ResShowUtil.removeResShow(this._resGroup,tempRes);
					this._smallResView.delRes(tempRes);
				}
				this.removeElement(_delMC);
				_delMC=null;
			}
			_mouseIsDown=false;
			Group(tempRes).stopDrag();
			//this._smallResView.hitTestPoint(this.mouseX,this.mouseY,false)
			if(this.mouseX<150){
				tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
				tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_UP,upHandler);
				tempRes.dragGroup.removeEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
				tempRes.dragGroup.removeEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
				tempRes.resScaleX=tempRes.scaleX;
				tempRes.resScaleY=tempRes.scaleY;
				ResTransform.removeTransRes();
				this._smallResView.addRes(tempRes);
			}else{
				if(tempRes.x>MainData._stageWidth){
					tempRes.x=MainData._stageWidth-30;
				}
				if(tempRes.y<0){
					tempRes.y=-tempRes.width+30;
				}
				if(tempRes.y>MainData._stageHeight-50){
					tempRes.y=MainData._stageHeight-80;
				}
			}
			
		}
		private function moveHandler(e:MouseEvent):void
		{
			
			if(!_mouseIsDown){
				return;
			}
			if(this.mouseX<150){
				this._smallResView.openBox();
			}else{
				this._smallResView.closeBox();
			}
		}
		private  function addListenerHandler(e:ResEvent):void
		{
			var res:IResShow=IResShow(e.target);
			res.removeEventListener(ResEvent.ADDRESLISTENER,addListenerHandler);
			res.dragGroup.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			res.dragGroup.addEventListener(MouseEvent.MOUSE_UP,upHandler);
			res.dragGroup.addEventListener(MouseEvent.RELEASE_OUTSIDE,upHandler);
			res.dragGroup.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
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
		public function get resAry():Array
		{
			return this._resAry;
		}
		public function get smallResView():SmallResView
		{
			return this._smallResView;
		}
		
	}
}