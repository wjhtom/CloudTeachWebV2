package net.xuele.view.loading.skins
{
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.skins.VectorSkin;
	import org.flexlite.domUI.skins.vector.ProgressBarThumbSkin;
	import org.flexlite.domUI.skins.vector.ProgressBarTrackSkin;
	
	public class LoadingSkin extends VectorSkin
	{
		public function LoadingSkin()
		{
			super();
			this.minHeight = 24;
			this.minWidth = 30;
		}
		public var thumb:UIAsset;
		public var track:UIAsset;
		public var labelDisplay:Label;
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			track = new UIAsset();
			track.skinName = ProgressBarTrackSkin;
			track.left = 0;
			track.right = 0;
			addElement(track);
			
			thumb = new UIAsset();
			thumb.skinName = ProgressBarThumbSkin;
			addElement(thumb);
			
			labelDisplay = new Label();
			labelDisplay.y = 14;
			labelDisplay.horizontalCenter = 0;
			addElement(labelDisplay);
		}
	}
}