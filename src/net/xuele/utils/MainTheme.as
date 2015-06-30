package net.xuele.utils
{
	import org.flexlite.domUI.core.Theme;
	import org.flexlite.domUI.skins.vector.AlertSkin;
	
	public class MainTheme extends Theme
	{
		public function MainTheme()
		{
			super();
			init();
		}
		private function init():void
		{
			mapSkin("org.flexlite.domUI.components::Alert",AlertSkin);
		}
	}
}