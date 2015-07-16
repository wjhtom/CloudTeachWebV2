package net.xuele.view.pages.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.pages.factorys.PageFactory;
	import net.xuele.view.pages.interfaces.IPageNum;
	import net.xuele.view.pages.utils.PagesData;
	
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
		
		private var _contentGroup:Group;
		private var _numGroup:Group;
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
			this.height=stage.stageHeight;
			_factory=new PageFactory;
			createUI();
			createDelBtn();
		}
		private function createUI():void
		{
			var bg:Rect=new Rect;
			bg.fillAlpha=1;
			bg.fillColor=0x00ff00;
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
			PagesData._currnetPageNum=3;
			for(var i:int=0;i<PagesData._currnetPageNum;i++){
				var pageNum:IPageNum=_factory.createPageNum(i);
				_numGroup.addElement(pageNum);
				if(i==0){
					this._selectedPage=pageNum;
				}
				pageNum.addEventListener(MouseEvent.CLICK,selectPageHandler);
			}
			
			if(MainData._teachType==1){
				this._addPageBtn=new McButton;
				this._addPageBtn.skinName=PublicOperate.getUI("AddPageBtn","movieclip") as MovieClip;
				_contentGroup.addElement(this._addPageBtn);
				this._addPageBtn.addEventListener(MouseEvent.CLICK,addPageHandler);
			}
			this.addElement(_contentGroup);
			
			callLater(timerHandler);
		}
		private function timerHandler():void
		{
			this._selectedPage.selectedPage();
			_contentGroup.bottom=0;
			_contentGroup.horizontalCenter=0;
		}
		private function selectPageHandler(e:MouseEvent):void
		{
			var _pageNum:IPageNum=IPageNum(e.currentTarget)
			if(_pageNum.pageID==_selectedPage.pageID){
				return;
			}
			_selectedPage.unSelectedPage();
			_selectedPage=_pageNum;
			_pageNum.selectedPage();
			Group(_selectedPage).addElement(this._delPageBtn);
		}
		private function addPageHandler(e:MouseEvent):void
		{
			if(PagesData._currnetPageNum>=PagesData.MAXPAGENUM){
				PublicOperate.setAlert("页数满了","页数已满，不能再添加了");
				return;
			}
			PagesData._currnetPageNum++;
			var pageNum:IPageNum=_factory.createPageNum(PagesData._currnetPageNum-1);
			_numGroup.addElement(pageNum);
			
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
			if(PagesData._currnetPageNum==1){
				PublicOperate.setAlert("删除失败","已经只剩一个页面了，不能再删除了");
				return;
			}
			for(var i:int=0;i<PagesData._currnetPageNum;i++){
				var pageNum:IPageNum=IPageNum(_numGroup.getElementAt(i));
				pageNum.removeEventListener(MouseEvent.CLICK,selectPageHandler);
			}
			this._delPageBtn.removeEventListener(MouseEvent.CLICK,delPage);
			Group(_selectedPage).removeElement(this._delPageBtn);
			_numGroup.removeAllElements();
			PagesData._currnetPageNum--;
//			PagesData._pagesAry.splice(this._selectedPage.pageID,1);
			resetPage();
		}
		private function resetPage():void
		{
			for(var i:int=0;i<PagesData._currnetPageNum;i++){
				var pageNum:IPageNum=_factory.createPageNum(i);
				_numGroup.addElement(pageNum);
				if(i==0){
					this._selectedPage=pageNum;
				}
				pageNum.addEventListener(MouseEvent.CLICK,selectPageHandler);
			}
		}
		private function addListener():void
		{
			
		}
	}
}