package net.xuele.view.resources.resImport
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.InterfaceData;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.utils.ReadJSON;
	import net.xuele.utils.ResourcesData;
	import net.xuele.view.resources.control.ResControl;
	import net.xuele.view.resources.events.ResEvent;
	import net.xuele.view.resources.factory.ResFactory;
	import net.xuele.view.resources.interfaces.IResBox;
	import net.xuele.view.resources.resBox.ResView;
	import net.xuele.view.resources.utils.ResData;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.TileLayout;
	import org.flexlite.domUtils.DomLoader;
	
	public class ResImportView extends Group
	{
		/**
		 * 资源容器 
		 */
		private var _resGroup:Group;
		/**
		 * 标签容器 
		 */
		private var _typeTitleGroup:Group;
		/**
		 * 关闭按钮 
		 */
		private var _closeBtn:McButton;
		/**
		 * 确定导入按钮 
		 */
		private var _importBtn:McButton;
		/**
		 * 取消按钮 
		 */
		private var _cancelBtn:McButton;
		/**
		 * 所有资源标签
		 */
		private var _totalRes:UIMovieClip;
		/**
		 * 教案资源标签
		 */
		private var _jiaoanRes:UIMovieClip;
		/**
		 * 学案资源标签 
		 */
		private var _xueanRes:UIMovieClip;
		/**
		 * 课件资源标签
		 */
		private var _kejianRes:UIMovieClip;
		/**
		 * 习题资源标签
		 */
		private var _xitiRes:UIMovieClip;
		/**
		 * 其他资源标签
		 */
		private var _otherRes:UIMovieClip;
		/**
		 * 当前标签（0：全部，2：教案，3：学案，4：课件，5：习题，1：其他） 
		 */
		private var _currentTag:UIMovieClip;
		private var _factory:ResFactory;
		private var _tempResAry:Array;
		private var _importedResAry:Array;
		public function ResImportView()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
//			init();
			loadResData();
		}
		private function loadResData():void
		{
			PopUtils.createLoading();
			DomLoader.loadText(InterfaceData._allResourcesURL,loadCom,PopUtils.loadingPro,PopUtils.IOError);
		}
		private function loadCom(data:String):void
		{
			if(data==null || data==""){
				data=JSON.stringify({"state":0});
			}
			ReadJSON.readAllResources(data);
			init();
		}
		private function init():void
		{
			this.width=MainData._stageWidth;//stage.stageWidth;
			this.height=MainData._stageHeight;//stage.stageHeight;
			_factory=new ResFactory;
			_tempResAry=[];
			_importedResAry=[];
			var len:int=MainData.myResourcesAry.length;
			for(var i:int=0;i<len;i++){
				_importedResAry[i]=MainData.myResourcesAry[i];
			}
			createUI();
			addListener();
		}
		private function createUI():void
		{
			var rect:Rect=new Rect;
			rect.fillAlpha=0.5;
			rect.fillColor=0x000000;
			rect.percentWidth=rect.percentHeight=100;
			this.addElement(rect);
			
			var resGroup:Group=new Group;
			this.addElement(resGroup);
			resGroup.horizontalCenter=resGroup.verticalCenter=0;
			
			var bg:UIAsset=new UIAsset;
			bg.skinName=PublicOperate.getUI("ImportBg");
//			var bg:Rect=new Rect;
//			bg.width=900;
//			bg.height=500;
//			bg.fillAlpha=1;
//			bg.fillColor=0x0000ff;
			
			resGroup.addElement(bg);
			
			
			
			this._typeTitleGroup=new Group;
			var typeLayout:HorizontalLayout=new HorizontalLayout;
			typeLayout.gap=5;
			this._typeTitleGroup.layout=typeLayout;
			resGroup.addElement(this._typeTitleGroup);
			this._typeTitleGroup.left=10;
			this._typeTitleGroup.top=5;
			
			this._totalRes=new UIMovieClip;
			this._totalRes.skinName=PublicOperate.getUI("TotalTag","movieclip");
			this._typeTitleGroup.addElement(this._totalRes);
			this._totalRes.gotoAndStop(0);
			this._jiaoanRes=new UIMovieClip;
			this._jiaoanRes.skinName=PublicOperate.getUI("JiaoanTag","movieclip");
			this._typeTitleGroup.addElement(this._jiaoanRes);
			this._jiaoanRes.gotoAndStop(0);
			this._xueanRes=new UIMovieClip;
			this._xueanRes.skinName=PublicOperate.getUI("XueanTag","movieclip");
			this._typeTitleGroup.addElement(this._xueanRes);
			this._xueanRes.gotoAndStop(0);
			this._kejianRes=new UIMovieClip;
			this._kejianRes.skinName=PublicOperate.getUI("KejianTag","movieclip");
			this._typeTitleGroup.addElement(this._kejianRes);
			this._kejianRes.gotoAndStop(0);
			this._xitiRes=new UIMovieClip;
			this._xitiRes.skinName=PublicOperate.getUI("XitiTag","movieclip");
			this._typeTitleGroup.addElement(this._xitiRes);
			this._xitiRes.gotoAndStop(0);
			this._otherRes=new UIMovieClip;
			this._otherRes.skinName=PublicOperate.getUI("OtherTag","movieclip");
			this._typeTitleGroup.addElement(this._otherRes);
			this._otherRes.gotoAndStop(0);
			
			this._closeBtn=new McButton;
			this._closeBtn.skinName=PublicOperate.getUI("CloseImport","movieclip");
			resGroup.addElement(this._closeBtn);
			this._closeBtn.top=10;
			this._closeBtn.right=20;
			
			this._importBtn=new McButton;
			this._importBtn.skinName=PublicOperate.getUI("ImportBtn","movieclip");
			resGroup.addElement(this._importBtn);
			this._importBtn.right=110;
			this._importBtn.bottom=10;
			
			this._cancelBtn=new McButton;
			this._cancelBtn.skinName=PublicOperate.getUI("CancelImport","movieclip");
			resGroup.addElement(this._cancelBtn);
			this._cancelBtn.right=10;
			this._cancelBtn.bottom=10;
			
			this._resGroup=new Group;
			var resLayout:TileLayout=new TileLayout;
			resLayout.horizontalGap=25;
			resLayout.verticalGap=10;
			resLayout.requestedColumnCount=6;
			this._resGroup.layout=resLayout;
			var sc:Scroller=new Scroller;
			sc.width=750;
			sc.height=300;
			sc.viewport=this._resGroup;
			resGroup.addElement(sc);
			sc.horizontalCenter=0;
			sc.top=50;
			
			_currentTag=this._totalRes;
			_currentTag.gotoAndStop(1);
			createRes(0);
		}
		
		private function addListener():void
		{
			this._totalRes.addEventListener(MouseEvent.CLICK,changeResList);
			this._jiaoanRes.addEventListener(MouseEvent.CLICK,changeResList);
			this._xueanRes.addEventListener(MouseEvent.CLICK,changeResList);
			this._kejianRes.addEventListener(MouseEvent.CLICK,changeResList);
			this._xitiRes.addEventListener(MouseEvent.CLICK,changeResList);
			this._otherRes.addEventListener(MouseEvent.CLICK,changeResList);
			
			this._importBtn.addEventListener(MouseEvent.CLICK,importHandler);
			this._cancelBtn.addEventListener(MouseEvent.CLICK,cancelHandler);
			this._closeBtn.addEventListener(MouseEvent.CLICK,cancelHandler);
		}
		private function changeResList(e:MouseEvent):void
		{
			var uiMC:UIMovieClip=UIMovieClip(e.currentTarget);
			if(this._currentTag==uiMC){
				return;
			}
			this._currentTag.gotoAndStop(0);
			this._currentTag=uiMC;
			this._currentTag.gotoAndStop(1);
			switch(uiMC){
				case this._totalRes:
					createRes(0);
					break;
				case this._jiaoanRes:
					createRes(2);
					break;
				case this._xueanRes:
					createRes(3);
					break;
				case this._kejianRes:
					createRes(4);
					break;
				case this._xitiRes:
					createRes(5);
					break;
				case this._otherRes:
					createRes(1);
					break;
			}
		}
		private function createRes(v:int):void
		{
//			var numElemnet:int=this._resGroup.numElements
//			for(var i:int=0;i<numElemnet;i++){
//				IResBox(this._resGroup.getElementAt(i)).removeEventListener(MouseEvent.CLICK,resClickHandler);
//			}
			removeResListener();
			this._resGroup.removeAllElements();
			var len:int=ResourcesData._allResAry.length;
			for(var i:int=0;i<len;i++){
				var resVo:ResourceVo=ResourcesData._allResAry[i];
				if(v==0){
					var res:IResBox=_factory.createResBox(ResourcesData._allResAry[i]);
				}else{
					if(String(v)==resVo._fileType){
						res=_factory.createResBox(ResourcesData._allResAry[i]);
					}else{
						continue;
					}
				}
				res.unSelect();
				res.createUI();
				var len1:int=this._tempResAry.length;
				for(var j:int=0;j<len1;j++){
					if(res.resVo._fileCode==IResBox(this._tempResAry[j]).resVo._fileCode){
						res.selected();
					}
				}
				var selLen:int=this._importedResAry.length;
				for(j=0;j<selLen;j++){
					if(res.resVo._fileCode==ResourceVo(this._importedResAry[j])._fileCode){
						if(!ResView(res).isSelect){
							this._tempResAry.push(res);
							res.selected();
						}
					}
				}
				this._resGroup.addElement(res);
				res.addEventListener(MouseEvent.CLICK,resClickHandler);
			}
			
		}
		private function resClickHandler(e:MouseEvent):void
		{
			var res:IResBox=IResBox(e.currentTarget);
			if(ResView(res).isSelect){
				res.unSelect();
				var len:int=this._tempResAry.length;
				for(var i:int=0;i<len;i++){
					if(res.resVo._fileCode==IResBox(this._tempResAry[i]).resVo._fileCode){
						this._tempResAry.splice(i,1);
						break;
					}
				}
				len=MainData.myResourcesAry.length;
				for(i=0;i<len;i++){
					if(res.resVo._fileCode==MainData.myResourcesAry[i]._fileCode){
						MainData.myResourcesAry.splice(i,1);
						break;
					}
				}
				len=this._importedResAry.length;
				for(i=0;i<len;i++){
					if(res.resVo._fileCode==ResourceVo(this._importedResAry[i])._fileCode){
						this._importedResAry.splice(i,1);
						break;
					}
				}
			}else{
				res.selected();
				this._tempResAry.push(res);
				
			}
			
		}
		private function importHandler(e:MouseEvent):void
		{
//			MainData.myResourcesAry=[];
			
			var len:int=this._tempResAry.length;
			for(var i:int=0;i<len;i++){
				var len1:int=MainData.myResourcesAry.length;
				var flag:Boolean=false;
				for(var j:int=0;j<len1;j++){
					if(IResBox(this._tempResAry[i]).resVo._fileCode==MainData.myResourcesAry[j]._fileCode){
						flag=true;
						break;
					}
				}
				if(!flag){
					MainData.myResourcesAry.push(IResBox(this._tempResAry[i]).resVo);
				}
			}
			ResControl.control.dispatchEvent(new ResEvent(ResEvent.UPDATAUSERRESOURCES));
			exitThis();
		}
		private function cancelHandler(e:MouseEvent):void
		{
			exitThis();
		}
		private function exitThis():void
		{
			removeResListener();
			this._resGroup.removeAllElements();
			removeListener();
			CommondView.popView.removeElement(this);
		}
		private function removeResListener():void
		{
			var numElemnet:int=this._resGroup.numElements
			for(var i:int=0;i<numElemnet;i++){
				IResBox(this._resGroup.getElementAt(i)).removeEventListener(MouseEvent.CLICK,resClickHandler);
			}
			
		}
		public function removeListener():void
		{
			this._totalRes.removeEventListener(MouseEvent.CLICK,changeResList);
			this._jiaoanRes.removeEventListener(MouseEvent.CLICK,changeResList);
			this._xueanRes.removeEventListener(MouseEvent.CLICK,changeResList);
			this._kejianRes.removeEventListener(MouseEvent.CLICK,changeResList);
			this._xitiRes.removeEventListener(MouseEvent.CLICK,changeResList);
			this._otherRes.removeEventListener(MouseEvent.CLICK,changeResList);
			
			this._importBtn.removeEventListener(MouseEvent.CLICK,importHandler);
			this._cancelBtn.removeEventListener(MouseEvent.CLICK,cancelHandler);
			this._closeBtn.removeEventListener(MouseEvent.CLICK,cancelHandler);
		}
	}
}