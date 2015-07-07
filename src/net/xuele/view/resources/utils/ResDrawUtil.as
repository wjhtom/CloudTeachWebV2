package net.xuele.view.resources.utils
{
	import flash.display.BlendMode;
	import flash.events.MouseEvent;
	
	import net.xuele.utils.MainData;
	import net.xuele.view.draw.utils.DrawData;
	
	import org.flexlite.domUI.components.Group;

	public class ResDrawUtil
	{
		public function ResDrawUtil()
		{
		}
		private static var _canvas:Group;
		/**
		 * 类型：0：铅笔，1：橡皮 
		 */
		private static var _type:int;
		public static function drawPencil(canvas:Group,t:int):void
		{
			_canvas=canvas;
			_type=t;
			_canvas.blendMode=BlendMode.LAYER;
			_canvas.addEventListener(MouseEvent.MOUSE_DOWN,pencilDownHandler);
			_canvas.addEventListener(MouseEvent.MOUSE_UP,pencilUpHandler);
			_canvas.addEventListener(MouseEvent.RELEASE_OUTSIDE,pencilUpHandler);
			_canvas.addEventListener(MouseEvent.MOUSE_MOVE,pencilMoveHandler);
		}
		private static var drawGroup:Group;
		private static var isDown:Boolean=false;
		private static function pencilDownHandler(e:MouseEvent):void
		{
			
			isDown=true;
			drawGroup=new Group;
			drawGroup.x=e.stageX;
			drawGroup.y=e.stageY;
			var thickness:int;
			if(_type==0){
				drawGroup.blendMode=BlendMode.NORMAL;
			}else if(_type==1){
				drawGroup.blendMode=BlendMode.ERASE;
			}
			_canvas.addElement(drawGroup);
			drawGroup.graphics.lineStyle(10,DrawData._currentColor);
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
			drawGroup.graphics.lineTo(e.stageX-drawGroup.x,e.stageY-drawGroup.y);
		}
	}
}