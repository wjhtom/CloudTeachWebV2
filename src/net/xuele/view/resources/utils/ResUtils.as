package net.xuele.view.resources.utils
{
	import flash.display.Sprite;
	
	import net.xuele.utils.PublicOperate;
	
	import org.flexlite.domUI.components.UIAsset;

	public class ResUtils
	{
		public function ResUtils()
		{
		}
		/**
		 * 获取资源图标 
		 * @param isBig 是否大图标 true:大图标，false:小图标
		 * @param ex 后缀名
		 * @return 
		 * 
		 */
		public static function getResIcon(ex:String,isBig:Boolean=true):UIAsset
		{
			var icon:Sprite;
			switch(ex){
				case "png":
				case "jpeg":
				case "bmp":
				case "jpg":
					if(isBig){
						icon=PublicOperate.getUI("IconBigImg") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallImg") as Sprite;
					}
					break;
				case "txt":
					if(isBig){
						icon=PublicOperate.getUI("IconBigTxt") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallTxt") as Sprite;
					}
					break;
				case "doc":
				case "docx":
					if(isBig){
						icon=PublicOperate.getUI("IconBigDoc") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallDoc") as Sprite;
					}
					break;
				case "xls":
				case "xlsx":
					if(isBig){
						icon=PublicOperate.getUI("IconBigXls") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallXls") as Sprite;
					}
					break;
				case "ppt":
				case "pptx":
					if(isBig){
						icon=PublicOperate.getUI("IconSmallPPT") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallPPT") as Sprite;
					}
					break;
				case "pdf":
					if(isBig){
						icon=PublicOperate.getUI("IconBigPdf") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallPdf") as Sprite;
					}
					break;
				case "mp3":
				case "wav":
				case "wma":
					if(isBig){
						icon=PublicOperate.getUI("IconBigSound") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallSound") as Sprite;
					}
					break;
				case "flv":
				case "avi":
				case "mpeg":
				case "mpg":
				case "mp4":
				case "rmvb":
				case "wmv":
				case "mkv":
				case "3gp":
				case "mov":
				case "navi":
				case "rm":
					if(isBig){
						icon=PublicOperate.getUI("IconBigVideo") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallVideo") as Sprite;
					}
					break;
				case "swf":
					if(isBig){
						icon=PublicOperate.getUI("IconBigSWF") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallSWF") as Sprite;
					}
					break;
				default:
					if(isBig){
						icon=PublicOperate.getUI("IconBigNormal") as Sprite;
					}else{
						icon=PublicOperate.getUI("IconSmallNormal") as Sprite;
					}
					break;
			}
			var iconUI:UIAsset=new UIAsset;
			iconUI.skinName=icon;
			return iconUI;
		}
	}
}