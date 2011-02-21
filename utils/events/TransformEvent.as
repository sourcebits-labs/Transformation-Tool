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
	import flash.events.Event;
	
	public class TransformEvent extends Event
	{
		
		public static const MOVE:String = "MOVE";
		public static const RESIZE:String = "RESIZE";
		public static const ROTATE:String = "ROTATE";
		
		
		public var rotationAngle:Number;
		public var distance:Number;
		public var moveAngle:Number;
		public var incrimentSize:Number;
		
		
		public function TransformEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		
		
	}
}