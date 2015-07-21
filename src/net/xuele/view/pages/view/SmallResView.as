package net.xuele.view.pages.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.HitTest;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.interfaces.IResShow;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	
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
			this.height=stage.stageHeight;
			this._isOpen=false;
			createUI();
			closeBox();
			addListener();
		}
		private function createUI():void
		{
			var bg:Rect=new Rect;
			bg.fillAlpha=1;
			bg.fillColor=0xff0000;
			bg.percentWidth=bg.percentHeight=100;
			this.addElement(bg);
			
			_resGroup=new Group;
			_resGroup.percentWidth=_resGroup.percentHeight=100;
			this.addElement(_resGroup);
			
			this._openBtn=new UIMovieClip;
			this._openBtn.skinName=PublicOperate.getUI("OpenSmallBox","movieclip") as MovieClip;
			this._openBtn.gotoAndStop(0);
			this.addElement(this._openBtn);
			this._openBtn.right=0;
			this._openBtn.verticalCenter=0;
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
		}
		public function closeBox():void
		{
			this._isOpen=false;
			this._openBtn.gotoAndStop(0);
			this.left=-this.width+55;
		}
		private const _smallResWidth:Number=45;
		private const _smallResHeight:Number=45;
		private var _endX:Number;
		private var _endY:Number;
		private var _startX:Number;
		private var _startY:Number;
		public function addRes(res:IResShow):void
		{
			_resGroup.addElement(res);
			var scX:Number=_smallResWidth/res.width;
			var scY:Number=_smallResHeight/res.height;
			Group(res).scaleX=scX;
			Group(res).scaleY=scY;
			
			var isHave:Boolean=false;
			var len:int=this._resAry.length;
			for(var i:int=0;i<len;i++){
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
			_startX=res.x;
			_startY=res.y;
			res.addEventListener(MouseEvent.MOUSE_DOWN,resDownHandler);
			res.addEventListener(MouseEvent.MOUSE_UP,resUpHandler);
			res.addEventListener(MouseEvent.RELEASE_OUTSIDE,resUpHandler);
			res.addEventListener(MouseEvent.MOUSE_MOVE,resMoveHandler);
			
		}
		private function resDownHandler(e:MouseEvent):void
		{
			this._isDown=true;
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
			this._isDown=false;
			this._selectRes=null;
			var res:IResShow=IResShow(e.currentTarget);
			Group(res).stopDrag();
			if(res.x>=100){
				res.removeEventListener(MouseEvent.MOUSE_DOWN,resDownHandler);
				res.removeEventListener(MouseEvent.MOUSE_UP,resUpHandler);
				res.removeEventListener(MouseEvent.RELEASE_OUTSIDE,resUpHandler);
				if(res.hasEventListener(MouseEvent.MOUSE_MOVE)){
					res.removeEventListener(MouseEvent.MOUSE_MOVE,resMoveHandler);
				}
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
				IResShow(this._resAry[n].resShow).x=this._resAry[startChange].x;
				IResShow(this._resAry[n].resShow).y=this._resAry[startChange].y;
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
					IResShow(this._resAry[i].resShow).x=this._resAry[i].x;
					IResShow(this._resAry[i].resShow).y=this._resAry[i].y;
				}
			}else{
				trace("向下移动")
				for(i=n;i<startChange;i++){
					this._resAry[i].x=this._resAry[i+1].x;
					this._resAry[i].y=this._resAry[i+1].y;
					IResShow(this._resAry[i].resShow).x=this._resAry[i].x;
					IResShow(this._resAry[i].resShow).y=this._resAry[i].y;
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
		public function delRes(res:IResShow):void
		{
			var len:int=this._resAry.length;
			for(var i:int=0;i<len;i++){
				if(res.resID==IResShow(this._resAry[i].resShow).resID){
					this._resAry.splice(i,1);
					break;
				}
			}
		}
	}
}