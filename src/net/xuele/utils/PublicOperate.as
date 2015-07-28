package net.xuele.utils
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	
	import net.xuele.view.menu.utils.MenuData;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.pages.utils.PagesData;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.view.resources.resShow.InputShow;
	import net.xuele.view.resources.resShow.SoundShow;
	import net.xuele.view.resources.resShow.VideoShow;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Alert;
	import org.flexlite.domUI.components.Group;
	

	public class PublicOperate
	{
		public function PublicOperate()
		{
		}
		/**
		 * 从UI文件里面获取UI 
		 * @param name UI链接
		 * @param type UI类型
		 * @param index 第几个UI文件
		 * @return 
		 * 
		 */
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
		/**
		 * 弹出警告 
		 * @param title
		 * @param content
		 * 
		 */
		public static function setAlert(title:String="",content:String=""):void
		{
			var alert:Alert=Alert.show(content,title);
			alert.showCloseButton=false;
			
		}
		/**
		 * 设置鼠标样式 
		 * @param t
		 * 
		 */
		public static function setMouseType(t:int):void
		{
			MainData._mouseType=t;
			if(MenuData._currentMenu!=null){
				MenuData._currentMenu.gotoAndStop(0);
			}
			if(t==0){
				MenuData._mouseMouse.contentMovie.gotoAndStop(1);
			}else{
				MenuData._mouseMouse.contentMovie.gotoAndStop(0);
			}
		}
		public static function savePageData():String
		{
			var obj:Object=new Object;
			var len:int=PagesData._pagesAry.length;
			obj.pages=[];
			for(var i:int=0;i<len;i++){
				obj.pages.push(getPageData(PagesData._pagesAry[i]));
			}
			trace(JSON.stringify(obj));
			obj.userResources=[];
			len=MainData.myResourcesAry.length;
			for(i=0;i<len;i++){
				obj.userResources.push(MainData.myResourcesAry[i]);
			}
			obj.systemResources=[];
			len=MainData.systemResourcesAry.length;
			
			for(i=0;i<len;i++){
				obj.userResources.push(MainData.systemResourcesAry[i]);
			}
			return JSON.stringify(obj);
		}
		private static function getPageData(page:IBigPage):Array
		{
			var ary:Array=[];
			var len:int=page.resAry.length;
			for(var i:int=0;i<len;i++){
				var obj:Object=new Object;
				var res:IResShow=page.resAry[i];
				switch(res){
					case DocShow:
						obj.type=1;
						break;
					case ImageShow:
						obj.type=2;
						break;
					case SoundShow:
						obj.type=3;
						break;
					case VideoShow:
						obj.type=4;
						break;
					case InputShow:
						obj.type=6;
						break;
					default:
						break;
				}
				
				obj.x=res.x;
				obj.y=res.y;
				obj.index=page.resGroup.getElementIndex(res);
				if(res.isOpen){
					obj.isOpen=1;
				}else{
					obj.isOpen=0;
				}
				obj.property=new Object;
				if(obj.type==6){
					obj.text=InputShow(res)._contentText.text;
					obj.property.size=InputShow(res)._contentText.size;
					obj.property.color=InputShow(res)._contentText.textColor;
					obj.property.italic=InputShow(res)._contentText.italic;
					obj.property.bold=InputShow(res)._contentText.bold;
					obj.proterty.underline=InputShow(res)._contentText.underline;
				}else{
//					obj.code=res.resVo._fileCode;
//					obj.text=res.resVo._name;
					var rect:Rectangle=Group(res).getRect(Group(page))
					obj.property.width=rect.width;
					obj.property.height=rect.height;
				}
				ary.push(obj);
			}
			return ary;
		}
	}
}