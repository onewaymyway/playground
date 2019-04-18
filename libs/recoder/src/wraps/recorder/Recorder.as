package wraps.recorder {
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.utils.Utils;
	
	/**
	 * ...
	 * @author ww
	 */
	public class Recorder {
		
		public function Recorder() {
		
		}
		public static function getRecorder(completeHandler:Handler,config:Object=null):void
		{
			Browser.window.navigator.getUserMedia(
			   {audio:true }, 
			   function(stream:*):void {
				   var rc:Recorder;
				   rc = new Recorder();
				   rc.setParam(stream, config);
				   if (completeHandler)
				   {
					   completeHandler.runWith(rc);
					}
				},function(err:*):void
				{
					if (completeHandler)
				   {
					   completeHandler.runWith(null);
					}
				}
			);
		}
		public var audioInput:*;
		public var recorder:*;
		public var audioData:AudioData;
		public var processHandler:Handler;
		public var context:*;
		public var bufferSize:int=4096;
		public function setParam(stream:*, config:Object=null):void {
			config = config || {};
			config.sampleBits = config.sampleBits || 8; //采样数位 8, 16  
			//config.sampleRate = config.sampleRate || (44100 / 6); //采样率(1/6 44100)  
			config.sampleRate = config.sampleRate || 8000; //采样率(1/6 44100) 
			
			var window:*;
			window=Browser.window;
			//创建一个音频环境对象  
			var audioContext:* = window.AudioContext || window.webkitAudioContext;
			context = new audioContext();
			
			//将声音输入这个对像  
			audioInput = context.createMediaStreamSource(stream);
			
			//设置音量节点  
			var volume = context.createGain();
			audioInput.connect(volume);
			
			//创建缓存，用来缓存声音  
			//var bufferSize = 4096;
			
			// 创建声音的缓存节点，createScriptProcessor方法的  
			// 第二个和第三个参数指的是输入和输出都是双声道。  
			recorder = context.createScriptProcessor(bufferSize, 1, 1);
			
			audioData = new AudioData();
			audioData.inputSampleRate = context.sampleRate;
			audioData.inputSampleBits = 16;
			audioData.outputSampleRate = config.sampleRate;
			audioData.outputSampleBits = 16;
			
			recorder.onaudioprocess = Utils.bind(onAudioProcess, this);
			
		
		}
		public var isWorking:Boolean = false;
		private function onAudioProcess(e:*):void
		{
			if (!isWorking) return;
			//debugger;
			//trace("process:", e);
			audioData.input(e.inputBuffer.getChannelData(0));
			if (processHandler)
			{
				processHandler.runWith(e);
			}
		}
		
		public function play():void {
			audioInput.connect(recorder);
			recorder.connect(context.destination);
		}
		
		public function stop():void
		{
			recorder.disconnect();  
		}
	}

}