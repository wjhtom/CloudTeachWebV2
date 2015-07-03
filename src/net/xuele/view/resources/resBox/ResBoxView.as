package net.xuele.view.resources.resBox
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResBox;
	import net.xuele.view.resources.utils.ResData;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.TileLayout;
	
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
			this._resLayout=new TileLayout;
			this._resLayout.horizontalGap=10;
			this._resLayout.verticalGap=5;
			this._factory=new ResFactory;
			createUI();
		}
		private function createTags():void
		{
			this._tagsGroup=new Group;
			var tagLayout:HorizontalLayout=new HorizontalLayout;
			tagLayout.gap=0;
			this._tagsGroup.layout=tagLayout;
			this._systemTag=new UIMovieClip;
			this._systemTag.skinName=PublicOperate.getUI("","movieclip") as MovieClip;
			this._userTag=new UIMovieClip;
			this._userTag.skinName=PublicOperate.getUI("","movieclip") as MovieClip;
			this._tagsGroup.addElement(this._systemTag);
			
			
			if(ResData._currentResBox==0){
				this._systemTag.gotoAndStop(1);
			}else if(ResData._currentResBox==1){
				this._userTag.gotoAndStop(1);
			}
		}
		private function tagClickHandler(e:MouseEvent):void
		{
			
			if(ResData._currentResBox==0&&this._systemTag.currentFrame==1 || ResData._currentResBox==1&&this._userTag.currentFrame==1){
				return;
			}
			if(ResData._currentResBox==0){
				this._systemTag.gotoAndStop(0);
				this._userTag.gotoAndStop(1);
				ResData._currentResBox=1;
			}else if(ResData._currentResBox==1){
				this._userTag.gotoAndStop(0);
				this._systemTag.gotoAndStop(1);
				ResData._currentResBox=0;
				
			}
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
					if(MainData.systemResourcesAry.length>0){
						userRes();
					}
					break;
				default:
					break;
			}
			
		}
		private function systemRes():void
		{
			this._resGroup=new Group;
			this._resGroup.layout=this._resLayout;
			var len:int=MainData.systemResourcesAry.length;
			for(var i:int=0;i<len;i++){
				this._resView=this._factory.createResBox(MainData.systemResourcesAry[i]);
			}
		}
		private function userRes():void
		{
			var len:int=MainData.myResourcesAry.length;
			for(var i:int=0;i<len;i++){
				
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
		}
	}
}