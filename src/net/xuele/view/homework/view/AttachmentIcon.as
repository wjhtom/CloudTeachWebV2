package net.xuele.view.homework.view
{
	import net.xuele.view.homework.interfaces.IAttachmentContent;
	import net.xuele.view.resources.utils.ResUtils;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.events.UIEvent;
	
	/**
	 * 作业附件内容 
	 * @author jianhua
	 * 
	 */
	public class AttachmentIcon extends Group implements IAttachmentContent
	{
		private var _resVo:ResourceVo;
		private var _ico:UIAsset;
		private var _isSelected:Boolean=false;
		private var _selectRect:Rect;
		public function AttachmentIcon(rVo:ResourceVo)
		{
			super();
			_resVo=rVo;
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
		private function createUI():void
		{
			this._ico=new UIAsset;
			this._ico.skinName=ResUtils.getResIcon(this._resVo._ex);
			this.addElement(this._ico);
			this._ico.width=50;
			this._ico.height=50;
			_selectRect=new Rect;
			_selectRect.width=50;
			_selectRect.height=50;
			this._selectRect.fillAlpha=0;
			this._selectRect.strokeAlpha=0;
			this._selectRect.strokeColor=0xff9900;
			this._selectRect.strokeWeight=1;
			this.addElement(this._selectRect);
			if(this._isSelected){
				this._selectRect.strokeAlpha=1;
			}
		}
		public function select():void
		{
			if(this._isSelected){
				unSelect();
			}else{
				this._selectRect.strokeAlpha=1;
				this._isSelected=true;
			}
		}
		public function unSelect():void
		{
			if(!this._isSelected){
				return;
			}
			this._selectRect.strokeAlpha=0;
			this._isSelected=false;
		}
		public function get isSelect():Boolean
		{
			return this._isSelected;
		}
		public function set isSelect(v:Boolean):void
		{
			this._isSelected=v;
		}
		public function get resVo():ResourceVo
		{
			return this._resVo
		}
	}
}