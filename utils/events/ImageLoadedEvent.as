package com.utils.events
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
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class ImageLoadedEvent extends Event
	{
		
		public static const IMAGE_LOADED_EVENT:String = "IMAGE_LOADED_EVENT";
		
		public var imageData:Bitmap;
		
		public function ImageLoadedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}