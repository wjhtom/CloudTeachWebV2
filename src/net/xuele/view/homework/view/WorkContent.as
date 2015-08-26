package net.xuele.view.homework.view
{
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.homework.controller.HomeworkController;
	import net.xuele.view.homework.events.HomeworkEvent;
	import net.xuele.view.homework.interfaces.IWork;
	import net.xuele.view.homework.utils.HomeworkData;
	import net.xuele.view.homework.utils.HomeworkUtils;
	import net.xuele.vo.HomeworkListVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.VerticalAlign;
	
	public class WorkContent extends Group implements IWork
	{
		private var _homeworkVo:HomeworkListVo;
		/**
		 * 描述 
		 */
		private var _conetentLabel:Label;
		/**
		 * 创建时间 
		 */
		private var _createTime:Label;
		/**
		 * 背景 
		 */
		private var _bg:Rect;
		/**
		 * 导出作业 
		 */
		private var _exportBtn:McButton;
		/**
		 * 查看作业 
		 */
		private var _lookWorkBtn:McButton;
		/**
		 * 作业内容 
		 * 
		 */
		public function WorkContent(wVo:HomeworkListVo)
		{
			super();
			this._homeworkVo=wVo;
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			this.width=775;
			this.height=50;
			createUI();
			addListener();
		}
		private function createUI():void
		{
			this._bg=new Rect;
			this._bg.fillAlpha=1;
			this._bg.fillColor=0xf6f6f6;
			this._bg.percentWidth=this._bg.percentHeight=100;
			this.addElement(this._bg);
			
			var contentGroup:Group=new Group;
			var contentLayout:HorizontalLayout=new HorizontalLayout;
			contentLayout.gap=10;
			contentLayout.verticalAlign=VerticalAlign.MIDDLE;
			contentGroup.layout=contentLayout;
			
			if(this._homeworkVo._attachmentsAry.length>0){
				var attachmentIcon:UIAsset=new UIAsset;
				attachmentIcon.skinName=PublicOperate.getUI("attachmentIcon");
				contentGroup.addElement(attachmentIcon);
			}else{
				contentGroup.addElement(createRect());
			}
			
			this._conetentLabel=new Label;
			this._conetentLabel.text=this._homeworkVo._content;
			this._conetentLabel.width=430;
			this._conetentLabel.height=20;
			this._conetentLabel.size=12;
			this._conetentLabel.textColor=0x000000;
			this._conetentLabel.textAlign=TextFormatAlign.LEFT;
			contentGroup.addElement(this._conetentLabel);
			
			this._createTime=new Label;
			this._createTime.text=this._homeworkVo._assignTime;
			this._createTime.width=100;
			this._createTime.height=20;
			this._createTime.size=12;
			this._createTime.textColor=0x000000;
			this._createTime.textAlign=TextFormatAlign.CENTER;
			contentGroup.addElement(this._createTime);
			
			this._exportBtn=new McButton;
			this._exportBtn.skinName=PublicOperate.getUI("ExportBtn","movieclip");
//			contentGroup.addElement(this._exportBtn);
			
			this._lookWorkBtn=new McButton;
			this._lookWorkBtn.skinName=PublicOperate.getUI("LookWorkBtn","movieclip");
			contentGroup.addElement(this._lookWorkBtn);
			
			this.addElement(contentGroup);
			contentGroup.verticalCenter=0;
			
		}
		private function addListener():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER,rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT,rollOutHandler);
			this._exportBtn.addEventListener(MouseEvent.CLICK,exportHandler);
			this._lookWorkBtn.addEventListener(MouseEvent.CLICK,lookWorkHandler);
		}
		private function createRect():Rect
		{
			var rect:Rect=new Rect;
			rect.fillAlpha=0;
			rect.width=35;
			rect.height=20;
			return rect;
		}
		public function removeListener():void
		{
			this.removeEventListener(MouseEvent.ROLL_OVER,rollOverHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT,rollOutHandler);
			this._exportBtn.removeEventListener(MouseEvent.CLICK,exportHandler);
			this._lookWorkBtn.removeEventListener(MouseEvent.CLICK,lookWorkHandler);
		}
		private function exportHandler():void
		{
			
		}
		private function lookWorkHandler(e:MouseEvent):void
		{
			HomeworkData.currentWorkVo=this._homeworkVo;
			HomeworkUtils.closeHomeworkList();
			HomeworkUtils.openClassList();
		}
		private function rollOverHandler(e:MouseEvent):void
		{
			this._bg.fillColor=0xe3e3e3;
		}
		private function rollOutHandler(e:MouseEvent):void
		{
			this._bg.fillColor=0xf6f6f6;
		}
		public function get workVo():HomeworkListVo
		{
			return this._homeworkVo;
		}
	}
}