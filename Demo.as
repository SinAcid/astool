package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	public class Demo extends Sprite{
		public function Demo(){
			//in fact all args could be empty
			NativeAlert.show("你好！");
			NativeAlert.ask("确定嘛？").addEventListener("submit",asksubmit);
			NativeAlert.askThen("是否要投喂我？",yes);
			NativeAlert.input().addEventListener("submit",inputsubmit);
			NativeAlert.inputThen("请查看您的系统信息：",Capabilities.os,ossubmit);
		}
		private function asksubmit(evt:Event):void{
			trace("您选择了"+(evt.target.res?"是":"否"));
		}
		private function yes():void{
			trace("感谢投喂~");
		}
		private function inputsubmit(evt:Event):void{
			trace(evt.target.typein==null?"您没有输入":"您输入了："+evt.target.typein);
		}
		private function ossubmit(str:String):void{
			trace(str);
		}
	}
}