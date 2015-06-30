package net.xuele.utils
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;

	public class PublicOperate
	{
		public function PublicOperate()
		{
		}
		public static function getUI(name:String="",type:String="sprite",index:int=0):Object
		{
			var obj:Object;
			type=type.toLocaleLowerCase();
			switch(type){
				case "sprite":
					obj=WJHFactory.getUIClass(name,MainData.uiArray[index].contentLoaderInfo) as Sprite;
					break;
				case "movieclip":
				case "movie":
					obj=WJHFactory.getUIClass(name,MainData.uiArray[index].contentLoaderInfo) as MovieClip;
					break;
				case "button":
				case "simplebutton":
					obj=WJHFactory.getUIClass(name,MainData.uiArray[index].contentLoaderInfo) as SimpleButton;
					break;
				default:
					break;
			}
			return obj;
		}
	}
}