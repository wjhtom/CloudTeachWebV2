package
{
	import flash.display.Sprite;
	
	import net.xuele.FlexLiteManager;
	import net.xuele.utils.InterfaceData;
	import net.xuele.utils.MainData;
	
	[SWF(width="1000", height="628", backgroundColor="#ffffff")]
	public class CloudTeachWebV2 extends Sprite
	{
		public function CloudTeachWebV2()
		{
			init();
		}
		private function init():void
		{
			if(this.loaderInfo.url.substr(0,8)=="file:///"){
				MainData._isOnline=false;
				InterfaceData._interfaceListURL="data/config.xml";
				
			}else{
				MainData._isOnline=true;
			}
			
			var flexLiteMangager:FlexLiteManager=new FlexLiteManager;
			this.addChild(flexLiteMangager);
		}
	}
}