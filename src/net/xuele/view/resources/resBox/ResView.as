package net.xuele.view.resources.resBox
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.interfaces.IResBox;
	import net.xuele.view.resources.utils.ResUtils;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.layouts.VerticalAlign;
	import org.flexlite.domUI.layouts.VerticalLayout;
	import org.flexlite.domUI.utils.callLater;
	
	/**
	 * 单个资源 
	 * @author jianhua
	 * 
	 */
	public class ResView extends Group implements IResBox
	{
		private var _resVo:ResourceVo;
		private var _resGroup:Group;
		private var _resInfoGroup:Group;
		private var _isSelected:Boolean;
		private var _selectUI:UIAsset;
		private var _resUI:UIAsset;
		private var _uiLoader:Loader;
		public function ResView(resVo:ResourceVo)
		{
			super();
			_resVo=resVo;
		}
		private var timer:Timer;
		public function createUI():void
		{
			this._isSelected=false;
			timer=new Timer(10,1);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void
		{
			timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			create();
		}
		private function create():void
		{
			var layout:VerticalLayout=new VerticalLayout;
			layout.gap=2;
			this._resInfoGroup=new Group;
			this._resInfoGroup.layout=layout;
			createRes();
			
		}
		private function createRes():void
		{
			
			
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("IconBg");
			this.addElement(bg);
			
			this._resGroup=new Group;
			this._resGroup.width=100;
			this._resGroup.height=100;
			if(_resVo._from==1){
				_resUI=ResUtils.getResIcon(_resVo._ex,true);
				getSmallImg();
			}else{
				_uiLoader=new Loader;
				_uiLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,getSmallImg);
				_uiLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioError);
//				_uiLoader.load(new URLRequest("http://ico.ooopic.com/iconset01/GnomeDesktop-icons/gif/110048.gif"));
				_uiLoader.load(new URLRequest(_resVo._smallImgURL));
			}
			
			
		}
		private function ioError(e:IOErrorEvent):void
		{
			_uiLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,getSmallImg);
			_uiLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,ioError);
			trace(LoaderInfo(e.currentTarget).loader==_uiLoader,LoaderInfo(e.currentTarget).loader)
			PopUtils.IOError(e);
		}
		private function getSmallImg(e:Event=null):void
		{
			if(_resVo._from==2){
				_resUI=new UIAsset;
				_resUI.skinName=_uiLoader.content;
			}
			this._resGroup.addElement(_resUI);
			_resUI.horizontalCenter=0;
			_resUI.verticalCenter=0;
			this._resInfoGroup.addElement(this._resGroup);
			
			createName();
			addListener();
		}
		private function createName():void
		{
			var nameLabel:Label=new Label;
			nameLabel.text=this._resVo._name;
			nameLabel.size=12;
			nameLabel.fontFamily="宋体";
			nameLabel.textColor=0x000000;
			nameLabel.width=100;
			nameLabel.height=38;
			nameLabel.verticalAlign=VerticalAlign.MIDDLE;
			nameLabel.textAlign=TextFormatAlign.CENTER;
			this._resInfoGroup.addElement(nameLabel);
			this.addElement(this._resInfoGroup);
		}
		
		private function addListener():void
		{
//			this.addEventListener(MouseEvent.ROLL_OVER,overHandler);
//			this.addEventListener(MouseEvent.ROLL_OUT,outHandler);
//			this.addEventListener(MouseEvent.RELEASE_OUTSIDE,outHandler);
		}
		private function overHandler(e:MouseEvent):void
		{
			if(this._isSelected){
				return;
			}
			this.selected();
//			this._bgUI.gotoAndStop(1);
		}
		private function outHandler(e:MouseEvent):void
		{
			if(this._isSelected){
				return;
			}
			this.unSelect();
//			this._bgUI.gotoAndStop(0);
		}
		/**
		 * 选择当前资源 
		 * 
		 */
		public function selected():void
		{
			this._selectUI=new UIAsset;
			this._selectUI.skinName=PublicOperate.getUI("SelectedTag") as Sprite;
			this._isSelected=true;
			callLater(createSelectUI,null,3);
		}
		private function createSelectUI():void
		{
			this._resGroup.addElement(this._selectUI);
			this._selectUI.right=0;
		}
		/**
		 * 取消当前选择 
		 * 
		 */
		public function unSelect():void
		{
			if(this._selectUI){
				this._resGroup.removeElement(this._selectUI);
			}
			this._selectUI=null;
			this._isSelected=false;
		}
		public function removeListener():void
		{
			this.removeEventListener(MouseEvent.ROLL_OVER,overHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT,outHandler);
			this.removeEventListener(MouseEvent.RELEASE_OUTSIDE,outHandler);
		}
		public function get resVo():ResourceVo
		{
			if(this._resVo==null){
				PublicOperate.setAlert("警告","资源未找到");
				return null;
			}
			return this._resVo;
		}
		public function get isSelect():Boolean
		{
			return _isSelected;
		}
//		public function closeMouseEvent():void
//		{
//			removeListener();
//		}
	}
}