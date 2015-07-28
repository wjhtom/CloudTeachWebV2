package net.xuele.view.menu.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.menu.interfaces.IItem;
	import net.xuele.view.menu.utils.MenuData;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	
	/**
	 * 笔触大小 
	 * @author jianhua
	 * 
	 */
	public class Thickness extends Group implements IItem
	{
		/**
		 * 笔触大小（1，2，3） 
		 */
		private var _thicknessID:int;
		public var _id:int;
		public function Thickness(v:int)
		{
			super();
			this._thicknessID=v;
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom);
		}
		
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			createUI();
		}
		private var uiMC:UIMovieClip;
		public function createUI():void
		{
			var mc:MovieClip;
			if(MainData._mouseType==3){
				//橡皮
				switch(this._thicknessID){
					case 1:
						mc=PublicOperate.getUI("EraserThickness1","movieclip") as MovieClip;
						break;
					case 2:
						mc=PublicOperate.getUI("EraserThickness2","movieclip") as MovieClip;
						break;
					case 3:
						mc=PublicOperate.getUI("EraserThickness3","movieclip") as MovieClip;
						break;
					default:
						break;
				}
			}else{
				//铅笔
				switch(this._thicknessID){
					case 1:
						mc=PublicOperate.getUI("PencilThickness1","movieclip") as MovieClip;
						break;
					case 2:
						mc=PublicOperate.getUI("PencilThickness2","movieclip") as MovieClip;
						break;
					case 3:
						mc=PublicOperate.getUI("PencilThickness3","movieclip") as MovieClip;
						break;
					case 4:
						mc=PublicOperate.getUI("PencilThickness4","movieclip") as MovieClip;
						break;
					default:
						break;
				}
			}
			
			uiMC=new UIMovieClip;
			uiMC.skinName=mc;
			uiMC.gotoAndStop(0);
			this.addElement(uiMC);
			
		}
		
		public function get contentMovie():UIMovieClip
		{
			return uiMC;
		}
		public function click():void
		{
			
		}
		/**
		 * 笔触动画 
		 * @return 
		 * 
		 */
		public function get thicknessMovie():UIMovieClip
		{
			return uiMC;
		}
	}
}