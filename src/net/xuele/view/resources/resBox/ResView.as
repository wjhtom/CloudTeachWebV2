package net.xuele.view.resources.resBox
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.interfaces.IResBox;
	import net.xuele.view.resources.utils.ResUtils;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.layouts.VerticalAlign;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
	/**
	 * 单个资源 
	 * @author jianhua
	 * 
	 */
	public class ResView extends Group implements IResBox
	{
		private var _resVo:ResourceVo;
		private var _resGroup:Group;
		public function ResView(resVo:ResourceVo)
		{
			super();
			_resVo=resVo;
		}
		private var timer:Timer;
		public function createUI():void
		{
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
			this.layout=layout;
			createRes();
			createName();
			addListener();
		}
		private var _bgUI:UIMovieClip;
		private function createRes():void
		{
			var bg:MovieClip=PublicOperate.getUI("","movieclip") as MovieClip;
			_bgUI=new UIMovieClip;
			_bgUI.skinName=bg;
			_bgUI.gotoAndStop(0);
			this.addElement(_bgUI);
			
			this._resGroup.width=100;
			this._resGroup.height=100;
			var resUI:UIAsset=ResUtils.getResIcon(_resVo._ex,true);
			this._resGroup.addElement(resUI);
			this._resGroup.horizontalCenter=0;
			this._resGroup.verticalCenter=0;
			this.addElement(this._resGroup);
		}
		
		private function createName():void
		{
			var nameLabel:Label=new Label;
			nameLabel.size=12;
			nameLabel.fontFamily="宋体";
			nameLabel.textColor=0x000000;
			nameLabel.width=100;
			nameLabel.verticalAlign=VerticalAlign.MIDDLE;
			this.addElement(nameLabel);
		}
		
		private function addListener():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			this.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			this.addEventListener(MouseEvent.CLICK,clickHandler);
			this.addEventListener(MouseEvent.RELEASE_OUTSIDE,outHandler);
		}
		private function overHandler(e:MouseEvent):void
		{
			this._bgUI.gotoAndStop(1);
		}
		private function outHandler(e:MouseEvent):void
		{
			this._bgUI.gotoAndStop(0);
		}
		private function clickHandler(e:MouseEvent):void
		{
			this._bgUI.gotoAndStop(1);
		}
		public function removeListener():void
		{
			this.removeEventListener(MouseEvent.ROLL_OVER,overHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT,outHandler);
			this.removeEventListener(MouseEvent.CLICK,clickHandler);
			this.removeEventListener(MouseEvent.RELEASE_OUTSIDE,outHandler);
		}
	}
}