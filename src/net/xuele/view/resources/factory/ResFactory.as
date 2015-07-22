package net.xuele.view.resources.factory
{
	import flash.display.Sprite;
	
	import net.xuele.utils.PublicOperate;
	import net.xuele.view.resources.interfaces.IResBox;
	import net.xuele.view.resources.interfaces.IResFactory;
	import net.xuele.view.resources.interfaces.IResShow;
	import net.xuele.view.resources.resBox.DragIcon;
	import net.xuele.view.resources.resBox.ResView;
	import net.xuele.view.resources.resShow.DocShow;
	import net.xuele.view.resources.resShow.ImageShow;
	import net.xuele.view.resources.resShow.InputShow;
	import net.xuele.view.resources.resShow.SoundShow;
	import net.xuele.view.resources.resShow.VideoShow;
	import net.xuele.vo.ResourceVo;
	
	import org.flexlite.domUI.components.Group;
	
	public class ResFactory implements IResFactory
	{
		public function ResFactory()
		{
		}
		
		public function createResBox(resVo:ResourceVo):IResBox
		{
			var resBox:IResBox=new ResView(resVo);
			return resBox;
		}
		public function createDragRes(resVo:ResourceVo):IResBox
		{
			var dragView:IResBox=new DragIcon(resVo);
			return dragView;
		}
		public function createResShow(resVo:ResourceVo=null):IResShow
		{
			var res:IResShow;
			if(resVo==null){
				res=new InputShow;
				res.createUI();
				return res;
			}
			resVo._ex="jpg";
			switch(resVo._ex){
				case "png":
				case "jpeg":
				case "bmp":
				case "jpg":
					res=new ImageShow;
					break;
				case "txt":
				case "doc":
				case "docx":
				case "xls":
				case "xlsx":
				case "ppt":
				case "pptx":
				case "pdf":
					res=new DocShow;
					break;
				case "mp3":
				case "wav":
				case "wma":
					res=new SoundShow;
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
					res=new VideoShow;
					break;
				case "swf":
					break;
				default:
					break;
			}
			if(res!=null){
				res.createUI(resVo);
			}
			return res;
		}
		public function removeResBox(domain:Group,res:IResBox):void
		{
			res.removeListener();
			domain.removeElement(res);
		}
		public function removeResShow(domain:Group,res:IResShow):void
		{
			res.removeListener();
			domain.removeElement(res);
		}
	}
}