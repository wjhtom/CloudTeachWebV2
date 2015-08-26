package net.xuele.utils
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import net.xuele.view.blackboard.utils.BlackboarData;
	import net.xuele.view.menu.utils.MenuData;
	import net.xuele.view.pages.interfaces.IBigPage;
	import net.xuele.view.pages.utils.PagesData;
	import net.xuele.view.pages.view.SmallResView;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.FlashShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.view.resources.resShow.InputShow;
	import net.xuele.view.resources.resShow.SoundShow;
	import net.xuele.view.resources.resShow.VideoShow;
	import net.xuele.vo.PropertyVo;
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
		 * 0：鼠标，1：铅笔，2：画直线，3：橡皮，4：文字，5：高亮 ,6:资源内画笔，7：资源内橡皮
		 */
		public static function setMouseType(t:int):void
		{
			MainData._mouseType=t;
			if(MenuData._currentMenu!=null){
				MenuData._currentMenu.gotoAndStop(0);
			}
			if(t==4){
				MenuData._inputMouse.contentMovie.gotoAndStop(1);
			}else{
				MenuData._inputMouse.contentMovie.gotoAndStop(0);
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
			obj.coursewaresName=MainData._coursewaresName;
			obj.bgStyle=BlackboarData.style;
			obj.bgID=BlackboarData.bg;
			obj.pages=[];
			for(var i:int=0;i<len;i++){
				obj.pages.push(getPageData(PagesData._pagesAry[i]));
			}
			
			obj.resources=[];
			len=MainData.myResourcesAry.length;
			for(i=0;i<len;i++){
				var resObj:Object=new Object;
				resObj.ex=MainData.myResourcesAry[i]._ex;
				resObj.fileType=MainData.myResourcesAry[i]._fileType;
				resObj.name=MainData.myResourcesAry[i]._name;
				resObj.fileCode=MainData.myResourcesAry[i]._fileCode;
				obj.resources.push(resObj);
			}
//			obj.systemResources=[];
//			len=MainData.systemResourcesAry.length;
//			
//			for(i=0;i<len;i++){
//				obj.userResources.push(MainData.systemResourcesAry[i]);
//			}
			trace(JSON.stringify(obj));
			return JSON.stringify(obj);
		}
		private static function getPageData(page:IBigPage):Array
		{
			var ary:Array=[];
			var len:int=page.resAry.length;
			for(var i:int=0;i<len;i++){
				var obj:Object=new Object;
				var res:IResShow=page.resAry[i];
				if(res is DocShow){
					obj.type=1;
				}else if(res is ImageShow){
					obj.type=2;
				}else if(res is SoundShow){
					obj.type=3;
				}else if(res is VideoShow){
					obj.type=4;
				}else if(res is FlashShow){
					obj.type=5;
				}else if(res is InputShow){
					obj.type=6;
				}
				
				obj.x=res.x;
				obj.y=res.y;
				obj.index=page.resGroup.getElementIndex(res);
				if(res.isOpen){
					obj.isOpen=1;
				}else{
					obj.isOpen=0;
				}
				var tempAry:Array=page.smallResView.resAry;
				var len1:int=tempAry.length;
				var isSmall:Boolean=false;
				for(var j:int=0;j<len1;j++){
					if(res.resID==IResShow(tempAry[j].resShow).resID){
						obj.place=j;
						isSmall=true;
						break;
					}
				}
				if(!isSmall){
					obj.place=-1;
				}
				obj.property=new Object;
				if(obj.type==6){
					trace("运行第N次")
					obj.text=InputShow(res)._contentText.text;
					obj.property.size=InputShow(res)._contentText.size;
					obj.property.color=InputShow(res)._contentText.textColor;
					obj.property.italic=InputShow(res)._contentText.italic;
					obj.property.bold=InputShow(res)._contentText.bold;
					obj.property.underline=InputShow(res)._contentText.underline;
				}else{
					obj.property.code=res.resVo._fileCode;
					obj.text=res.resVo._name;
					obj.property.fileType=res.resVo._fileType;
					obj.property.ex=res.resVo._ex;
					var rect:Rectangle=Group(res).getRect(Group(page))
					obj.property.width=rect.width;
					obj.property.height=rect.height;
//					obj.property.path=res.resVo._path;
					obj.property.from=res.resVo._from;
					if(res.resVo._from==2){
						obj.property.path=res.resVo._path;
						obj.property.smallImg=res.resVo._smallImgURL;
					}
					
				}
				ary.push(obj);
			}
			return ary;
		}
		/**
		 * 获取文件预览地址 
		 * @param ex
		 * @param filekey
		 * @return 
		 * 
		 */
		public static function getResURL(ex:String,filekey:String):String
		{
			var url:String="";
			ex=ex.toLowerCase();
			switch(ex){
				case "png":
				case "jpeg":
				case "bmp":
				case "jpg":
					url=InterfaceData._downURL+"images/1000x1000_"+filekey+".jpg";
					break;
				case "txt":
				case "doc":
				case "docx":
				case "xls":
				case "xlsx":
				case "ppt":
				case "pptx":
				case "pdf":
					url=InterfaceData._downURL+"files/swf_"+filekey+".swf";
					break;
				case "mp3":
					url=InterfaceData._downURL+"files/"+filekey+".mp3";
					break;
				case "wav":
				case "wma":
					url=InterfaceData._downURL+"files/mp3_"+filekey+".mp3";
					break;
				case "flv":
					url=InterfaceData._downURL+"files/"+filekey+".flv";
					break;
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
					url=InterfaceData._downURL+"files/flv_"+filekey+".flv";
					break;
				case "swf":
					url=InterfaceData._downURL+"files/"+filekey+".swf";
					break;
				default:
					break;
			}
			return url;
		}
		/**
		 * 验证文件是否存在 
		 * @param filekey
		 * @return 
		 * 
		 */
		public static function ExistFile(filekey:String):Boolean
		{
			return false;
		}
	}
}