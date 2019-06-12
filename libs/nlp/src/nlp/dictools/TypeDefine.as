package nlp.dictools 
{
	/**
	 * ...
	 * @author ww
	 */
	public class TypeDefine 
	{
		
		public function TypeDefine() 
		{
			
		}
		public static var TypeListCH:Array;
		public static function _init():void
		{
			TypeListCH = [];
			var key:String;
			for (key in TypeDesDic)
			{
				TypeListCH.push(TypeDesDic[key]);
			}
			TypeListCH.sort();
		}
		public static function getCHType(type:String):String
		{
			return TypeDesDic[type] || "未知";
		}
		public static function hasCHType(type:String):Boolean
		{
			if (TypeDesDic[type]) return true;
			return false;
		}
		public static const TypeDesDic:Object = {
			"a":"形容词",
			"ad":"副形词",
			"ag":"形容词性语素",
			"al":"形容词性惯用语",
			"an":"名形词",
			"b":"区别词",
			"begin":"仅用于始##始",
			"bg":"区别语素",
			"bl":"区别词性惯用语",
			"c":"连词",
			"cc":"并列连词",
			"d":"副词",
			"dg":"辄,俱,复之类的副词",
			"dl":"连语",
			"e":"叹词",
			"end":"仅用于终##终",
			"f":"方位词",
			"g":"学术词汇",
			"gb":"生物相关词汇",
			"gbc":"生物类别",
			"gc":"化学相关词汇",
			"gg":"地理地质相关词汇",
			"gi":"计算机相关词汇",
			"gm":"数学相关词汇",
			"gp":"物理相关词汇",
			"h":"前缀",
			"i":"成语",
			"j":"简称略语",
			"k":"后缀",
			"l":"习用语",
			"m":"数词",
			"mg":"数语素",
			"Mg":"甲乙丙丁之类的数词",
			"mq":"数量词",
			"n":"名词",
			"nb":"生物名",
			"nba":"动物名",
			"nbc":"动物纲目",
			"nbp":"植物名",
			"nf":"食品，比如“薯片”",
			"ng":"名词性语素",
			"nh":"医药疾病等健康相关名词",
			"nhd":"疾病",
			"nhm":"药品",
			"ni":"机构相关（不是独立机构名）",
			"nic":"下属机构",
			"nis":"机构后缀",
			"nit":"教育相关机构",
			"nl":"名词性惯用语",
			"nm":"物品名",
			"nmc":"化学品名",
			"nn":"工作相关名词",
			"nnd":"职业",
			"nnt":"职务职称",
			"nr":"人名",
			"nr1":"复姓",
			"nr2":"蒙古姓名",
			"nrf":"音译人名",
			"nrj":"日语人名",
			"ns":"地名",
			"nsf":"音译地名",
			"nt":"机构团体名",
			"ntc":"公司名",
			"ntcb":"银行",
			"ntcf":"工厂",
			"ntch":"酒店宾馆",
			"nth":"医院",
			"nto":"政府机构",
			"nts":"中小学",
			"ntu":"大学",
			"nx":"字母专名",
			"nz":"其他专名",
			"o":"拟声词",
			"p":"介词",
			"pba":"介词'把'",
			"pbei":"介词'被'",
			"q":"量词",
			"qg":"量词语素",
			"qt":"时量词",
			"qv":"动量词",
			"r":"代词",
			"rg":"代词性语素",
			"Rg":"古汉语代词性语素",
			"rr":"人称代词",
			"ry":"疑问代词",
			"rys":"处所疑问代词",
			"ryt":"时间疑问代词",
			"ryv":"谓词性疑问代词",
			"rz":"指示代词",
			"rzs":"处所指示代词",
			"rzt":"时间指示代词",
			"rzv":"谓词性指示代词",
			"s":"处所词",
			"t":"时间词",
			"tg":"时间词性语素",
			"u":"助词",
			"ud":"助词",
			"ude1":"的 底",
			"ude2":"地",
			"ude3":"得",
			"udeng":"等 等等 云云",
			"udh":"的话",
			"ug":"过",
			"uguo":"过",
			"uj":"助词",
			"ul":"连词",
			"ule":"了 喽",
			"ulian":"连 （“连小学生都会”）",
			"uls":"来讲 来说 而言 说来",
			"usuo":"所",
			"uv":"连词",
			"uyy":"一样 一般 似的 般",
			"uz":"着",
			"uzhe":"着",
			"uzhi":"之",
			"v":"动词",
			"vd":"副动词",
			"vf":"趋向动词",
			"vg":"动词性语素",
			"vi":"不及物动词",
			"vl":"动词性惯用语",
			"vn":"名动词",
			"vshi":"动词“是”",
			"vx":"形式动词",
			"vyou":"动词“有”",
			"w":"标点符号",
			"wb":"百分号千分号，全角：％ ‰   半角：%",
			"wd":"逗号，全角：， 半角：,",
			"wf":"分号，全角：； 半角： ;",
			"wh":"单位符号，全角：￥ ＄ ￡  °  ℃  半角：$",
			"wj":"句号，全角：。",
			"wky":"右括号，全角：） 〕  ］ ｝ 》  】 〗 〉 半角： ) ] { >",
			"wkz":"左括号，全角：（ 〔  ［  ｛  《 【  〖 〈   半角：( [ { <",
			"wm":"冒号，全角：： 半角： :",
			"wn":"顿号，全角：、",
			"wp":"破折号，全角：——   －－   ——－   半角：—  —-	",
			"ws":"省略号，全角：……  …",
			"wt":"叹号，全角：！",
			"ww":"问号，全角：？",
			"wyy":"右引号，全角：” ’ 』",
			"wyz":"左引号，全角：“ ‘ 『",
			"x":"字符串",
			"xu":"网址URL",
			"xx":"非语素字",
			"y":"语气词(delete yg)",
			"yg":"语气语素",
			"z":"状态词",
			"zg":"状态词"
			};
	}

}