package net.xuele.view.draw.utils
{
	import flash.events.MouseEvent;
	
	import net.xuele.commond.CommonControl;
	import net.xuele.commond.MenuEvent;
	import net.xuele.utils.MainData;
	import net.xuele.view.menu.utils.MenuData;
	
	import org.flexlite.domUI.components.Group;
	
	

	/**
	 * 画线与画直线 
	 * @author jianhua
	 * 
	 */
	public class DrawUtils
	{
		public function DrawUtils()
		{
		}
		public static function drawPencil():void
		{
			DrawData._currentCanvas.addEventListener(MouseEvent.MOUSE_DOWN,pencilDownHandler);
			DrawData._currentCanvas.addEventListener(MouseEvent.MOUSE_UP,pencilUpHandler);
			DrawData._currentCanvas.addEventListener(MouseEvent.MOUSE_MOVE,pencilMoveHandler);
		}
		private static var drawGroup:Group;
		private static function pencilDownHandler(e:MouseEvent):void
		{
			if(DrawData._pencilThicknessShow){
				CommonControl.control.dispatchEvent(new MenuEvent(MenuEvent.HIDETHICKNESS));
			}
			if(MainData._mouseType==1){
				var thickness:int;
				switch(DrawData._pencilThickness){
					case 1:
						thickness=5;
						break;
					case 2:
						thickness=10;
						break;
					case 3:
						thickness=15;
						break;
					case 4:
						thickness=20;
						break;
					default:
						break;
				}
				drawGroup=new Group;
				drawGroup.x=e.stageX;
				drawGroup.y=e.stageY;
				DrawData._currentCanvas.addElement(drawGroup);
				drawGroup.graphics.lineStyle(thickness,DrawData._currentColor);
			}else if(MainData._mouseType==3){
				
			}
		}
		private static function pencilUpHandler(e:MouseEvent):void
		{
			if(MainData._mouseType==1){
				
			}else if(MainData._mouseType==3){
				
			}
		}
		private static function pencilMoveHandler(e:MouseEvent):void
		{
			if(MainData._mouseType==1){
				drawGroup.graphics.lineTo(e.stageX-drawGroup.x,e.stageY-drawGroup.y)
			}else if(MainData._mouseType==3){
				
			}
		}
		public static function drawLine():void
		{
			DrawData._currentCanvas.stage.addEventListener(MouseEvent.MOUSE_DOWN,lineDownHandler);
			DrawData._currentCanvas.stage.addEventListener(MouseEvent.MOUSE_UP,lineUpHandler);
			DrawData._currentCanvas.stage.addEventListener(MouseEvent.MOUSE_MOVE,lineMoveHandler);
		}
		private static function lineDownHandler(e:MouseEvent):void
		{
			if(MainData._mouseType==2){
				
			}else if(MainData._mouseType==3){
				
			}
		}
		private static function lineUpHandler(e:MouseEvent):void
		{
			if(MainData._mouseType==2){
				
			}else if(MainData._mouseType==3){
				
			}
		}
		private static function lineMoveHandler(e:MouseEvent):void
		{
			if(MainData._mouseType==2){
				
			}else if(MainData._mouseType==3){
				
			}
		}
		/**
		 * 停止画铅笔或橡皮功能
		 * 
		 */
		public static function stopDrawPencil():void
		{
			DrawData._currentCanvas.stage.removeEventListener(MouseEvent.MOUSE_DOWN,pencilDownHandler);
			DrawData._currentCanvas.stage.removeEventListener(MouseEvent.MOUSE_UP,pencilUpHandler);
			DrawData._currentCanvas.stage.removeEventListener(MouseEvent.MOUSE_MOVE,pencilMoveHandler);
		}
		/**
		 * 停止画直线或橡皮功能 
		 * 
		 */
		public static function stopDrawLine():void
		{
			DrawData._currentCanvas.stage.removeEventListener(MouseEvent.MOUSE_DOWN,lineDownHandler);
			DrawData._currentCanvas.stage.removeEventListener(MouseEvent.MOUSE_UP,lineUpHandler);
			DrawData._currentCanvas.stage.removeEventListener(MouseEvent.MOUSE_MOVE,lineMoveHandler);
		}
	}
}