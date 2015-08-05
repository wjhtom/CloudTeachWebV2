package net.xuele.utils
{

	public class ReadXML
	{
		public function ReadXML()
		{
		}
		public static function readInterfaceXML(xml:XML):void
		{
			InterfaceData._allResourcesURL=xml.Interfaces[0].AllResource[0].@url;
			InterfaceData._teacherEditURL=xml.Interfaces[0].TeacherEdit[0].@url;
			InterfaceData._saveURL=xml.Interfaces[0].SaveURL[0].@url;
			InterfaceData._teacherShareURL=xml.Interfaces[0].TeacherShare [0].@url;
//			InterfaceData._saveURL=xml.Interfaces[0].AutoSave[0].@url;
			InterfaceData._homeworkURL=xml.Interfaces[0].Homework[0].@url;
			InterfaceData._talkworkURL=xml.Interfaces[0].Talkwork[0].@url;
			InterfaceData._teacherClassURL=xml.Interfaces[0].TeacherClass[0].@url;
			InterfaceData._dzkbInfoURL=xml.Interfaces[0].DZKBInfo[0].@url;
			InterfaceData._systemResURL=xml.Interfaces[0].SystemResource[0].@url;
		}
	}
}