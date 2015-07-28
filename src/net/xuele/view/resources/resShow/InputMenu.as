package net.xuele.view.resources.resShow
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fl.controls.ColorPicker;
	import fl.events.ColorPickerEvent;
	
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.pages.utils.PagesData;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.DropDownList;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.VerticalAlign;
	
	public class InputMenu extends Group
	{
		/**
		 * 字号 
		 */
		private var _textSize:DropDownList;
		/**
		 * 粗体按钮 
		 */
		private var _boldBtn:UIMovieClip;
		/**
		 * 斜体按钮 
		 */
		private var _italicBtn:UIMovieClip;
		/**
		 * 下划线按钮 
		 */
		private var _underlineBtn:UIMovieClip;
		/**
		 * 文本颜色 
		 */
		private var _textColor:Group;
		/**
		 * 颜色变化区 
		 */
		private var _colorRect:Rect;
		private var _colorPick:ColorPicker;
		private var setupGroup:Group;
		/**
		 * 取消文本 
		 */
		private var _cancelBtn:McButton;
		private var _isBold:Boolean;
		private var _isItalic:Boolean;
		private var _isUnderLine:Boolean;
		private var _color:uint;
		private var _size:Number;
		public function InputMenu()
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
			_isBold=false;
			_isItalic=false;
			_isUnderLine=false;
			_size=36;
			_color=0x000000;
			
			
//			this.layout=layout;
			createUI();
			addListener();
		}
		private function createUI():void
		{
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("TextBg");
			this.addElement(bg);
			
			setupGroup=new Group;
			var layout:HorizontalLayout=new HorizontalLayout;
			layout.gap=10;
			layout.verticalAlign=VerticalAlign.MIDDLE;
			setupGroup.layout=layout;
			
			var sizeData:ArrayCollection=new ArrayCollection;
			sizeData.addItem("36");
			sizeData.addItem("48");
			sizeData.addItem("72");
			sizeData.addItem("96");
			sizeData.addItem("120");
			this._textSize=new DropDownList;
			setupGroup.addElement(this._textSize);
			this._textSize.prompt="36";
			this._textSize.width=60;
			this._textSize.dataProvider=sizeData;
			
			this._boldBtn=new UIMovieClip;
			this._boldBtn.skinName=PublicOperate.getUI("TextBold","movieclip");
			setupGroup.addElement(_boldBtn);
			_boldBtn.gotoAndStop(0);
			this._italicBtn=new UIMovieClip;
			this._italicBtn.skinName=PublicOperate.getUI("TextItalic","movieclip");
			setupGroup.addElement(_italicBtn);
			_italicBtn.gotoAndStop(0);
			this._underlineBtn=new UIMovieClip;
			this._underlineBtn.skinName=PublicOperate.getUI("TextUnderline","movieclip");
			setupGroup.addElement(_underlineBtn);
			_underlineBtn.gotoAndStop(0);
			var colorGroup:Group=new Group;
			this._textColor=new Group;
			var colorUI:UIAsset=new UIAsset;
			colorUI.skinName=PublicOperate.getUI("TextColor");
			this._textColor.addElement(colorUI);
			this._colorRect=new Rect;
			this._colorRect.width=20;
			this._colorRect.height=10;
			this._colorRect.fillColor=0x000000;
			this._colorRect.fillAlpha=1;
			this._colorPick=new ColorPicker;
			var cp:UIAsset=new UIAsset;
			cp.skinName=this._colorPick;
			colorGroup.addElement(cp);
			cp.mouseChildren=true;
			setupGroup.addElement(colorGroup);
			
			this._cancelBtn=new McButton;
			this._cancelBtn.skinName=PublicOperate.getUI("TextCancel","movieclip");
			setupGroup.addElement(this._cancelBtn);
			this._cancelBtn.verticalCenter=0;
			
			this.addElement(setupGroup);
			setupGroup.horizontalCenter=setupGroup.verticalCenter=0;
		}
		private function addListener():void
		{
			this._boldBtn.addEventListener(MouseEvent.CLICK,boldClickHandler);
			this._italicBtn.addEventListener(MouseEvent.CLICK,italicClickHandler);
			this._underlineBtn.addEventListener(MouseEvent.CLICK,underlineClickHandler);
			this._colorPick.addEventListener(ColorPickerEvent.CHANGE,colorChangeHandler);
			this._textSize.addEventListener(Event.CHANGE,sizeChangeHandler);
			this._cancelBtn.addEventListener(MouseEvent.CLICK,cancelHandler);
		}
		private function boldClickHandler(e:MouseEvent):void
		{
			this._isBold=!this._isBold;
			if(this._isBold){
				this._boldBtn.gotoAndStop(1);
			}else{
				this._boldBtn.gotoAndStop(0);
			}
			InputShow(PagesData._currentInput)._contentText.bold=this._isBold;
		}
		private function italicClickHandler(e:MouseEvent):void
		{
			this._isItalic=!this._isItalic;
			if(this._isItalic){
				this._italicBtn.gotoAndStop(1);
			}else{
				this._italicBtn.gotoAndStop(0);
			}
			InputShow(PagesData._currentInput)._contentText.italic=this._isItalic;
		}
		private function underlineClickHandler(e:MouseEvent):void
		{
			this._isUnderLine=!this._isUnderLine;
			if(this._isUnderLine){
				this._underlineBtn.gotoAndStop(1);
			}else{
				this._underlineBtn.gotoAndStop(0);
			}
			InputShow(PagesData._currentInput)._contentText.underline=this._isUnderLine;
		}
		private function colorChangeHandler(e:ColorPickerEvent):void
		{
			this._color=e.color;
			InputShow(PagesData._currentInput)._contentText.textColor=this._color;
		}
		private function sizeChangeHandler(e:Event):void
		{
			var dp:DropDownList=DropDownList(e.currentTarget);
			InputShow(PagesData._currentInput)._contentText.width=1000;
			InputShow(PagesData._currentInput)._contentText.size=dp.selectedItem;
			InputShow(PagesData._currentInput).updataShow();
		}
		private function cancelHandler(e:MouseEvent):void
		{
			
		}
		public function removeListener():void
		{
			this._boldBtn.removeEventListener(MouseEvent.CLICK,boldClickHandler);
			this._italicBtn.removeEventListener(MouseEvent.CLICK,italicClickHandler);
			this._underlineBtn.removeEventListener(MouseEvent.CLICK,underlineClickHandler);
			this._colorPick.removeEventListener(ColorPickerEvent.CHANGE,colorChangeHandler);
			this._textSize.removeEventListener(Event.CHANGE,sizeChangeHandler);
			this._cancelBtn.removeEventListener(MouseEvent.CLICK,cancelHandler);
		}
	}
}