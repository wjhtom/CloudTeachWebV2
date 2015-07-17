package net.xuele.view.pages.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
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
		 * 打开 
		 */
		private var _resGroup:Group;
		/**
		 * 资源列表（保存资源与坐标） [{resShow:IResShow,x:int,y:int},{resShow:IResShow,x:int,y:int}]
		 */
		private var _resAry:Array;
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
			addListener();
		}
		private function createUI():void
		{
			var bg:Rect=new Rect;
			bg.fillAlpha=1;
			bg.fillColor=0xff0000;
			bg.percentWidth=bg.percentHeight=100;
			
			this._openBtn=new UIMovieClip;
			this._openBtn.skinName=PublicOperate.getUI("","movieclip") as MovieClip;
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
			this.left=0;
		}
		public function closeBox():void
		{
			this._isOpen=false;
			this._openBtn.gotoAndStop(0);
			this.left=-this.width;
		}
		public function addRes(res:IResShow):void
		{
			this.addElement(res);
			res.width=60;
			res.height=60;
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
				res.x=(this.width-res.width)/2;
				res.y=(this.height+10)*len;
				this._resAry.push({resShow:res,x:res.x,y:res.y})
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