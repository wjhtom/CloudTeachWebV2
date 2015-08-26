package
{
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.TextField;
	
	import net.xuele.FlexLiteManager;
	import net.xuele.utils.MainData;
	import net.xuele.utils.MyCrypto;
	
	
	[SWF(width="1000", height="630", backgroundColor="#ffffff")]
	public class CloudTeachWebV2 extends Sprite
	{
		public function CloudTeachWebV2()
		{
			init();
		}
		private function init():void
		{
			Security.loadPolicyFile("http://dl.xueleyun.com/crossdomain.xml");
			Security.allowDomain("dl.xueleyun.com");
			Security.allowDomain("*");
			MainData._coursewaresId=this.loaderInfo.parameters["coursewaresId"];
			MainData._teachType=this.loaderInfo.parameters["type"];
			MainData._unitId=this.loaderInfo.parameters["unitId"];
			MainData._unitName=this.loaderInfo.parameters["unitName"];
			MainData._userId=this.loaderInfo.parameters["userId"];
			MainData._schoolId=this.loaderInfo.parameters["schoolId"];
			
//			MainData._isOnline=true;
			trace(this.loaderInfo.url)
			if(this.loaderInfo.url.substr(0,8)=="file:///"){
//			if(!MainData._isOnline){
				MainData._isOnline=false;
//				InterfaceData._interfaceListURL="data/config.xml";
				
			}else{
				MainData._userId=MyCrypto.AESEncode(MainData._userId);
				MainData._schoolId=MyCrypto.AESEncode(MainData._schoolId);
				MainData._isOnline=true;
			}
			var flexLiteMangager:FlexLiteManager=new FlexLiteManager;
			this.addChild(flexLiteMangager);
		}
	}
}