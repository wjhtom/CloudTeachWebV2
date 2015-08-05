package net.xuele.view.resources.resBox
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.control.ResControl;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResBox;
	import net.xuele.view.resources.resImport.ResImportView;
	import net.xuele.view.resources.utils.ResData;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.TileLayout;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
	/**
	 * 用户资源盒 
	 * @author jianhua
	 * 
	 */
	public class ResBoxView extends Group
	{
		public function ResBoxView()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		
		/**
		 * 资源显示 
		 */
		private var _resGroup:Group;
		/**
		 * 标签显示 
		 */
		private var _tagsGroup:Group;
		private var _resLayout:TileLayout;
		private var _factory:ResFactory;
		private var _resView:IResBox;
		
		private var _systemTag:UIMovieClip;
		private var _userTag:UIMovieClip;
		private function init():void
		{
			this._factory=new ResFactory;
			createGroup();
			createTags();
			createUI();
			addListener();
			ResControl.control.addEventListener(ResEvent.UPDATAUSERRESOURCES,updataResources);
		}
		private function createGroup():void
		{
//			var verLayout:VerticalLayout=new VerticalLayout;
//			verLayout.gap=0;
//			this.layout=verLayout;
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("ResBoxBg");
			this.addElement(bg);
			
			this._tagsGroup=new Group;
			var tagLayout:HorizontalLayout=new HorizontalLayout;
			tagLayout.gap=0;
			this._tagsGroup.layout=tagLayout;
			this.addElement(this._tagsGroup);
			
			this._resLayout=new TileLayout;
			this._resLayout.horizontalGap=10;
			this._resLayout.verticalGap=5;
			this._resLayout.requestedColumnCount=8;
			this._resGroup=new Group;
			this._resGroup.layout=this._resLayout;
			
			
			var scl:Scroller=new Scroller;
			scl.width=890;
			scl.height=288;
			scl.viewport=this._resGroup;
			
			var content:Group=new Group;
//			content.addElement(bg);
			content.addElement(scl);
			scl.top=50;
			scl.left=15;
			this.addElement(content);
		}
		private function createTags():void
		{
			
			this._systemTag=new UIMovieClip;
			this._systemTag.name="systemTag";
			this._systemTag.skinName=PublicOperate.getUI("SystemTag","movieclip") as MovieClip;
			this._userTag=new UIMovieClip;
			this._userTag.name="userTag";
			this._userTag.skinName=PublicOperate.getUI("UserTag","movieclip") as MovieClip;
			this._tagsGroup.addElement(this._systemTag);
			this._tagsGroup.addElement(this._userTag);
			
			
			
			if(ResData._currentResBox==0){
				this._systemTag.gotoAndStop(1);
				this._userTag.gotoAndStop(0);
			}else if(ResData._currentResBox==1){
				this._userTag.gotoAndStop(1);
				this._systemTag.gotoAndStop(0);
			}
		}
		private function tagClickHandler(e:MouseEvent):void
		{
			if(ResData._currentResBox==0&&this._systemTag.currentFrame==1&&UIMovieClip(e.currentTarget).name=="systemTag" || ResData._currentResBox==1&&this._userTag.currentFrame==1&&UIMovieClip(e.currentTarget).name=="userTag"){
				return;
			}
			this.clearGroup();
			if(ResData._currentResBox==0){
				this._systemTag.gotoAndStop(0);
				this._userTag.gotoAndStop(1);
				ResData._currentResBox=1;
			}else if(ResData._currentResBox==1){
				this._userTag.gotoAndStop(0);
				this._systemTag.gotoAndStop(1);
				ResData._currentResBox=0;
			}
			createUI();
		}
		private function createUI():void
		{
			switch(ResData._currentResBox){
				case 0:
					if(MainData.systemResourcesAry.length>0){
						systemRes();
					}
					break;
				case 1:
//					if(MainData.myResourcesAry.length>0){
						userRes();
//					}
					break;
				default:
					break;
			}
			
		}
		private function systemRes():void
		{
			var len:int=MainData.systemResourcesAry.length;
			for(var i:int=0;i<len;i++){
				this._resView=this._factory.createResBox(MainData.systemResourcesAry[i]);
				this._resView.createUI();
				this._resGroup.addElement(this._resView);
				this._resView.addEventListener(MouseEvent.MOUSE_DOWN,resDownHandler);
			}
		}
		private function userRes():void
		{
			var len:int=MainData.myResourcesAry.length;
			if(MainData._teachType==1){
				var addRes:McButton=new McButton;
				addRes.skinName=PublicOperate.getUI("AddRes","movieclip");
				this._resGroup.addElement(addRes);
				addRes.addEventListener(MouseEvent.CLICK,addResHandler);
			}
			for(var i:int=0;i<len;i++){
				this._resView=this._factory.createResBox(MainData.myResourcesAry[i]);
				this._resView.createUI();
				this._resGroup.addElement(this._resView);
				this._resView.addEventListener(MouseEvent.MOUSE_DOWN,resDownHandler);
				
			}
		}
		private function updataResources(e:ResEvent):void
		{
			if(ResData._currentResBox==0){
				return;
			}
			clearGroup();
			createUI();
		}
		private function addResHandler(e:MouseEvent):void
		{
			var importView:ResImportView=new ResImportView;
			CommondView.popView.addElement(importView);
			importView.horizontalCenter=importView.verticalCenter=0;
		}
		private function resDownHandler(e:MouseEvent):void
		{
			var dragIco:IResBox=this._factory.createDragRes(IResBox(e.currentTarget).resVo);
			CommondView.popView.addElement(dragIco);
		}
		private function clearGroup():void
		{
			while(this._resGroup.numElements>0){
				trace(this._resGroup.getElementAt(this._resGroup.numElements-1) is McButton)
				if(this._resGroup.getElementAt(this._resGroup.numElements-1) is McButton){
					McButton(this._resGroup.getElementAt(this._resGroup.numElements-1)).removeEventListener(MouseEvent.CLICK,addResHandler);
				}else{
					IResBox(this._resGroup.getElementAt(this._resGroup.numElements-1)).removeEventListener(MouseEvent.MIDDLE_MOUSE_DOWN,resDownHandler);
					IResBox(this._resGroup.getElementAt(this._resGroup.numElements-1)).removeListener();
				}
				this._resGroup.removeElementAt(this._resGroup.numElements-1);
			}
		}
		private function addListener():void
		{
			this._systemTag.addEventListener(MouseEvent.CLICK,tagClickHandler);
			this._userTag.addEventListener(MouseEvent.CLICK,tagClickHandler);
		}
		public function removeListener():void
		{
			this._systemTag.removeEventListener(MouseEvent.CLICK,tagClickHandler);
			this._userTag.removeEventListener(MouseEvent.CLICK,tagClickHandler);
			clearGroup();
		}
	}
}