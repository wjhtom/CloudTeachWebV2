package net.xuele.view.resources.resShow
{
	
	
	
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.utils.ResData;
	
	import org.flexlite.domUI.components.Group;
	
	/**
	 * 可编辑资源容器
	 * @author jianhua
	 * 
	 */
	public class EditResBase extends ResBase implements IResShow
	{
		private var _drawGroup:Group;
		private var _rotation:Number;
		
		public function EditResBase()
		{
			super();
			
		}
		
		
		
		override protected function init():void
		{
			
			this._resGroup=new Group;
			this.addElement(this._resGroup);
			this._drawGroup=new Group;
			this.addElement(this._drawGroup);
			this._drawGroup.mouseChildren=false;
//			this._drawGroup.width=200;
//			this._drawGroup.height=300;
			
			createRes();
		}
		/**
		 * 创建资源 ,继承后重写
		 * 
		 */
		protected function createRes():void
		{
		}
		
		
		override public function get drawGroup():Group
		{
			return this._drawGroup;
		}
		public function set resRotation(v:Number):void
		{
			this._rotation=v;
		}
		public function get resRotation():Number
		{
			return this._rotation;
		}
	}
}

