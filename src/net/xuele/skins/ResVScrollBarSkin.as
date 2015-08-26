package net.xuele.skins
{
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.skins.VectorSkin;
	import org.flexlite.domUI.skins.vector.ScrollBarDownButtonSkin;
	import org.flexlite.domUI.skins.vector.ScrollBarUpButtonSkin;
	import org.flexlite.domUI.skins.vector.VScrollBarThumbSkin;
	import org.flexlite.domUI.skins.vector.VScrollBarTrackSkin;
	
	public class ResVScrollBarSkin extends VectorSkin
	{
		public function ResVScrollBarSkin()
		{
			super();
			this.minWidth = 7;
			this.minHeight = 50;
		}
		public var decrementButton:Button;
		
		public var incrementButton:Button;
		
		public var thumb:Button;
		
		public var track:Button;
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			track = new Button();
			track.top = 0;
			track.bottom = 0;
			track.height = 54;
			track.skinName = ResVScrollBarTrackSkin;
			addElement(track);
			
//			decrementButton = new Button();
//			decrementButton.top = 0;
//			decrementButton.skinName = ScrollBarUpButtonSkin;
//			addElement(decrementButton);
//			
//			incrementButton = new Button();
//			incrementButton.bottom = 0;
//			incrementButton.skinName = ScrollBarDownButtonSkin;
//			addElement(incrementButton);
			
			thumb = new Button();
			thumb.skinName = ResVScrollBarThumbSkin;
			addElement(thumb);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function updateDisplayList(w:Number,h:Number):void
		{
			super.updateDisplayList(w,h);
			this.alpha = currentState=="disabled"?0.5:1;
		}
	}
}