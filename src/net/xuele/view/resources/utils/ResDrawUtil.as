package net.xuele.view.resources.utils
{
	import flash.display.BlendMode;
	import flash.events.MouseEvent;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.MainData;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.draw.utils.DrawData;
	
	import org.flexlite.domUI.components.Group;

	public class ResDrawUtil
	{
		public function ResDrawUtil()
		{
		}
		private static var _canvas:Group;
		public static function drawPencil(canvas:Group):void
		{
			DrawData._currentCanvas.mouseEnabled=false;
			_canvas=canvas;
			_canvas.mouseEnabled=true;
			_canvas.blendMode=BlendMode.LAYER;
			if(ResData._currentTools!=null){
				ResData._currentTools.moveEnabled=false;
			}
			_canvas.addEventListener(MouseEvent.MOUSE_DOWN,pencilDownHandler);
			_canvas.addEventListener(MouseEvent.MOUSE_UP,pencilUpHandler);
			_canvas.addEventListener(MouseEvent.RELEASE_OUTSIDE,pencilUpHandler);
			_canvas.addEventListener(MouseEvent.MOUSE_MOVE,pencilMoveHandler);
		}
		private static var drawGroup:Group;
		private static var isDown:Boolean=false;
		private static function pencilDownHandler(e:MouseEvent):void
		{
			if(MainData._mouseType==0){
				return;
			}
			isDown=true;
			drawGroup=new Group;
			drawGroup.name="drawGroup";
			drawGroup.x=_canvas.mouseX;
			drawGroup.y=_canvas.mouseY;
			var thickness:int;
			if(MainData._mouseType==6){
				drawGroup.blendMode=BlendMode.NORMAL;
				drawGroup.graphics.lineStyle(10,0xff0000,0.5);
			}else if(MainData._mouseType==7){
				drawGroup.blendMode=BlendMode.ERASE;
				drawGroup.graphics.lineStyle(30,DrawData._currentColor,1);
			}
			_canvas.addElement(drawGroup);
		}
		private static function pencilUpHandler(e:MouseEvent):void
		{
			isDown=false;
		}
		private static function pencilMoveHandler(e:MouseEvent):void
		{
			if(!isDown){
				return;
			}
			if(drawGroup==null){
				return;
			}
			if(_canvas.mouseY<_canvas.height&&_canvas.mouseY>0&&_canvas.mouseX>0&&_canvas.mouseX<_canvas.width)
			{
				drawGroup.graphics.lineTo(_canvas.mouseX-drawGroup.x-drawGroup.parent.x,_canvas.mouseY-drawGroup.y-drawGroup.parent.y);
			}
		}
		/**
		 * 停止画铅笔或橡皮功能
		 * 
		 */
		public static function stopDrawPencil():void
		{
			_canvas.mouseEnabled=false;
			if(ResData._currentTools!=null){
				ResData._currentTools.moveEnabled=true;
			}
			_canvas.removeEventListener(MouseEvent.MOUSE_DOWN,pencilDownHandler);
			_canvas.removeEventListener(MouseEvent.MOUSE_UP,pencilUpHandler);
			_canvas.removeEventListener(MouseEvent.MOUSE_MOVE,pencilMoveHandler);
			_canvas.removeEventListener(MouseEvent.RELEASE_OUTSIDE,pencilUpHandler);
			PublicOperate.setMouseType(0);
		}
	}
}