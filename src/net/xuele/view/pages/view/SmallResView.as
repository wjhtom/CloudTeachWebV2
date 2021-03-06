package net.xuele.view.pages.view
{
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.Timer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.HitTest;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.menu.utils.MenuData;
	import net.xuele.view.pages.utils.PagesData;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.EditResBase;
	import net.xuele.view.resources.resShow.FlashShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.view.resources.resShow.VideoShow;
	import net.xuele.view.resources.utils.ResTransform;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.utils.callLater;
	
	/**
	 * 黑板左侧缩小的资源 
	 * @author jianhua
	 * 
	 */
	public class SmallResView extends Group
	{
		/**
		 *  打开关闭按钮
		 */
		private var _openBtn:UIMovieClip;
		/**
		 * 是否打开 
		 */
		private var _isOpen:Boolean;
		/**
		 * 资源存放 
		 */
		private var _resGroup:Group;
		/**
		 * 资源列表（保存资源与坐标） [{resShow:IResShow,x:int,y:int},{resShow:IResShow,x:int,y:int}]
		 */
		private var _resAry:Array=[];
		/**
		 * 鼠标是否按下 
		 */
		private var _isDown:Boolean=false;
		/**
		 * 鼠标选中的资源 
		 */
		private var _selectRes:IResShow=null;
		private var _bg:Rect;
		/**
		 * 删除按钮 
		 */
		private var _delBtn:McButton;
		public function SmallResView()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			this.width=100;
			this.height=MainData._stageHeight//stage.stageHeight;
			this._isOpen=false;
			createUI();
//			closeBox();
			openBox();
			addListener();
		}
		private function createUI():void
		{
			_bg=new Rect;
			_bg.fillAlpha=0.2;
			_bg.fillColor=0x80B9B5;
			_bg.percentWidth=_bg.percentHeight=100;
			this.addElement(_bg);
			var filter:DropShadowFilter=new DropShadowFilter;
			filter.blurX=filter.blurY=5;
			filter.color=0xa3a3a3;
			filter.distance=5;
			filter.quality=BitmapFilterQuality.LOW;
			filter.alpha=0.5;
			_bg.filters=[filter];
			
			_resGroup=new Group;
			_resGroup.percentWidth=_resGroup.percentHeight=100;
			this.addElement(_resGroup);
			_resGroup.name="resGroup";
			
			this._openBtn=new UIMovieClip;
			this._openBtn.skinName=PublicOperate.getUI("OpenSmallBox","movieclip") as MovieClip;
			this._openBtn.gotoAndStop(0);
			this._openBtn.right=0;
			this._openBtn.verticalCenter=0;
			this.addElement(this._openBtn);
			this._openBtn.visible=false
			callLater(setUI);
			
		}
		private function setUI():void
		{
			this._openBtn.visible=true;
		}
		private function addListener():void
		{
			this._openBtn.addEventListener(MouseEvent.CLICK,openHandler);
		}
		private function openHandler(e:MouseEvent):void
		{
			if(this._isOpen){
				closeBox();
			}else{
				openBox();
			}
		}
		public function openBox():void
		{
			this._isOpen=true;
			this._openBtn.gotoAndStop(1);
			this.left=45;
			_resGroup.visible=1;
			_bg.fillAlpha=0.2;
		}
		public function closeBox():void
		{
			this._isOpen=false;
			this._openBtn.gotoAndStop(0);
			this.left=-this.width+60;
			_resGroup.visible=0;
			_bg.fillAlpha=0;
		}
		private const _smallResWidth:Number=60;
		private const _smallResHeight:Number=45;
		private var _endX:Number;
		private var _endY:Number;
		private var _startX:Number;
		private var _startY:Number;
		public function addRes(res:IResShow):void
		{
			
			_resGroup.addElement(res);
			res.isOpen=false;
			
			var scX:Number=_smallResWidth/res.width;
			if(res is VideoShow){
				var scY:Number=40/res.height;
			}else{
				scY=_smallResHeight/res.height;
			}
			Group(res).scaleX=scX;
			Group(res).scaleY=scY;
			
			var isHave:Boolean=false;
			var len:int=this._resAry.length;
			for(var i:int=0;i<len;i++){
				if(!this._resAry[i]){
					continue;
				}
				if(res.resID==IResShow(this._resAry[i].resShow).resID){
					res.x=this._resAry[i].x;
					res.y=this._resAry[i].y;
					isHave=true;
					break;
				}
			}
			
			if(!isHave){
				var rect:Rectangle=Group(res).getRect(this.stage);
				res.x=(this.width-rect.width)/2;
				res.y=10+(rect.height+10)*len;
				this._resAry.push({resShow:res,x:res.x,y:res.y})
			}
			if(res is ImageShow || res is DocShow){
				if(EditResBase(res).resRotation==90){
					scX=_smallResHeight/res.width;
					if(res is VideoShow){
						scY=60/res.height;
					}else{
						scY=_smallResWidth/res.height;
					}
					Group(res).scaleX=scX;
					Group(res).scaleY=scY;
					res.x+=_smallResWidth;
				}else if(EditResBase(res).resRotation==180){
					res.x+=_smallResWidth;
					res.y+=_smallResHeight;
				}else if(EditResBase(res).resRotation==-90){
					scX=_smallResHeight/res.width;
					if(res is VideoShow){
						scY=60/res.height;
					}else{
						scY=_smallResWidth/res.height;
					}
					Group(res).scaleX=scX;
					Group(res).scaleY=scY;
					res.y+=_smallResWidth;
				}
			}
			_startX=res.x;
			_startY=res.y;
			res.addEventListener(MouseEvent.MOUSE_DOWN,resDownHandler);
			res.addEventListener(MouseEvent.MOUSE_UP,resUpHandler);
			res.addEventListener(MouseEvent.RELEASE_OUTSIDE,resUpHandler);
			res.addEventListener(MouseEvent.MOUSE_MOVE,resMoveHandler);
			if(MainData._teachType==1||MainData._teachType==4){
				res.addEventListener(MouseEvent.ROLL_OVER,resOverHandler);
				res.addEventListener(MouseEvent.ROLL_OUT,resOutHandler);
			}
			
		}
		private function resDownHandler(e:MouseEvent):void
		{
			this._isDown=true;
			removeDelBtn();
			var res:IResShow=IResShow(e.currentTarget);
			this._selectRes=res;
			_startX=res.x;
			_startY=res.y;
			Group(res).startDrag(false,new Rectangle((this.width-this._smallResWidth)/2,10,900,560));
		}
		private function resUpHandler(e:MouseEvent):void
		{
			if(this._isDown==false){
				return;
			}
			var res:IResShow=IResShow(e.currentTarget);
			if(res is FlashShow){
				res.x=_startX;
				res.y=_startY;
				this._isDown=false;
				this._selectRes=null;
				Group(res).stopDrag();
				FlashShow(res).callJS();
				if(stage.displayState==StageDisplayState.FULL_SCREEN){
					stage.displayState=StageDisplayState.NORMAL;
					MenuData._fullScreenUI.gotoAndStop(0);
				}
				return;
			}
			this._isDown=false;
			this._selectRes=null;
			Group(res).stopDrag();
			if(res.x>=100){
				res.removeEventListener(MouseEvent.MOUSE_DOWN,resDownHandler);
				res.removeEventListener(MouseEvent.MOUSE_UP,resUpHandler);
				res.removeEventListener(MouseEvent.RELEASE_OUTSIDE,resUpHandler);
				if(res.hasEventListener(MouseEvent.MOUSE_MOVE)){
					res.removeEventListener(MouseEvent.MOUSE_MOVE,resMoveHandler);
				}
				if(MainData._teachType==1||MainData._teachType==4){
					res.removeEventListener(MouseEvent.ROLL_OVER,resOverHandler);
					res.removeEventListener(MouseEvent.ROLL_OUT,resOutHandler);
				}
				removeDelBtn();
				CommondView.contentView.getResFormSmallView(res);
			}else{
				res.x=_startX;
				res.y=_startY;
			}
		}
		private function resMoveHandler(e:MouseEvent):void
		{
			if(!_isDown){
				return;
			}
			if(_selectRes.x>=100){
				return;
			}
			if(_selectRes.y>this._resAry[this._resAry.length-1].y){
				changeRes(this._resAry.length-1,true)
				return;
			}
			var len:int=this._resAry.length;
			for(var i:int=0;i<len;i++){
				if(_selectRes.resID==IResShow(this._resAry[i].resShow).resID){
					continue;
				}
				var isHit:Boolean=HitTest.complexHitTestObject(Group(this._resAry[i].resShow),Group(_selectRes));
//				trace(_selectRes.y>_startY,_selectRes.y+this._smallResHeight>this._resAry[i].y+this._smallResHeight/2)
				if(isHit&&_selectRes.y>_startY&&_selectRes.y+this._smallResHeight>this._resAry[i].y+this._smallResHeight/2){
					changeRes(i,true);
					break;
				}
				if(isHit&&_selectRes.y<_startY&&_selectRes.y<(this._resAry[i].y+this._smallResHeight/2)){
					changeRes(i,false);
					break;
				}
			}
		}
		/**
		 * 转变 
		 * @param n 选择资源的只存位置
		 * @param isUp (true:向上移，false：向下移)
		 * 
		 */
		private function changeRes(n:int,isUp:Boolean):void
		{
			var startChange:int=0;
			var len:int=this._resAry.length;
			for(var i:int=0;i<len;i++){
				if(IResShow(this._resAry[i].resShow).resID==_selectRes.resID){
					startChange=i;
					break;
				}
			}
			if(n==startChange){
				return;
			}
			if(Math.abs(n-startChange)==1){
				//只移一位
				if(IResShow(this._resAry[n].resShow).parent.name=="resGroup"){
					IResShow(this._resAry[n].resShow).x=this._resAry[startChange].x;
					IResShow(this._resAry[n].resShow).y=this._resAry[startChange].y;
				}
				_startX=this._resAry[n].x;
				_startY=this._resAry[n].y;
				var tempX:Number=this._resAry[startChange].x;
				var tempY:Number=this._resAry[startChange].y;
				this._resAry[startChange].x=this._resAry[n].x;
				this._resAry[startChange].y=this._resAry[n].y;
				this._resAry[n].x=tempX;
				this._resAry[n].y=tempY;
				var temp1:Object=this._resAry[startChange];
				var temp2:Object=this._resAry[n];
				this._resAry[startChange]=temp2;
				this._resAry[n]=temp1;
				return;
			}
			//移一堆
			trace(n,startChange)
			_startX=this._resAry[n].x;
			_startY=this._resAry[n].y;
			if(isUp){
				trace("向上移动")
				for(i=n;i>startChange;i--){
					this._resAry[i].x=this._resAry[i-1].x;
					this._resAry[i].y=this._resAry[i-1].y;
					if(IResShow(this._resAry[i].resShow).parent.name=="resGroup"){
						IResShow(this._resAry[i].resShow).x=this._resAry[i].x;
						IResShow(this._resAry[i].resShow).y=this._resAry[i].y;
					}
				}
			}else{
				trace("向下移动")
				for(i=n;i<startChange;i++){
					this._resAry[i].x=this._resAry[i+1].x;
					this._resAry[i].y=this._resAry[i+1].y;
					if(IResShow(this._resAry[i].resShow).parent.name=="resGroup"){
						IResShow(this._resAry[i].resShow).x=this._resAry[i].x;
						IResShow(this._resAry[i].resShow).y=this._resAry[i].y;
					}
				}
			}
			
//			this._resAry[startChange].x=this._resAry[n].x
//			this._resAry[startChange].y=this._resAry[n].y;
			this._resAry.splice(startChange,1);
			this._resAry.splice(n,0,{resShow:_selectRes,x:_startX,y:_startY});
			for(i=0;i<this._resAry.length;i++){
				trace(this._resAry[i].y)
			}
		}
		
		private var delTimer:Timer;
		private function resOverHandler(e:MouseEvent):void
		{
			this._selectRes=IResShow(e.currentTarget);
			if(!this._delBtn){
				this._delBtn=new McButton;
				this._delBtn.skinName=PublicOperate.getUI("SmallResDel","movieclip");
				this._resGroup.addElementAt(_delBtn,this._resGroup.numElements);
			}else{
				if(this._resGroup.getChildIndex(_delBtn)<this._resGroup.getChildIndex(Group(_selectRes))){
					this._resGroup.swapElements(_delBtn,_selectRes);
				}
			}
			if(delTimer&&delTimer.hasEventListener(TimerEvent.TIMER)){
				delTimer.removeEventListener(TimerEvent.TIMER,removeDelBtn);
				delTimer.stop();
				delTimer=null;
			}
			var rect:Rectangle=Group(this._selectRes).getRect(this._resGroup);
			_delBtn.x=rect.x+rect.width-15;
			_delBtn.y=rect.y;
			_delBtn.addEventListener(MouseEvent.CLICK,delResClick);
		}
		
		private function resOutHandler(e:MouseEvent):void
		{
			delTimer=new Timer(1000,0);
			delTimer.addEventListener(TimerEvent.TIMER,removeDelBtnHandler);
			delTimer.start();
		}
		
		private function removeDelBtnHandler(e:TimerEvent):void
		{
//			Timer(e.target).removeEventListener(TimerEvent.TIMER,removeDelBtnHandler);
			removeDelBtn();
			
		}
		private function removeDelBtn():void
		{
			if(delTimer&&delTimer.hasEventListener(TimerEvent.TIMER)){
				delTimer.removeEventListener(TimerEvent.TIMER,removeDelBtnHandler);
				delTimer.stop();
				delTimer=null;
			}
			if(_delBtn){
				_delBtn.removeEventListener(MouseEvent.CLICK,delResClick);
				this._resGroup.removeElement(_delBtn);
				this._delBtn=null;
				this._selectRes=null;
			}
		}
		private function delResClick(e:MouseEvent):void
		{
//			_delBtn.removeEventListener(MouseEvent.CLICK,delResClick);
//			if(delTimer&&delTimer.hasEventListener(TimerEvent.TIMER)){
//				delTimer.removeEventListener(TimerEvent.TIMER,removeDelBtn);
//				delTimer.stop();
//				delTimer=null;
//			}
			this._selectRes.removeEventListener(MouseEvent.MOUSE_DOWN,resDownHandler);
			this._selectRes.removeEventListener(MouseEvent.MOUSE_UP,resUpHandler);
			this._selectRes.removeEventListener(MouseEvent.RELEASE_OUTSIDE,resUpHandler);
			if(this._selectRes.hasEventListener(MouseEvent.MOUSE_MOVE)){
				this._selectRes.removeEventListener(MouseEvent.MOUSE_MOVE,resMoveHandler);
			}
			if(MainData._teachType==1||MainData._teachType==4){
				this._selectRes.removeEventListener(MouseEvent.ROLL_OVER,resOverHandler);
				this._selectRes.removeEventListener(MouseEvent.ROLL_OUT,resOutHandler);
			}
			this._resGroup.removeElement(this._selectRes);
			delRes(this._selectRes);
			var at:int=PagesData._currentPage.resAry.indexOf(_selectRes);
			PagesData._currentPage.resAry.splice(at,1);
			removeDelBtn();
		}
		public function delRes(res:IResShow):void
		{
			var len:int=this._resAry.length;
			for(var i:int=0;i<len;i++){
				if(res.resID==IResShow(this._resAry[i].resShow).resID){
					for(var j:int=len-1;j>i;j--){
						this._resAry[j].x=this._resAry[j-1].x;
						this._resAry[j].y=this._resAry[j-1].y;
						IResShow(this._resAry[j].resShow).x=this._resAry[j].x;
						IResShow(this._resAry[j].resShow).y=this._resAry[j].y;
					}
					
					
					this._resAry.splice(i,1);
					break;
				}
			}
			
		}
		/**
		 * 资源列表（保存资源与坐标） [{resShow:IResShow,x:int,y:int},{resShow:IResShow,x:int,y:int}]
		 */
		public function get resAry():Array
		{
			return this._resAry;
		}
	}
}