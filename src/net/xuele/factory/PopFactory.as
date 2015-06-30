package net.xuele.factory
{
	import net.xuele.commond.CommondView;
	import net.xuele.interfaces.IPop;
	import net.xuele.interfaces.IPopFactory;
	import net.xuele.view.pop.AlertPop;
	import net.xuele.view.loading.factory.LoadingFactory;
	import net.xuele.view.loading.view.LoadingPop;

	public class PopFactory
	{
		public function PopFactory()
		{
		}
		public static function createPop(pop:IPopFactory):void
		{
			var p:IPop;
			if(pop is AlertFactory){
				p=pop.createPop();
				if(p is AlertPop){
					CommondView.popView.addElement(p);
					p.createUI();
				}
			}else if(pop is LoadingFactory){
				p=pop.createPop();
				if(p is LoadingPop){
					CommondView.popView.addElement(p);
					p.horizontalCenter=p.verticalCenter=0;
					p.createUI();
				}
			}
			
		}
		
		public static function unPop(pop:IPop):void
		{
			if(pop){
				CommondView.popView.removeElement(pop);
			}
		}
	}
}