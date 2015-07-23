package net.xuele.utils
{
	import org.flexlite.domUI.core.Theme;
	import org.flexlite.domUI.skins.vector.AlertSkin;
	import org.flexlite.domUI.skins.vector.DropDownListSkin;
	import org.flexlite.domUI.skins.vector.HScrollBarSkin;
	import org.flexlite.domUI.skins.vector.ScrollerSkin;
	import org.flexlite.domUI.skins.vector.VScrollBarSkin;
	
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
			mapSkin("org.flexlite.domUI.components::Scroller",ScrollerSkin);
			mapSkin("org.flexlite.domUI.components::HScrollBar",HScrollBarSkin);
			mapSkin("org.flexlite.domUI.components::VScrollBar",VScrollBarSkin);
			mapSkin("org.flexlite.domUI.components::DropDownList",DropDownListSkin);
		}
	}
}