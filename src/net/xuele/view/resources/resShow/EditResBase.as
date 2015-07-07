package net.xuele.view.resources.resShow
{
	
	import com.senocular.display.TransformTool;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Video;
	import flash.utils.Timer;
	
	import net.xuele.commond.CommondView;
	import net.xuele.utils.PopUtils;
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.draw.utils.DrawUtils;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.utils.ResDrawUtil;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.McButton;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUtils.DomLoader;
	
	/**
	 * 可编辑资源容器
	 * @author jianhua
	 * 
	 */
	public class EditResBase extends Group implements IResShow
	{
		protected var _resGroup:Group;
		private var _drawGroup:Group;
		private var _menuGroup:Group;
		protected var _resVo:ResourceVo;
		/**
		 * 是否拖动（是true/否false） 
		 */
		private var _isDrag:Boolean;
		public function EditResBase()
		{
			super();
		}
		
		public function createUI(resVo:ResourceVo):void
		{
			this._resVo=resVo;
			var timer:Timer=new Timer(20,1);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void
		{
			Timer(e.target).removeEventListener(TimerEvent.TIMER,timerHandler);
			init();
		}
		
		// default tool
		private var defaultTool:TransformTool;
		
		
		// custom tool with some custom options
		private var customTool:TransformTool;
		private var currTool:TransformTool;
		private function init():void
		{
			defaultTool=new TransformTool;
			customTool=new TransformTool;
			currTool=defaultTool;
			//			currTool.moveEnabled=false;
			currTool.skewEnabled=false;
			//			currTool.rotationEnabled=false;
			addElement(defaultTool);
			addElement(customTool);
			
			this._resGroup=new Group;
			this.addElement(this._resGroup);
			this._drawGroup=new Group;
			this.addElement(this._drawGroup);
			this._menuGroup=new Group;
			this.addElement(this._menuGroup);
			this._menuGroup.horizontalCenter=0;
			this._menuGroup.bottom=0;
			
			createRes();
		}
		
		/**
		 * 创建资源 
		 * 
		 */
		protected function createRes():void
		{
		}
		
		
		private var resetBtn:McButton;
		private var editBtn:McButton;
		private var pencilBtn:McButton;
		private var eraseBtn:McButton;
		/**
		 * 创建菜单 
		 * 
		 */
		private function createMenu():void
		{
			resetBtn=new McButton;
			resetBtn.skinName=PublicOperate.getUI("ResReset","movieclip");
			editBtn=new McButton;
			editBtn.skinName=PublicOperate.getUI("ResEdit","movieclip");
			pencilBtn=new McButton;
			pencilBtn.skinName=PublicOperate.getUI("MenuPencil","movieclip");
			eraseBtn=new McButton;
			eraseBtn.skinName=PublicOperate.getUI("MenuEraser","movieclip");
			resetBtn.addEventListener(MouseEvent.CLICK,resetHandler);
			editBtn.addEventListener(MouseEvent.CLICK,editHandler);
			pencilBtn.addEventListener(MouseEvent.CLICK,pencilHandler);
			eraseBtn.addEventListener(MouseEvent.CLICK,eraseHandler);
		}
		private function removeMenu():void
		{
			resetBtn.removeEventListener(MouseEvent.CLICK,resetHandler);
			editBtn.removeEventListener(MouseEvent.CLICK,editHandler);
			pencilBtn.removeEventListener(MouseEvent.CLICK,pencilHandler);
			eraseBtn.removeEventListener(MouseEvent.CLICK,eraseHandler);
			this._menuGroup.removeAllElements();
		}
		private function resetHandler(e:MouseEvent):void
		{
			
		}
		private function editHandler(e:MouseEvent):void
		{
			this.editRes();
		}
		private var _isErase:Boolean=false;
		private var _isPencil:Boolean=false;
		private function pencilHandler(e:MouseEvent):void
		{
			if(_isErase){
				_isErase=false;
			}
			_isPencil=!_isPencil;
			if(_isPencil){
				ResDrawUtil.drawPencil(this._drawGroup,0);
			}
		}
		
		private function eraseHandler(e:MouseEvent):void
		{
			if(_isPencil){
				_isPencil=false;
			}
			_isErase=!_isErase;
			if(_isErase){
				ResDrawUtil.drawPencil(this._drawGroup,1);
			}
		}
		public function editRes():void
		{
			trace("editRes")
			currTool.target=this._resGroup;
			CommondView.currentTool=currTool;
		}
		public function resetRes():void
		{
		}
		
		public function removeListener():void
		{
			if(this._isDrag){
				this.stopDrag();
			}
		}
		
		public function startResDrag():void
		{
			this.startDrag();
		}
		public function stopResDrag():void
		{
			this.stopDrag();
		}
	}
}

