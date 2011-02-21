package com.view
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
	import com.utils.MathHelper;
	import com.utils.events.TransformEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class TransformImage extends Sprite
	{
		
		private var _sourceBMP:Bitmap;
		/**
		 * Constructor function 
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/ 
		public function TransformImage()
		{
			super();
		}
		
		/**
		 * @param value of type Bitmap 
		 * setter function for _sourceBMP
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		public function set sourceBMP(value:Bitmap):void 
		{
			
			_sourceBMP = value;
			drawImage();
		}
		
		/**
		 * @param of type null
		 * @return _sourceBMP of type Bitmap
		 * getter function for _sourceBMP
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		public function get sourceBMP():Bitmap
		{
			
			return _sourceBMP;
			
		}
		
		/**
		 * @param of type null
		 * @return of type Number
		 * function which will return the width of the transform image
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/ 
		public function get targetWidth():Number
		{
			
			return sourceBMP.width * scaleX;
			
		}
		
		/**
		 * @param of type null
		 * @return of type Number
		 * function which will return the height of the transform image
		 * @author Rajesh 
		 * @date 17 feb 2011
		 **/ 
		public function get targetHeight():Number
		{
			
			return sourceBMP.height * scaleY;
			
		}
		
		/**
		 * @param of type null
		 * @return of type Number
		 * function which will return the width of the diameter of the component
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/ 
		public function get diagonal():Number
		{
			
			return MathHelper.getDiagonal(targetWidth, targetHeight);
			
		}
		
		
		/**
		 * @param of type null
		 * function which will darw the bitmap over the child
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function drawImage():void 
		{
			graphics.clear();
			MathHelper.fillBitmap(graphics, sourceBMP);
			
		}
		
		
		/**
		 * @param angle of type Number
		 * function which will redraw the bitmap to the graphics
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		public function rotate(angle:Number, center:Point):void 
		{
			var xDeff:Number = (scaleX * sourceBMP.width) / 2;
			var yDeff:Number = (scaleY * sourceBMP.height) / 2;
			var newPos:Point = center.add(Point.polar(xDeff, MathHelper.degreeToRadian(angle + 180)));
			var topLeft:Point = newPos.add(Point.polar(yDeff,  MathHelper.degreeToRadian(angle + 270)));
			rotation = angle;
			x = topLeft.x;
			y = topLeft.y;
		}
		
		
		/**
		 * @param incriment of type Number
		 * function which will incriment the size of the tarnsform Tool
		 * @auhtor Rajesh 
		 * @date 17 feb 2011
		**/
		public function doResizeBy(incriment:Number, center:Point):void 
		{
			
			var scale:Number = scaleX + (2 * (incriment / sourceBMP.width));
			
			if(scale < 0)
				return;
			
			scaleX = scaleY = scale;
			var xDeff:Number = (scaleX * sourceBMP.width) / 2;
			var yDeff:Number = (scaleY * sourceBMP.height) / 2;
			var newPos:Point = center.add(Point.polar(xDeff, MathHelper.degreeToRadian(rotation + 180)));
			var topLeft:Point = newPos.add(Point.polar(yDeff,  MathHelper.degreeToRadian(rotation + 270)));
			x = topLeft.x;
			y = topLeft.y;
		}
		
		/**
		 * @param of type null
		 * function which will reset the all the properties of the image
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/ 
		public function resetImage():void 
		{
			
			scaleX = scaleY = 1;
			rotation = 0;
			x = 0;
			y = 0;
			
		}
		
		
		
		
			
	}
}