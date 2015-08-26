package net.xuele.view.pages.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.pages.events.PageEvent;
	import net.xuele.view.pages.factorys.PageFactory;
	import net.xuele.view.pages.interfaces.IPageNum;
	import net.xuele.view.pages.utils.PagesData;
	import net.xuele.view.pages.utils.PagesUtil;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.VerticalLayout;
	import org.flexlite.domUI.utils.callLater;
	
	/**
	 * 页码显示区 
	 * @author jianhua
	 * 
	 */
	public class PageNumView extends Group
	{
		private var _addPageBtn:McButton;
		private var _delPageBtn:McButton;
		private var _factory:PageFactory;
		private var _selectedPage:IPageNum;
//		private var _selectedID:int;
		
		private var _contentGroup:Group;
		private var _numGroup:Group;
		private var _numAry:Array=[];
		public function PageNumView()
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
			this.width=45;
			this.height=MainData._stageHeight-30;
			_factory=new PageFactory;
			createUI();
			if(MainData._teachType==1||MainData._teachType==4){
				createDelBtn();
			}
			
			
		}
		private function createUI():void
		{
			var bg:Rect=new Rect;
			bg.fillAlpha=0.2;
			bg.fillColor=0x80B9B5;
			bg.percentWidth=bg.percentHeight=100;
			this.addElement(bg);
			
			var contentLayout:VerticalLayout=new VerticalLayout;
			contentLayout.gap=3;
			var numLayout:VerticalLayout=new VerticalLayout;
			numLayout.gap=0;
			_contentGroup=new Group;
			_contentGroup.layout=contentLayout;
			
			_numGroup=new Group;
			_numGroup.layout=numLayout;
			_contentGroup.addElement(_numGroup);
			_numAry=[];
			for(var i:int=0;i<PagesData._currentPageNum;i++){
				var pageNum:IPageNum=_factory.createPageNum(i);
				_numGroup.addElement(pageNum);
				if(i==0){
					this._selectedPage=pageNum;
				}
				_numAry.push(pageNum);
				pageNum.addEventListener(MouseEvent.CLICK,selectPageHandler);
			}
			
			if(MainData._teachType==1||MainData._teachType==4){
				this._addPageBtn=new McButton;
				this._addPageBtn.skinName=PublicOperate.getUI("AddPageBtn","movieclip") as MovieClip;
				_contentGroup.addElement(this._addPageBtn);
				this._addPageBtn.addEventListener(MouseEvent.CLICK,addPageHandler);
			}
			this.addElement(_contentGroup);
			
			callLater(timerHandler,null,2);
		}
		private function timerHandler():void
		{
			this._selectedPage.selectedPage();
			_contentGroup.bottom=20;
			_contentGroup.horizontalCenter=0;
		}
		private var _clickPageNum:IPageNum;
		private function selectPageHandler(e:MouseEvent):void
		{
			_clickPageNum=IPageNum(e.currentTarget)
			if(_clickPageNum.pageID==_selectedPage.pageID){
				return;
			}
			PagesData._selectPageNum=_clickPageNum.pageID;
			PublicOperate.setMouseType(0);
			this.dispatchEvent(new PageEvent(PageEvent.SELECTSMALLPAGE));
			if(this._delPageBtn){
				Group(_selectedPage).addElement(this._delPageBtn);
			}
			PagesUtil.changeBigPage(_selectedPage.pageID);
		}
		public function selectSmallPage():void
		{
			_selectedPage.unSelectedPage();
			for(var i:int=0;i<PagesData._currentPageNum;i++){
				trace(IPageNum(_numAry[i]).pageID,PagesData._selectPageNum,"numAry")
				
				if(IPageNum(_numAry[i]).pageID==PagesData._selectPageNum){
					_selectedPage=IPageNum(_numAry[i])
					IPageNum(_numAry[i]).selectedPage();
					break;
				}
			}
			
		}
		private function addPageHandler(e:MouseEvent):void
		{
			if(PagesData._currentPageNum>=PagesData.MAXPAGENUM){
				PublicOperate.setAlert("页数满了","页数已满，不能再添加了");
				return;
			}
			PagesUtil.addPage();
			_selectedPage.unSelectedPage();
			var pageNum:IPageNum=_factory.createPageNum(PagesData._currentPageNum-1);
			_numGroup.addElement(pageNum);
			_selectedPage=pageNum;
			this.validateNow();
			_selectedPage.selectedPage();
			_numAry.push(pageNum);
			Group(_selectedPage).addElement(this._delPageBtn);
			pageNum.addEventListener(MouseEvent.CLICK,selectPageHandler);
		}
		private function createDelBtn():void
		{
			this._delPageBtn=new McButton;
			this._delPageBtn.skinName=PublicOperate.getUI("DelPageBtn","movieclip") as MovieClip;
			Group(_selectedPage).addElement(this._delPageBtn);
			this.validateNow();
			this._delPageBtn.right=-this._delPageBtn.width-10;
			this._delPageBtn.addEventListener(MouseEvent.CLICK,delPage);
//			this._delPageBtn.y=this._contentGroup.y+this._selectedPage.y;
		}
		private function delPage(e:MouseEvent):void
		{
			if(PagesData._currentPageNum==1){
				PublicOperate.setAlert("删除失败","已经只剩一个页面了，不能再删除了");
				return;
			}
			for(var i:int=0;i<PagesData._currentPageNum;i++){
				var pageNum:IPageNum=IPageNum(_numGroup.getElementAt(i));
				pageNum.removeEventListener(MouseEvent.CLICK,selectPageHandler);
			}
//			this._delPageBtn.removeEventListener(MouseEvent.CLICK,delPage);
			if(_delPageBtn){
				Group(_selectedPage).removeElement(this._delPageBtn);
			}
			
			_numGroup.removeAllElements();
			PagesUtil.delPage(_selectedPage.pageID);
			resetPage();
		}
		private function resetPage():void
		{
			_numAry=[];
			for(var i:int=0;i<PagesData._currentPageNum;i++){
				var pageNum:IPageNum=_factory.createPageNum(i);
				_numGroup.addElement(pageNum);
				if(i==PagesData._currentPageID){
					_selectedPage=pageNum;
				}
				_numAry.push(pageNum);
				pageNum.addEventListener(MouseEvent.CLICK,selectPageHandler);
			}
			this.validateNow();
			this._selectedPage.selectedPage();
			if(this._delPageBtn){
				Group(_selectedPage).addElement(this._delPageBtn);
			}
		}
		
		private function addListener():void
		{
			
		}
	}
}