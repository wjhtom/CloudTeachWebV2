package net.xuele.view.draw.utils
{
	import flash.display.BlendMode;
	import flash.events.MouseEvent;
	
	import net.xuele.commond.CommondView;
	import net.xuele.commond.MenuEvent;
	import net.xuele.utils.MainData;
	import net.xuele.view.menu.controller.EraseController;
	import net.xuele.view.menu.controller.PencilController;
	import net.xuele.view.pages.utils.PagesData;
	
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
			trace(DrawData._currentCanvas)
			DrawData._currentCanvas.mouseEnabled=true;
			DrawData._currentCanvas.blendMode=BlendMode.LAYER;
			DrawData._currentCanvas.addEventListener(MouseEvent.MOUSE_DOWN,pencilDownHandler);
			DrawData._currentCanvas.addEventListener(MouseEvent.MOUSE_UP,pencilUpHandler);
			DrawData._currentCanvas.addEventListener(MouseEvent.RELEASE_OUTSIDE,pencilUpHandler);
			DrawData._currentCanvas.addEventListener(MouseEvent.MOUSE_MOVE,pencilMoveHandler);
		}
		private static var drawGroup:Group;
		private static var isDown:Boolean=false;
		private static function pencilDownHandler(e:MouseEvent):void
		{
//			DrawData._currentCanvas.mouseEnabled=true;
			if(DrawData._pencilThicknessShow){
				PencilController.control.dispatchEvent(new MenuEvent(MenuEvent.HIDETHICKNESS));
			}
			if(DrawData._eraseThicknessShow){
				EraseController.control.dispatchEvent(new MenuEvent(MenuEvent.HIDETHICKNESS));
			}
			
			isDown=true;
			drawGroup=new Group;
			drawGroup.x=drawGroup.mouseX;
			drawGroup.y=drawGroup.mouseY;
			var thickness:int;
			if(MainData._mouseType==1){
				switch(DrawData._pencilThickness){
					case 1:
						thickness=5;
						break;
					case 2:
						thickness=7;
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
				drawGroup.blendMode=BlendMode.NORMAL;
			}else if(MainData._mouseType==3){
				switch(DrawData._eraseThickness){
					case 1:
						thickness=15;
						break;
					case 2:
						thickness=20;
						break;
					case 3:
						thickness=40;
						break;
					default:
						break;
				}
				drawGroup.blendMode=BlendMode.ERASE;
			}
			DrawData._currentCanvas.addElement(drawGroup);
			drawGroup.graphics.lineStyle(thickness,DrawData._currentColor);
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
//			drawGroup.graphics.lineTo(e.stageX-drawGroup.x,e.stageY-drawGroup.y);
			drawGroup.graphics.lineTo(drawGroup.mouseX,drawGroup.mouseY);
//			if(MainData._mouseType==1){
//			}else if(MainData._mouseType==3){
//				
//			}
		}
		public static function drawLine():void
		{
			DrawData._currentCanvas.addEventListener(MouseEvent.MOUSE_DOWN,lineDownHandler);
			DrawData._currentCanvas.addEventListener(MouseEvent.MOUSE_UP,lineUpHandler);
			DrawData._currentCanvas.addEventListener(MouseEvent.MOUSE_MOVE,lineMoveHandler);
			DrawData._currentCanvas.addEventListener(MouseEvent.RELEASE_OUTSIDE,lineUpHandler);
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
			DrawData._currentCanvas.mouseEnabled=false;
			DrawData._currentCanvas.removeEventListener(MouseEvent.MOUSE_DOWN,pencilDownHandler);
			DrawData._currentCanvas.removeEventListener(MouseEvent.MOUSE_UP,pencilUpHandler);
			DrawData._currentCanvas.removeEventListener(MouseEvent.MOUSE_MOVE,pencilMoveHandler);
			DrawData._currentCanvas.removeEventListener(MouseEvent.RELEASE_OUTSIDE,pencilUpHandler);
		}
		/**
		 * 停止画直线或橡皮功能 
		 * 
		 */
		public static function stopDrawLine():void
		{
			DrawData._currentCanvas.mouseEnabled=false;
			DrawData._currentCanvas.removeEventListener(MouseEvent.MOUSE_DOWN,lineDownHandler);
			DrawData._currentCanvas.removeEventListener(MouseEvent.MOUSE_UP,lineUpHandler);
			DrawData._currentCanvas.removeEventListener(MouseEvent.MOUSE_MOVE,lineMoveHandler);
			DrawData._currentCanvas.removeEventListener(MouseEvent.RELEASE_OUTSIDE,lineUpHandler);
		}
	}
}