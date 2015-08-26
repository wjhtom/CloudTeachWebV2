package net.xuele.view.homework.view
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextFormatAlign;
	
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.homework.interfaces.IClass;
	import net.xuele.vo.HomeworkClassVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.VerticalAlign;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
	/**
	 * 班级内容 
	 * 
	 */
	public class ClassContent extends Group implements IClass
	{
		private var _classVo:HomeworkClassVo;
		private var _classGroup:Group;
		private var _className:Label;
		public function ClassContent(cVo:HomeworkClassVo)
		{
			super();
			_classVo=cVo;
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			this.width=160;
			this.height=200;
			createUI();
			setClassName();
		}
		private function createUI():void
		{
			this._classGroup=new Group;
			this._classGroup.width=140;
			this._classGroup.height=180;
			var classLayout:VerticalLayout=new VerticalLayout;
			classLayout.gap=0;
			this._classGroup.layout=classLayout;
			this.addElement(this._classGroup);
			this._classGroup.horizontalCenter=this._classGroup.verticalCenter=0;
			var icon:UIAsset=new UIAsset;
			icon.skinName=PublicOperate.getUI("ClassDefaultIcon");
			this._classGroup.addElement(icon);
//			loadIcon();
		}
		private function loadIcon():void
		{
			var loader:Loader=new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,iconCom);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,PopUtils.IOError);
			loader.load(new URLRequest(this._classVo._classIcon));
		}
		private function iconCom(e:Event):void
		{
			var icon:UIAsset=new UIAsset;
			icon.skinName=loaderInfo(e.target).content;
			this._classGroup.addElement(icon);
			setClassName();
		}
		private function setClassName():void
		{
			this._className=new Label;
			this._className.textAlign=TextFormatAlign.CENTER;
			this._className.textColor=0x000000;
			this._className.width=140;
			this._className.height=40;
			this._className.verticalAlign=VerticalAlign.MIDDLE;
			this._className.text=this._classVo._className;
			this._classGroup.addElement(this._className);
		}
		public function get isSelected():Boolean
		{
			return null;
		}
		
		public function get classVo():HomeworkClassVo
		{
			return null;
		}
		public function selectClass():void
		{
			var scale:Number=160/140;
			this._classGroup.scaleX=this._classGroup.scaleY=scale;
		}
		public function unSelectClass():void
		{
			this._classGroup.scaleX=this._classGroup.scaleY=1;
		}
	}
}