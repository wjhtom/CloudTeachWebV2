package net.xuele.utils
{
	public class GetErrorInfo
	{
		public function GetErrorInfo()
		{
		}
		public static function getInfo(errID:int):String{
			var info:String;
			switch(errID){
				case 1000:
					info="系统内存不足。";
					break;
				case 1001:
					info="未实现方法 _";
					break;
				case 1002:
					info="精度参数必须介于 _ 到 _ 之间；_无效";
					break;
				case 1003:
					info="基数参数必须介于 2 到 36 之间；当前值为 _。";
					break;
				case 1004:
					info="对不兼容的对象调用了方法";
					break;
				case 1005:
					info="数组索引不是正整数";
					break;
				case 1006:
					info="_不是函数";
					break;
				case 1007:
					info="尝试实例化的函数不是构造函数。";
					break;
				case 1008:
					info="_有歧义；找到多个匹配的绑定";
					break;
				case 1009:
					info="无法访问空对象引用的属性或方法。";
					break;
				case 1010:
					info="术语未经定义且没有属性";
					break;
				case 1011:
					info=" 方法 _ 在偏移 _ 处包含非法的 opcode _";
					break;
				case 1012:
					info="最后一条指令超过了代码大小";
					break;
				case 1013:
					info="scopeDepth 为 0 时，无法调用 OP_findproperty";
					break;
				case 1014:
					info="无法找到 _ 类";
					break;
				case 1015:
					info="方法 _ 无法设置默认的 xml 命名空间";
					break;
				case 1016:
					info="类型 _ 不支持后代运算符 ";
					break;
				case 1017:
					info="";
					break;
				case 1018:
					info="";
					break;
				case 1019:
					info="";
					break;
				case 1020:
					info="";
					break;
				case 1021:
					info="";
					break;
				case 1022:
					info="";
					break;
				case 1023:
					info="";
					break;
				case 1024:
					info="";
					break;
				case 1025:
					info="";
					break;
				case 1026:
					info="";
					break;
				case 1027:
					info="";
					break;
				case 1028:
					info="";
					break;
				case 1029:
					info="";
					break;
				case 1030:
					info="";
					break;
				case 1031:
					info="";
					break;
				case 1032:
					info="";
					break;
				case 1033:
					info="";
					break;
				case 1034:
					info="";
					break;
				case 1035:
					info="";
					break;
				case 1036:
					info="";
					break;
				case 1037:
					info="";
					break;
				case 1038:
					info="";
					break;
				case 1039:
					info="";
					break;
				case 1040:
					info="";
					break;
				case 1041:
					info="";
					break;
				case 1042:
					info="";
					break;
				case 1043:
					info="";
					break;
				case 1044:
					info="";
					break;
				case 1045:
					info="";
					break;
				case 1046:
					info="";
					break;
				case 1047:
					info="";
					break;
				case 1048:
					info="";
					break;
				case 1049:
					info="";
					break;
				case 1050:
					info="";
					break;
				case 1051:
					info="";
					break;
				case 1052:
					info="";
					break;
				case 1053:
					info="";
					break;
				case 1054:
					info="";
					break;
				case 1055:
					info="";
					break;
				case 1056:
					info="";
					break;
				case 1057:
					info="";
					break;
				case 1058:
					info="";
					break;
				case 1059:
					info="";
					break;
				case 1060:
					info="";
					break;
				case 1061:
					info="";
					break;
				case 1062:
					info="";
					break;
				case 1063:
					info="";
					break;
				case 1064:
					info="";
					break;
				case 1065:
					info="";
					break;
				case 1066:
					info="";
					break;
				case 1067:
					info="";
					break;
				case 1068:
					info="";
					break;
				case 1069:
					info="";
					break;
				case 1070:
					info="";
					break;
				case 1071:
					info="";
					break;
				case 1072:
					info="";
					break;
				case 1073:
					info="";
					break;
				case 1074:
					info="";
					break;
				case 1075:
					info="";
					break;
				case 1076:
					info="";
					break;
				case 1077:
					info="";
					break;
				case 1078:
					info="";
					break;
				case 1079:
					info="";
					break;
				case 1080:
					info="";
					break;
				case 1081:
					info="";
					break;
				case 1082:
					info="";
					break;
				case 1083:
					info="";
					break;
				case 1084:
					info="";
					break;
				case 1085:
					info="";
					break;
				case 1086:
					info="";
					break;
				case 1087:
					info="";
					break;
				case 1088:
					info="";
					break;
				case 1089:
					info="";
					break;
				case 1090:
					info="";
					break;
				case 1091:
					info="";
					break;
				case 1092:
					info="";
					break;
				case 1093:
					info="";
					break;
				case 1094:
					info="";
					break;
				case 1095:
					info="";
					break;
				case 1096:
					info="";
					break;
				case 1097:
					info="";
					break;
				case 1098:
					info="";
					break;
				case 1100:
					info="";
					break;
				case 1101:
					info="";
					break;
				case 1102:
					info="";
					break;
				case 1103:
					info="";
					break;
				case 1104:
					info="";
					break;
				case 1105:
					info="";
					break;
				case 1106:
					info="";
					break;
				case 1107:
					info="";
					break;
				case 1108:
					info="";
					break;
				case 1109:
					info="";
					break;
				case 1110:
					info="";
					break;
				case 1111:
					info="";
					break;
				case 1112:
					info="";
					break;
				case 1113:
					info="";
					break;
				case 1114:
					info="";
					break;
				case 1115:
					info="";
					break;
				case 1116:
					info="";
					break;
				case 1117:
					info="";
					break;
				case 1118:
					info="";
					break;
				case 1119:
					info="";
					break;
				case 1120:
					info="";
					break;
				case 1121:
					info="";
					break;
				case 1122:
					info="";
					break;
				case 1123:
					info="";
					break;
				case 1124:
					info="";
					break;
				case 1502:
					info="";
					break;
				case 1503:
					info="";
					break;
				case 1507:
					info="";
					break;
				case 1508:
					info="";
					break;
				case 1510:
					info="";
					break;
				case 2000:
					info="";
					break;
				case 2001:
					info="";
					break;
				case 2002:
					info="";
					break;
				case 2003:
					info="";
					break;
				case 2004:
					info="";
					break;
				case 2005:
					info="";
					break;
				case 2006:
					info="";
					break;
				case 2007:
					info="";
					break;
				case 2008:
					info="";
					break;
				case 2009:
					info="";
					break;
				case 2010:
					info="";
					break;
				case 2011:
					info="";
					break;
				case 2012:
					info="";
					break;
				case 2013:
					info="";
					break;
				case 2014:
					info="";
					break;
				case 2015:
					info="";
					break;
				case 2016:
					info="";
					break;
				case 2017:
					info="";
					break;
				case 2018:
					info="";
					break;
				case 2019:
					info="";
					break;
				case 2020:
					info="";
					break;
				case 2021:
					info="";
					break;
				case 2022:
					info="";
					break;
				case 2023:
					info="";
					break;
				case 2024:
					info="";
					break;
				case 2025:
					info="";
					break;
				case 2026:
					info="";
					break;
				case 2027:
					info="";
					break;
				case 2028:
					info="";
					break;
				case 2029:
					info="";
					break;
				case 2030:
					info="";
					break;
				case 2031:
					info="";
					break;
				case 2032:
					info="";
					break;
				case 2033:
					info="";
					break;
				case 2034:
					info="";
					break;
				case 2035:
					info="";
					break;
				case 2036:
					info="";
					break;
				case 2037:
					info="";
					break;
				case 2038:
					info="";
					break;
				case 2039:
					info="";
					break;
				case 2040:
					info="";
					break;
				case 2041:
					info="";
					break;
				case 2042:
					info="";
					break;
				case 2043:
					info="";
					break;
				case 2044:
					info="";
					break;
				case 2045:
					info="";
					break;
				case 2046:
					info="";
					break;
				case 2047:
					info="";
					break;
				case 2048:
					info="";
					break;
				case 2049:
					info="";
					break;
				case 2050:
					info="";
					break;
				case 2051:
					info="";
					break;
				case 2052:
					info="";
					break;
				case 2053:
					info="";
					break;
				case 2054:
					info="";
					break;
				case 2055:
					info="";
					break;
				case 2056:
					info="";
					break;
				case 2057:
					info="";
					break;
				case 2058:
					info="";
					break;
				case 2059:
					info="";
					break;
				case 2060:
					info="";
					break;
				case 2061:
					info="";
					break;
				case 2062:
					info="";
					break;
				case 2063:
					info="";
					break;
				case 2064:
					info="";
					break;
				case 2065:
					info="";
					break;
				case 2066:
					info="";
					break;
				case 2067:
					info="";
					break;
				case 2068:
					info="";
					break;
				case 2069:
					info="";
					break;
				case 2070:
					info="";
					break;
				case 2071:
					info="";
					break;
				case 2072:
					info="";
					break;
				case 2073:
					info="";
					break;
				case 2074:
					info="";
					break;
				case 2075:
					info="";
					break;
				case 2076:
					info="";
					break;
				case 2077:
					info="";
					break;
				case 2078:
					info="";
					break;
				case 2079:
					info="";
					break;
				case 2080:
					info="";
					break;
				case 2081:
					info="";
					break;
				case 2082:
					info="";
					break;
				case 2083:
					info="";
					break;
				case 2084:
					info="";
					break;
				case 2085:
					info="";
					break;
				case 2086:
					info="";
					break;
				case 2087:
					info="";
					break;
				case 2088:
					info="";
					break;
				case 2089:
					info="";
					break;
				case 2090:
					info="";
					break;
				case 2091:
					info="";
					break;
				case 2092:
					info="";
					break;
				case 2093:
					info="";
					break;
				case 2094:
					info="";
					break;
				case 2095:
					info="";
					break;
				case 2096:
					info="";
					break;
				case 2097:
					info="";
					break;
				case 2098:
					info="";
					break;
				case 2099:
					info="";
					break;
				case 2100:
					info="";
					break;
				case 2101:
					info="";
					break;
				case 2102:
					info="";
					break;
				case 2103:
					info="";
					break;
				case 2104:
					info="";
					break;
				case 2105:
					info="";
					break;
				case 2106:
					info="";
					break;
				case 2107:
					info="";
					break;
				case 2108:
					info="";
					break;
				case 2109:
					info="";
					break;
				case 2110:
					info="";
					break;
				case 2111:
					info="";
					break;
				case 2112:
					info="";
					break;
				case 2113:
					info="";
					break;
				case 2114:
					info="";
					break;
				case 2115:
					info="";
					break;
				case 2116:
					info="";
					break;
				case 2117:
					info="";
					break;
				case 2118:
					info="";
					break;
				case 2119:
					info="";
					break;
				case 2120:
					info="";
					break;
				case 2121:
					info="";
					break;
				case 2123:
					info="";
					break;
				case 2124:
					info="";
					break;
				case 2125:
					info="";
					break;
				case 2126:
					info="";
					break;
				case 2127:
					info="";
					break;
				case 2128:
					info="";
					break;
				case 2129:
					info="";
					break;
				case 2130:
					info="";
					break;
				case 2131:
					info="";
					break;
				case 2132:
					info="";
					break;
				case 2133:
					info="";
					break;
				case 2134:
					info="";
					break;
				case 2135:
					info="";
					break;
				case 2136:
					info="";
					break;
				case 2137:
					info="";
					break;
				case 2138:
					info="";
					break;
				case 2139:
					info="";
					break;
				case 2140:
					info="";
					break;
				case 2141:
					info="";
					break;
				case 2142:
					info="";
					break;
				case 2143:
					info="";
					break;
				case 2144:
					info="";
					break;
				case 2145:
					info="";
					break;
				case 2146:
					info="";
					break;
				case 2147:
					info="";
					break;
				case 2148:
					info="";
					break;
				case 2149:
					info="";
					break;
				case 2150:
					info="";
					break;
				case 2151:
					info="";
					break;
				case 2152:
					info="";
					break;
				case 2153:
					info="";
					break;
				default:
					info="其他错误。";
					break;
			}
			return info;
		}
	}
}
/*************************************************************************************
 1000 系统内存不足。 系统可用内存无法满足 Flash Player 编译代码的需要。请关闭系统上正在运行的某些应用程序或进程。  
1001 未实现方法 _。  
1002 Number.toPrecision 的范围是 1 至 21。Number.toFixed 和 Number.toExponential 的范围是 0 至 20。指定的值不在期望范围之内。 指定的值不在 precision 参数的期望范围之内。Number.toPrecision 的范围是 1 至 21。Number.toFixed 和 Number.toExponential 的范围是 0 至 20。  
1003 radix 参数必须介于 2 至 36 之间；得到 _。 为方法或属性的 radix 参数传递的值小于 2 或大于 36。请传递一个介于 2 至 36 之间的值作为 radix 参数。  
1004 对不兼容的对象调用方法 _。 尝试调用的方法不适用于指定对象。如果已将原型函数从一个对象复制到另一个对象然后又调用此函数，但目标对象类型与原始对象类型不同，则会发生此错误。请确保目标对象与原始对象的类型相同。有关详细信息，请参阅 ECMAScript Language Specification（《ECMAScript 语言规范》）第 3 版中的第 15 章。  
1005 数组索引不是正整数 (_)。 尝试使用非正整数的索引值访问数组成员。仅传递正整数作为数组的索引值。  
1006 _ 不是函数。 尝试调用不存在的函数时，发生此错误。请确保正在调用正确的函数且自 ActionScript 2.0 以来此 API 尚未发生更改。此外，请确保正在使用正确的对象。例如，使用以下代码时，将出现此错误（由于最后一行错误调用了变量 big 而未调用变量 blg）： 
var blg:String = "foo"; 
var big:Sprite = new Sprite(); 
var error:int = big.length();  
1007 尝试对非构造函数进行实例化。  
1008 _ 指代不明确；发现多个匹配的绑定。  
1009 无法访问空对象引用的属性或方法。 计算结果为 null 的对象可以不包含任何属性。在某些意外（尽管有效）的情况下，可能发生此错误。以创建 Sprite 对象的以下代码为例。由于从未将此 Sprite 对象添加到显示列表中（使用 DisplayObjectContainer 对象的 addChild() 方法），因此其 stage 属性设置为 null。在这种情况下，此示例将生成此错误，这是因为 Sprite 对象的 stage 属性不能拥有任何属性：
import flash.display.Sprite; 
var sprite1:Sprite = new Sprite(); 
var q:String = sprite1.stage.quality; 
1010 术语未经定义且没有属性。 如果尝试访问并不存在的对象的属性，将发生此错误。例如： 
var obj:Object = new Object(); 
obj.a = "foo"; 
trace(obj.b.prop);由于拼写错误也可能产生此错误，在下面的示例中，mc 表示显示列表中的 MovieClip 对象，stage 属性中的小写字母 s 被错误地拼写为大写字母 S（应该为 stage）：trace(mc.Stage.quality); 
1011 方法 _ 在偏移 _ 处包含非法的 opcode _。 请参见此表底部的注意。*  
1012 最后一条指令超过了代码大小。 请参见此表底部的注意。*  
1013 scopeDepth 为 0 时，无法调用 OP_findproperty。 请参见此表底部的注意。*  
1014 无法找到 _ 类。  
1015 方法 _ 无法设置默认的 xml 命名空间 请参见此表底部的注意。*  
1016 类型 _ 不支持后代运算符 (..)。  
1017 发生作用域堆栈上溢。 请参见此表底部的注意。*  
1018 发生作用域堆栈下溢。 请参见此表底部的注意。*  
1019 Getscopeobject _ 超出范围。 请参见此表底部的注意。*  
1020 代码无法脱离某个方法的结尾。 请参见此表底部的注意。*  
1021 方法中至少有一个分支目标未在有效指令中。 请参见此表底部的注意。*  
1022 void 类型只能用作函数返回类型。 请参见此表底部的注意。*  
1023 发生堆栈上溢。 请参见此表底部的注意。*  
1024 发生堆栈下溢。 请参见此表底部的注意。*  
1025 访问了无效的寄存器 _。 请参见此表底部的注意。*  
1026 插槽 _ 超出 _ 的 slotCount=_。 请参见此表底部的注意。*  
1027 Method_info _ 超出 method_count=_。 请参见此表底部的注意。*  
1028 Disp_id _ 超过 _ 的 max_disp_id=_。 请参见此表底部的注意。*  
1029 未在 _ 中定义 Disp_id _。 请参见此表底部的注意。*  
1030 堆栈深度不平衡。 _ != _. 请参见此表底部的注意。*  
1031 作用域深度不平衡。 _ != _. 请参见此表底部的注意。*  
1032 Cpool 索引 _ 超出范围 _。 请参见此表底部的注意。*  
1033 Cpool 条目 _ 类型错误。 请参见此表底部的注意。*  
1034 类型强制失败：无法将 _ 转换为 _。  
1035 方法 _ 中存在非法的超级表达式。 请参见此表底部的注意。*  
1037 无法分配到 _ 上的方法 _。 请参见此表底部的注意。*  
1038 已定义 _。 在同一作用域内，不能多次声明具有同一标识符名称的变量或函数。在 ActionScript 3.0 中，不同的代码块（如用于同一 function 定义中的两个 for 循环中的代码块）将被视为在同一作用域内。请参见此表底部的注意。*  
1039 引用方法后才可以对其进行验证。 请参见此表底部的注意。*  
1040 instanceof 的右侧必须为类或函数。 instanceof 运算符右侧的表达式必须为类或函数。  
1041 运算符的右侧必须为类。 is 运算符右侧的表达式必须为类。  
1042 不是 ABC 文件。major_version=_ minor_version=_。 使用播放器尝试播放的文件无效：用于生成此 SWF 的工具可能已过期，或此 SWF 本身可能已损坏。  
1043 code_length=_ 无效。 请参见此表底部的注意。*  
1044 MethodInfo-_ 不支持 flags=_。 请参见此表底部的注意。*  
1045 不支持 traits kind=_。 请参见此表底部的注意。*  
1046 定义前引用 MethodInfo-_。 请参见此表底部的注意。*  
1047 未找到入口点。 请参见此表底部的注意。*  
1049 原型对象必须为 vanilla 对象。 请参见此表底部的注意。*  
1050 无法将 _ 转换为原始类型。 请参见此表底部的注意。*  
1051 非法早期绑定访问 _。 请参见此表底部的注意。*  
1052 传递给 _ 函数的 URI 无效。 请参见此表底部的注意。*  
1053 在 _ 中非法覆盖 _。 请参见此表底部的注意。*  
1054 异常处理函数中的非法范围或目标偏移。 请参见此表底部的注意。*  
1056 无法在 _ 上创建属性 _。 正在尝试为非动态类实例中不存在的属性赋值。此操作仅适用于动态类的实例。 
1057 _ 中只能包含方法。 请参见此表底部的注意。*  
1058 非法操作数类型：_ 必须为 _。 请参见此表底部的注意。*  
1059 定义前引用 ClassInfo-_。 请参见此表底部的注意。*  
1060 ClassInfo _ 超过 class_count=_。 请参见此表底部的注意。*
 * 1061 将值 _ 转换为 _ 时会损失精度。 如果尝试将小数赋给数据类型为 int 的属性，将出现此错误。 
如果赋值超出范围，也会出现此错误，如下所示： 

var m0:int = 2147483648; // int.MAX_VALUE == 2147483647使用按位向左移位运算符 (<<) 时，也会出现此错误。例如，请考虑以下代码： 

var m0:uint = 0xFF; 
var m1:uint = m0<<24;向左移位运算符 (<<) 的结果解释为 32 位带符号的 2 的补码数。在本示例中，结果为负值，将此结果赋予 uint 类型的属性时，将发生错误。解决方法如下所示： 

var m0:uint = 0xFF; 
var m1:uint = uint(m0<<24); 
1063 _ 中的参数数量不匹配。预期为 _，实际得到 _。  
1064 无法将方法 _ 作为构造函数调用。 将提取的方法永久地绑定到提取这些方法的对象中。因此，以后不能将这些方法作为构造函数进行调用。例如，下面的代码将在类 A 中创建函数 f()： 
class A { 
  function f() {} 
}在以下代码中，提取此函数将不会产生错误。但创建此函数的新实例将产生错误。 Webjx_com
var a = new A() 
var m = a.f // extract f, don't call it 
m() // same as a.f() 
new m() // causes this error 
1065 未定义变量 _。 您所使用的词汇引用未定义。例如，在以下语句中，由于未定义 x，trace(x) 语句将生成错误。但是，由于定义了 y，因此 trace(y) 语句不会生成错误： 
trace("hello world") 
trace(x) // x is undefined 
var y 
trace(y) // No error, y is defined. 
1066 不支持表单函数（“函数体”）。 与 JavaScript 不同，Flash 不使用 eval() 和 function() 动态编译代码。因此，在 ActionScript 3.0 中将其作为构造函数进行调用将生成此错误。  
1067 本机方法 _ 中包含非法的方法体。 请参见此表底部的注意。*  
1068 无法协调 _ 和 _。 请参见此表底部的注意。*  
1069 属性 _ 在 _ 上找不到，没有默认值。 在非动态类实例中引用了未定义的属性。例如，当以下代码引用未定义且不能动态创建的 x 属性时，将生成此错误： 
class A {} // sealed class, not dynamic 
trace(new A().x) // no property x defined on A, and A is not dynamic 
1070 未在 _ 上找到方法 _。 正在使用 super 语句调用函数，但超类中不存在该函数。例如，以下代码将生成此错误： 
class A() {} 
class B extends A { 
function f() { trace(super.f()); } // error 1070, there is no f on A 
} 
1071 已将函数 _ 绑定到 _。  
1072 Disp_id 0 是非法的。 请参见此表底部的注意。*  
1073 由于出现重复的 disp_id _，因此已替换非覆盖方法 _。 请参见此表底部的注意。*  
1074 在 _ 上非法写入只读属性 _。  
1075 Math 不是函数。 正在尝试将 math() 作为函数进行调用，但 Math 是具有静态方法的类。  
1076 Math 不是构造函数。 无法实例化 Math 类。  webjx-Com
1077 在 _ 上非法读取只写属性 _。  
1078 非法的 opcode/multiname 组合：_<_>。 请参见此表底部的注意。*  
1079 不允许在加载代码中使用本机方法。 请参见此表底部的注意。*  
1080 命名空间的值是非法的。 请参见此表底部的注意。*  
1081 属性 _ 在 _ 上找不到，没有默认值。  
1082 尚未设置默认的命名空间。 请参见此表底部的注意。*  
1083 未绑定元素“_”的前缀“_”。 属性名称或元素名称具有前缀，但未找到匹配的命名空间。由于没有与 foo:x 匹配的 foo 命名空间，因此此语句生成错误： 
<foo:x xmlns:clowns='http://circuscenter.org'> 
1084 元素或属性 ("_") 与 QName 生成不匹配：QName::=(NCName':')?NCName。 将 foo: 或 :foo 用作元素或属性名称，但是冒号的另一侧没有内容。  
1085 必须由相匹配的结束标签“</_>”终止元素类型“_”。  
1086 方法 _ 仅作用于包含一个项的列表 如果 XMLList 类的列表中仅包含一个项，则此类将特定于 XML 的函数传播到它的一个子类。如果此列表中包含多个项，则例程会因此错误而失败。以下模拟 XML 函数的 XMLList 函数会发生此错误： 
addNamespace、appendChild、childIndex、inScopeNamespaces、insertChildAfter、insertChildBefore, name、namespace、localName、namespaceDeclarations、nodeKind、prependChild、removeNamespace、replace、setChildren、setLocalName、setName 和 setNamespace。
1087 禁止为已建立索引的 XML 赋值。  
1088 文档中根元素后面的标记的格式必须正确。 下面为可能产生此错误的原因： 
将 XMLList 样式对象作为 XML 进行分析 
字符串未均衡 

1089 不支持向包含多个项的列表赋值。  
1090 XML 分析器失败：元素格式不正确。 元素名称格式不正确。此示例中的元素名称格式不正确，因为结尾处的右尖括号 > 丢失： 
<a/><b></b 
1091 XML 分析器失败：CDATA 部分未结束。  
1092 XML 分析器失败：XML 声明未结束。  
1093 XML 分析器失败：DOCTYPE 声明未结束。  
1094 XML 分析器失败：注释未结束。  
1095 XML 分析器失败：属性未结束。  
1096 XML 分析器失败：元素未结束。  webjx.com
1097 XML 分析器失败：指令处理未结束。  
1098 用于无命名空间的前缀 _ 非法。 如果尝试传入具有非空前缀的空 URI，此命名空间构造函数将引发此错误，如本例所示： 
ns = new Namespace ("prefix", ""); 

1100 从一个 RegExp 构造另一个 RegExp 时，无法提供标志。 由现有的正则表达式创建新的正则表达式时，也会复制现有表达式的标志。如要创建具有不同标志的正则表达式，请使用 new 运算符并按照需要设置标志。例如，此语句创建正则表达式并指定标志设置： 
var re:RegExp = new RegExp("ali", /s)此语句也可以创建与 re 具有相同标志的正则表达式： 
var re2:RegExp = new RegExp(re, ...) 
1101 无法验证具有未知作用域的方法 _。 请参见此表底部的注意。*  
1102 类型 _ 的默认值是非法的。 请参见此表底部的注意。*  
1103 _ 类不能扩展最终基类。 请参见此表底部的注意。*  
1104 已为元素“_”指定属性“_”。  
1107 ABC 数据已损坏，系统尝试读取范围以外的数据。 请参见此表底部的注意。*  
1108 OP_newclass opcode 用于错误的基类。 请参见此表底部的注意。*  
1109 尝试从方法 _ 中直接调用未限定范围的函数 _。 请参见此表底部的注意。*  
1110 _ 不能扩展 _。 请参见此表底部的注意。*  
1111 _ 不能实现 _。 请参见此表底部的注意。*  
1112 类强制中的参数数量不匹配。预期为 1，实际得到 _。  
1113 OP_newactivation 用于没有 NEED_ACTIVATION 标志的方法中。 请参见此表底部的注意。*  
1114 OP_getglobalslot 或 OP_setglobalslot 未用于全局作用域。 请参见此表底部的注意。*  
1115 _ 不是构造函数。  
1116 Function.prototype.apply 的第二个参数必须为数组。  
1117 XML 名称无效：_。  
1118 节点之间的循环体是非法的。  
1119 类型 _ 的操作数不支持删除运算符。  
1120 无法在 _ 上删除属性 _。  
1121 方法 _ 存在重复的方法体。  
1122 接口方法 _ 包含非法的方法体。  
1123 类型 _ 不支持过滤运算符。  
1124 OP_hasnext2 要求对象和索引使用不同的寄存器。  
1502 脚本的执行时间大于 15 秒的默认超时期间。 超时期间过后执行脚本。（默认超时期间为 15 秒。）发生此错误后，脚本可以继续执行 15 秒，然后将终止脚本并引发编号为 1503 的运行时错误（脚本在 30 秒内未能退出，终止其执行）。  
1503 30 秒后脚本未能退出，终止执行。 30 秒后仍然继续执行此脚本。如果此脚本的执行时间超过 15 秒（即默认的超时期间），Flash Player 将首先引发编号为 1502 的运行时错误（脚本的执行时间超过 15 秒的默认超时期间）。错误 1502 发生 15 秒后，发生此错误。  webjx.com
1507 参数 _ 不能为 null。  
1508 为参数 _ 指定的值无效。 您可能正在尝试传递错误的数据类型。例如，代码 
public function doSomething(const:int):void { 
} 
this ["doSomething"] ("str")在运行时将生成错误，原因是将 doSomething 转换为 int 数据类型。  
1510 当回调参数为某个类的方法时，此可选参数必须为 null。  
2000 没有活动的安全上下文。  
2001 指定的参数太少；实际得到 _，预期为 _。  
2002 尝试对无效的套接字进行操作。  
2003 指定的套接字端口号无效。   有效范围介于 0 到 65535 之间。有关详细信息，请参阅本语言参考中的“套接字连接”。   
2004 其中一个参数无效。  
2005 参数 _ 的类型错误。应为类型 _。  
2006 提供的索引超出范围。  
2007 参数 _ 必须为非空值。  
2008 参数 _ 必须为可接受值之一。  
2009 此方法不能用于具有样式表的文本字段。  
2010 不允许只能与本地文件系统的内容交互的 SWF 文件使用套接字。  
2011 到 _:_ 的套接字连接失败。   存在网络问题。可能是由于未解析 DNS 名称或未连接 TCP 套接字。   
2012 无法实例化 _ 类。  
2013 仅可用于 Flash 创作的功能。  
2014 此时不可用的功能。   本系统不支持此功能。   
2015 BitmapData 无效。  
2017 只有受信任的本地文件可能会导致 Flash Player 退出。  
2018 System.exit 仅在独立的 Flash Player 中可用。  
2019 指定的深度无效。  
2020 无法交换具有不同父级的 MovieClips 对象。  
2021 对象创建失败。  
2022 必须从 DisplayObject 继承 _ 类以链接到元件。  
2023 必须从 Sprite 继承 _ 类以链接到根。  
2024 无法将对象作为其自身的子级进行添加。  
2025 所提供的 DisplayObject 必须为调用方的子级。  
2026 导航至 URL _ 时发生错误。   可能的原因是此 URL 不存在、网络连接有问题或者 URL 在安全沙箱之外。   
2027 参数 _ 必须是非负数；得到 _。  
2028 只能与本地文件系统的内容交互的 SWF 文件 _ 无法访问 Internet URL _。  
2029 此 URLStream 对象没有已打开的流。  
2030 到达文件末尾。  
2031 套接字错误。   发生套接字错误。有关详细信息，请参阅本语言参考中的“套接字连接”。   
2032 流错误。  
2033 键生成失败。  
2035 没有找到 URL。  
2036 加载从未完成。  
2037 函数的调用顺序不正确，或者之前的调用未成功。  
2038 文件 I/O 错误。  
2039 远程 URL 协议无效。远程 URL 协议必须是 HTTP 或 HTTPS。  
2041 一次只能执行一个文件浏览会话。  
2044 未处理 _:。  
2047 安全沙箱侵犯：_:_ 无法访问 _。  
2048 安全沙箱侵犯：_ 无法从 _ 加载数据。  
2049 安全沙箱侵犯：_ 无法将数据上载至 _。  
2051 安全沙箱侵犯：_ 无法在 _ 中计算脚本 URL（allowScriptAccess 为 _）。尝试的 URL 是 _。  
2052 仅允许对 allowDomain 和 allowInsecureDomain 使用 String 参数。  
2053 安全沙箱侵犯：_ 无法清除由 _ 设置的间隔计时器。  
2054 使用过的 Security.exactSettings 的值无法进行更改。  
2055 无法启动打印作业。  
2056 无法将打印作业发送到打印机。  
2057 无法将页面添加至打印作业中。   未正确使用 addPage() 方法。请参阅此语言参考中的 addPage() 条目。
2058 解压缩数据时出错。  
2059 安全沙箱侵犯：_ 无法覆盖由 _ 添加的 ExternalInterface 回调。  
2060 安全沙箱侵犯：ExternalInterface 调用方 _ 无法访问 _。  
2061 没有注册 ExternalInterface 回调 _。  
2062 Event 的子级必须覆盖 clone() {return new MyEventClass (...);}。  
2063 尝试执行 IME 命令时发生错误。   一个 IME 服务失败。  
  
若使用的是 setConversionMode() 或 setEnabled() 方法，则 ActionScript 3.0 用 access 属性替换这些方法。  
若使用的是 doConversion() 或 setComposition()   方法，则上述方法不受 Macintosh OSX 和 Macintosh Classic 支持。  
   
2065 无法为此目标设置焦点。  
2066 指定的计时器延迟超出范围。  
2067 在此容器中 ExternalInterface 不可用。ExternalInterface 需要 Internet Explorer ActiveX、Firefox、Mozilla 1.7.5 及更高版本，或支持 NPRuntime 的其它浏览器。  
2068 声音无效。  
2069 Loader 类未实现此方法。  
2070 安全沙箱侵犯：调用方 _ 无法访问属于 _ 的 Stage。  
2071 Stage 类未实现此属性或方法。  
2074 舞台太小，不适合下载 UI。  
2075 已下载的文件无效。   可能的原因是文件解压缩失败、文件格式无效或签名验证失败。    
2077 无法使用指定的输入参数执行此滤镜操作。  
2078 无法修改时间轴上所放置的对象的名称属性。  
2079 由 Bitmap 派生的类只能与 defineBits 字符（位图）相关联。  
2082 连接失败，因为对象已连接。  
2083 关闭失败，因为对象未连接。  
2084 参数的 AMF 编码不能超过 40K。  
2085 参数 _ 必须为非空字符串。  
2086 mms.cfg 文件中的设置禁止此 FileReference 请求。  
2087 FileReference.download() 文件名中包含禁用字符。   文件名不能包含空格或以下任何字符：  
2088 Proxy 类未实现 getProperty。必须由子类覆盖。  
2089 Proxy 类未实现 setProperty。必须由子类覆盖。  
2090 Proxy 类未实现 callProperty。必须由子类覆盖。  
2091 Proxy 类未实现 hasProperty。必须由子类覆盖。  
2092 Proxy 类未实现 deleteProperty。必须由子类覆盖。  
2093 Proxy 类未实现 getDescendants。必须由子类覆盖。  
2094 事件调度递归溢出。   递归超过最大递归深度。（默认的最大递归深度为 256。）   
2095 _ 无法调用回调 _。  
2096 无法通过 ActionScript 设置 HTTP 请求标头 _。   您正在将一个禁用的 HTTP 标头添加到 HTTP 请求中。禁止使用以下标头： 
NULL 标头字符串 
Accept-Charset 
Accept-Encoding 
Accept-Ranges 
Age 
Allow 
Allowed 
Connection 
Content-Length 
Content-Location 
Content-Range 
Date 
ETag 
Expect 
Host 
Keep-Alive 
Last-Modified 
Location 
Max-Forwards 
Proxy-Authenticate 
Proxy-Authorization 
Public 
Range 
Referer 
Retry-After 
Server 
TE 
Trailer 
Transfer-Encoding 
Upgrade 
URI 
User-Agent 
Vary 
Via 
Warning 
WWW-Authenticate 
x-flash-version 
    
2097 FileFilter 数组的格式不正确。   存在两种有效格式：  
  
只包含 Windows 文件扩展名的说明  
包含 Windows 文件扩展名和 Macintosh 文件格式的说明。  
  
这两种文件格式不能互换；您只能使用其中的一种。  有关详细信息，请参阅本语言参考中的 FileFilter 类。    

2098 正在加载的对象不是 .swf 文件，因此无法从该文件请求 SWF 属性。  
2099 正在加载的对象未充分加载，无法提供此信息。  
2100 Loader.loadBytes() 中 ByteArray 参数的长度必须大于 0。  
2101 传递给 URLVariables.decode() 的字符串必须是包含名称/值对的经 URL 编码的查询字符串。  
2102 XMLNode 之前的参数必须是调用方的子级。  
2103 XML 递归失败：新子级将创建无限循环。   可能是由于您正在尝试使对象互为子对象。例如，以下代码会生成此错误，因为 a 和 b 都在尝试将对方添加为子对象。  
a.addChild(b); .addChild(a);   
2105 Proxy 类未实现 nextNameIndex。必须由子类覆盖。  
2106 Proxy 类未实现 nextName。必须由子类覆盖。  
2107 Proxy 类未实现 nextValue。必须由子类覆盖。  
2108 没有找到场景 _。  
2109 在场景 _ 中找不到帧标签 _。  
2110 只有调用方可以访问舞台并且位于 ActionScript 3.0 SWF 文件中时，才能设置 Security.disableAVM1Loading 的值。  
2111 Security.disableAVM1Loading 为 true，因此已阻止当前对 ActionScript 1.0/2.0 SWF 文件的加载。  
2112 假设 LoaderContext.ApplicationDomain 参数来自一个禁用的域。  
2113 假设 LoaderContext.SecurityDomain 参数来自一个禁用的域。  
2114 参数 _ 必须为 null。  
2115 参数 _ 必须为 false。  
2116 参数 _ 必须为 true。  
2118 LoaderInfo 类未实现此方法。  
2119 安全沙箱侵犯：调用方 _ 不能访问属于 _ 的 LoaderInfo.applicationDomain。  
2121 安全沙箱侵犯：_:_ 不能访问 _。可以通过调用 Security.allowDomain 来解决此问题。  
2122 安全沙箱侵犯：_:_ 不能访问 _。需要策略文件，但加载此媒体时未设置 checkPolicyFile 标志。  
2123 安全沙箱侵犯：_:_ 不能访问 _。没有授予访问权限的策略文件。  
2124 已加载文件的类型未知。  
2125 安全沙箱侵犯：_ 不能使用运行时共享库 _，因为不允许在 ActionScript 3.0 和 ActionScript 1.0/2.0 对象之间跨越边界。  
2126 必须连接 NetConnection 对象。  
2127 FileReference POST 的数据类型不能是 ByteArray。  
2129 连接到 _ 失败。  
2130 无法刷新 SharedObject。  
2131 无法找到定义 _。  
2132 无法通过 netStatus 事件处理函数调用 NetConnection.connect。  
2133 未注册回调 _。  
2134 无法创建 SharedObject。  
2135 安全沙箱侵犯：_:_ 不能访问 _。无法使用此 API 访问 RTMP 内容。  
2136 SWF 文件 _ 中包含无效数据。  
2137 安全沙箱侵犯：_ 不能在 _ 中导航窗口 _（allowScriptAccess 为 _）。尝试的 URL 是 _。  
2138 无法解析丰富文本 XML。  
2139 无法连接 SharedObject。  
2140 安全沙箱侵犯：_ 不能加载 _。只能与本地文件系统的内容交互的 SWF 文件和只能与远程内容交互的 SWF 文件不能互相加载。  
2141 一次只可能处理一个 PrintJob。  
2142 安全沙箱侵犯：本地 SWF 文件不能使用 LoaderContext.securityDomain 属性。_ 正在尝试加载 _。  
2143 AccessibilityImplementation.get_accRole() 必须由其默认值覆盖。  
2144 AccessibilityImplementation.get_accState() 必须由其默认值覆盖。  
2145 requestHeaders 的累积长度必须少于 8192 个字符。  
2146 安全沙箱侵犯：_ 无法调用 _，因为 HTML/容器参数 allowNetworking 的值为 _。  
2147 URL _ 中禁止的协议。  
2148 SWF 文件 _ 无法访问本地资源 _。只有只能与本地文件系统的内容交互的 SWF 文件和受信任的本地 SWF 文件才可能访问本地资源。  
2149 安全沙箱侵犯：_ 无法对 _ 进行 fscommand 调用（allowScriptAccess 为 _）。  
2150 无法将对象添加为它的一个子对象（或子对象的子对象等）的子对象。  
2151 设置对话框可见时无法进入全屏模式。  
2152 不允许使用全屏模式。  
2153 URLRequest.requestHeaders 数组必须只包含非空的 URLRequestHeader 对象。
 *************************************************************************************/