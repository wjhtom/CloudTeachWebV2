package net.xuele.utils
{
	import com.hurlant.crypto.symmetric.AESKey;
	import com.hurlant.crypto.symmetric.ECBMode;
	import com.hurlant.util.Hex;
	
	
	import flash.utils.ByteArray;
	
	public class MyCrypto
	{
		public function MyCrypto()
		{
		}
		public static function AESEncode(str:String):String
		{
			if(str==null){
				return null;
			}
			var key:String="xuelezhongguodev"
			var keyByte:ByteArray=new ByteArray;
			keyByte.writeUTFBytes(key);
			var aes:AESKey=new AESKey(keyByte);
			var ecb:ECBMode=new ECBMode(aes);
			
			
			var strByte:ByteArray=new ByteArray;
			strByte.writeUTFBytes(str);//明文转换二进制编码
			ecb.encrypt(strByte);//进行加密
			trace(strByte)
			//			strByte.position=0;
			var enStr:String=Hex.fromArray(strByte);
			return enStr;
		}
		public static function AESDecode(str:String):String
		{
			if(str==null){
				return null
			}
			var key:String="xuelezhongguodev";
			var keyByte:ByteArray=new ByteArray;
			keyByte.writeUTFBytes(key);
			var aes:AESKey=new AESKey(keyByte);
			var ecb:ECBMode=new ECBMode(aes);
			
			var strByte:ByteArray=Hex.toArray(str);
			ecb.decrypt(strByte);
			strByte.position=0;
			var decStr:String=strByte.readUTFBytes(strByte.length);
			return decStr;
		}
	}
}