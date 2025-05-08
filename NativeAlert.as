/* * NativeAlert.as
   * 20250508
   * by: SinAcid
   * in: 107k70
   * at: China Medical University
   */
package{
	import flash.html.HTMLLoader;
	import flash.events.Event;

	public /*abstract*/ final class NativeAlert{
		private static const r:Array=t(128,"\\\\\"\"\'\'\rr\nn\tt");
		private static var h:HTMLLoader;
		public static function show(txt:String=null):Promise{
			h=new HTMLLoader();
			var d:Promise=new Promise();
			h.window.finish=function(){d.dispatchEvent(new Event("submit"));}
			if(txt==null)txt="alert";
			var str:String="<script>alert(\"";
			for(var i:int=0;i<txt.length;i++)str+=g(txt.charAt(i));
			str+="\");window.finish();</script>";
			h.loadString(str);
			return d;
		}
		public static function showThen(txt:String=null,yes:Function=null,thisArg:*=null,...args):void{
			show(txt).addEventListener("submit",function(e:Event){if(yes!=null)yes.apply(thisArg,args);});
		}
		public static function ask(txt:String=null):Promise{
			if(txt==null)txt="Are your sure?";
			h=new HTMLLoader();
			var d:Promise=new Promise();
			var o:Object={res:null};
			h.window.o=o;
			h.window.finish=function(){d.res=o.res;d.dispatchEvent(new Event("submit"));}
			var str:String="<script>window.o.res=confirm(\"";
			for(var i:int=0;i<txt.length;i++)str+=g(txt.charAt(i));
			str+="\");window.finish();</script>";
			h.loadString(str);
			return d;
		}
		public static function askThen(txt:String=null,yes:Function=null,no:Function=null,thisArg:*=null,...args):void{
			ask(txt).addEventListener("submit",function(e:Event){if(e.target.res){if(yes!=null)yes.apply(thisArg,args);}else{if(no!=null)no.apply(thisArg,args);}});
		}
		public static function input(txt:String=null,def:String=null):Promise{
			if(txt==null)txt="Please input:";
			if(def==null)def="";
			h=new HTMLLoader();
			var d:Promise=new Promise();
			var o:Object={typein:null};
			h.window.o=o;
			h.window.finish=function(){d.typein=o.typein;d.dispatchEvent(new Event("submit"));}
			var str:String="<script>window.o.typein=prompt(\"";
			for(var i:int=0;i<txt.length;i++)str+=g(txt.charAt(i));
			str+="\",\"";
			for(i=0;i<def.length;i++)str+=g(def.charAt(i));
			str+="\");window.finish();</script>";
			h.loadString(str);
			return d;
		}
		public static function inputThen(txt:String=null,def:String=null,submit:Function=null,thisArg:*=null):void{
			input(txt,def).addEventListener("submit",function(e:Event){if(submit!=null)submit.call(thisArg,e.target.typein);});
		}
		private static function t(len:int,str:String):Array{
			var a:Array=new Array(len);
			for(var i:int=0;i<str.length;i+=2)a[str.charCodeAt(i)]=str.charAt(i+1);
			return a;
		}
		private static function g(str:String):String{
			var k:int=str.charCodeAt();
			return k<128&&r[k]?"\\"+r[k]:str;
		}
		public function NativeAlert(){
			throw new Error("abstract");
		}
	}
}
dynamic class Promise extends flash.events.EventDispatcher{}