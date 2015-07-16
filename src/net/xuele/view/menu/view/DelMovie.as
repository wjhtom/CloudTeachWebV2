package net.xuele.view.menu.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import net.xuele.utils.PublicOperate;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.events.UIEvent;
	
	/**
	 * 垃圾桶 
	 * @author jianhua
	 * 
	 */
	public class DelMovie extends Group
	{
		private var _delMC:UIMovieClip;
		public function DelMovie()
		{
			super();
			this.addEventListener(UIEvent.CREATION_COMPLETE,createCom)
		}
		private function createCom(e:UIEvent):void
		{
			this.removeEventListener(UIEvent.CREATION_COMPLETE,createCom);
			init();
		}
		private function init():void
		{
			_delMC=new UIMovieClip;
			_delMC.skinName=PublicOperate.getUI("DelMovie","movieclip") as MovieClip;
			this.addElement(_delMC);
			_delMC.gotoAndStop(0);
			_delMC.addEventListener(MouseEvent.MOUSE_OVER,overHandler);
			_delMC.addEventListener(MouseEvent.MOUSE_OUT,outHandler);
		}
		private function overHandler(e:MouseEvent):void
		{
			this._delMC.gotoAndStop(1);
		}
		private function outHandler(e:MouseEvent):void
		{
			this._delMC.gotoAndStop(0);
		}
	}
}