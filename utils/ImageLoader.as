package com.utils
{
	/**
	 ////////////////////////////////////////////////////////////////////////////////
	 //
	 //  SOURCE BITS INCORPORATED
	 //  Copyright Reserved.
	 //
	 ////////////////////////////////////////////////////////////////////////////////
	 *
	 **/
	import com.utils.events.ImageLoadedEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class ImageLoader extends EventDispatcher
	{
		public function ImageLoader(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * @param value of type Object 
		 *  function which will set the source for the component 
		 * @author Rajesh 
		 * @date 17 feb 2011
		 **/
		public function set source(value:String):void 
		{
			loadImage(value);
		}
		
		/**
		 * @param of type null
		 * function which will load the image 
		 * @author Rajeh 
		 * @date 17 feb 2011
		 **/
		private function loadImage(url:String):void 
		{
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			loader.load(new URLRequest(url));
		}
		
		/**
		 * @param event of type Event
		 * function which will handle the load complete event for the loader 
		 * @author Rajesh 
		 * @date 17 feb 2011
		 **/
		private function onLoadComplete(event:Event):void 
		{
			
			var imageLoadedEvent:ImageLoadedEvent = new ImageLoadedEvent(ImageLoadedEvent.IMAGE_LOADED_EVENT);
			imageLoadedEvent.imageData = event.target.content as Bitmap;
			dispatchEvent(imageLoadedEvent);
			
		}
		
		/**
		 * @param event of type IOErrorEvent
		 * function which will handle the load error rvrnt  for the loader 
		 * @author Rajesh 
		 * @date 17 feb 2011
		 **/
		private function onLoadError(event:IOErrorEvent):void 
		{
			
			trace("Load Error at image component");
			
		}
		
		
		
	}
}