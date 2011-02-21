/**
 ////////////////////////////////////////////////////////////////////////////////
 //
 //  SOURCE BITS INCORPORATED
 //  Copyright Reserved.
 //
 ////////////////////////////////////////////////////////////////////////////////
 *
 **/
package com.utils 
{
	
	
	/* import flash.display.Graphics;
	import flash.display.BitmapData; */
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class MathHelper
	{
		
		
		
		/***************Variable of type Boolean which will aviod the multtipple creation of objects***************/
		private static var _allowCreation:Boolean = false;
		
		/**************Instance of MathCalculator********************/
		private static var _instance:MathHelper;
		
		/**
		 * Custructor function 
		**/ 
		public function MathHelper()
		{
			
			if(!_allowCreation) {
				
				throw(new Error("Instance can be created through getInstance function"));
				return;
				
			}
			_allowCreation = false;
			
		}
		
		
		/**
		 * @param of type null
		 * @return _instance of type MathCalculator
		 * function which will return the instance of MathCalculator
		**/
		public static function getInstance():MathHelper
		{
			
			if(!_instance) 
			{
				
				_allowCreation = true;
				_instance = new MathHelper();
				
			}
			return _instance;
			
		} 
		
		/**
		 * @param g of type Graphics
		 * function which will draw a trasparent layer on the graphics
		**/
		public static function drawTransparentLayer(g:Graphics, width:Number, height:Number, alpha:Number = 1.0, color:uint = 0xFFFFFF, x:Number = 0, y:Number = 0):void
		{
			
			g.beginFill(color, alpha);
			g.drawRect(x, y, width, height);
			g.endFill();
			
		} 
		
		
		/**
		 * @param graphics of type Graphics
		 * @param width of type number
		 * @param height of type number
		 * @param x of type number
		 * @param y of type number
		**/
		public static function drawRectangle(graphics:Graphics, width:Number, height:Number, x:Number, y:Number, color:uint, alpha:Number = 1):void
		{
			
			graphics.moveTo(x, y);
			graphics.beginFill(color, alpha);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();
			
		} 
		
		/**
		 * @param diplayObject of type DisplayObject
		 * @param width of type Number
		 * @param height of type Number
		 * function which will scale the given displayObject
		**/
		public static function scaleObject(displayObject:DisplayObject, width:Number, height:Number):void
		{
			
			var scaleX:Number = width / displayObject.width;
			var scaleY:Number = height / displayObject.height;
			displayObject.scaleX = scaleX;
			displayObject.scaleY = scaleY;
			
		}
		
		/**
		 * @param bitmap of type Bitmap
		 * @param width of type Number
		 * @param height of type Number
		 * @return newBitmap of type Bitmap
		 * function which will change the dimaention of the bitmap
		**/
		public static function changeDimention(bitmap:Bitmap, width:Number, height:Number, smoothing:Boolean):Bitmap
		{
			
			width = Math.max(1, width);
			height = Math.max(1, height);
			
			var scaleX:Number = width / bitmap.width;
			var scaleY:Number = height / bitmap.height;
			var matrix:Matrix = new Matrix();
			matrix.scale(scaleX, scaleY);
			var bitmapData:BitmapData = new BitmapData(width, height, true, 0x000000);
			bitmapData.draw(bitmap.bitmapData, matrix, null, null, null, true);
			bitmap = new Bitmap(bitmapData, PixelSnapping.AUTO, smoothing);
			return bitmap;
		}
		
		/**
		 * @param angle of type Number
		 * @return angle of type Number
		 * function which will converts angle in degree to Radian
		**/
		public static function degreeToRadian(angle:Number):Number
		{
			
			angle = angle * (Math.PI / 180);
			return angle;
		} 
		
		/**
		 * @param angle of type Number
		 * @return angle of type Number
		 * function which will converts angle in Radian to degree
		**/
		public static function radianToDegree(angle:Number):Number
		{
			
			angle = angle * (180 / Math.PI);
			return angle;
		} 
		
		/**
		 * @param pointA of type Point 
		 * @param pointB of type Point
		 * @return angle of type Number
		 * function which will return the angle between the points
		**/ 
		public static function getAngleBetweenPoints(pointA:Point, pointB:Point):Number 
		{
			
			var angle:Number = Math.atan2((pointB.y - pointA.y), (pointB.x - pointA.x));
			angle = angle * (180 / Math.PI);
			return angle;
		}
		
		/**
		 * @param pointA of type Point 
		 * @param pointB of type Point
		 * @return distance of type Number
		 * function which will return the distance between the points
		**/ 
		public static function getDistanceBetweenPoints(pointA:Point, pointB:Point):Number 
		{
			
			var distance:Number = Math.pow((pointA.x - pointB.x), 2) + Math.pow((pointA.y - pointB.y), 2);
			distance = Math.sqrt(distance);
			return distance;
		}
		
		/**
		 * @param pointA of type Point 
		 * @param pointB of type Point
		 * @return distance of type Number
		 * function which will return the distance between the points
		**/ 
		public static function getDistanceBetweenPointsWithDirection(pointA:Point, pointB:Point):Object 
		{
			
			var xdeff:Number = (pointA.x - pointB.x);
			var ydeff:Number = (pointA.y - pointB.y);
			
			var result:Object = {};
			
			if(xdeff < 0 && ydeff < 0)
			{
				result.direction = -1;
			}else if(xdeff < 0)
			{
				if(Math.abs(xdeff) > ydeff)
				{
					result.direction = -1;
				}else
				{
					result.direction = 1;
				}
				
			}else if(ydeff < 0)
			{
				if(Math.abs(ydeff) > xdeff)
				{
					result.direction = -1;
				}else
				{
					result.direction = 1;
				}
				
				
			}else
			{
				result.direction = 1;
			}
			
			
			//result.direction = (xdeff < 0 || ydeff < 0) ? -1 : 1;
			var distance:Number = Math.pow((pointA.x - pointB.x), 2) + Math.pow((pointA.y - pointB.y), 2);
			distance = Math.sqrt(distance);
			result.distance = distance;
			return result;
		}
		
		
		/**
		 * @param graphics of type Graphics
		 * @param bitmap of type Bitmap
		 * function which will draw the given bitmap to the graphics
		**/
		public static function fillBitmap(graphics:Graphics, bitmap:Bitmap, x:Number = 0, y:Number = 0):void
		{
			
			
			graphics.beginBitmapFill(bitmap.bitmapData, null, true, true);
			graphics.drawRect(0, 0, bitmap.width, bitmap.height);
			graphics.endFill();
			
		} 
		 
		/**
		 * @param angle of type number
		 * @param radius of type number
		 * @param phi of type number
		 * @param positiin of type Object
		 * function which will return a 2d circular point
		**/
		public static function getThreeDiamentinalPoint(angle:Number, radius:Number, phi:Number, position:Object):void
		{
			position.x = radius * Math.cos(degreeToRadian(phi)) * Math.sin(degreeToRadian(angle));
			position.y = radius * Math.sin(degreeToRadian(angle)) * Math.sin(degreeToRadian(phi));
			position.z = radius * Math.cos(degreeToRadian(angle));
		} 
		 
		public static var txt:TextField = new TextField();
		 
		/**
		 * @param textDetails of type Object
		 * function which will create the textBitmap
		**/
		public static function createTextBitmap(textDetails:Object):Bitmap
		{
			
			var fillColor:uint = (textDetails.textColor == 0) ? 0xFFFFFF : 0x000000;
			var format: TextFormat = new TextFormat();
			format.font = textDetails.font;
			format.size = textDetails.size;
			txt.wordWrap = false;
			txt.textColor = textDetails.textColor;
			txt.text = textDetails.text;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.backgroundColor = fillColor;
			txt.background = true;
			txt.setTextFormat(format);
			//txt.width = (textDetails.text.length + 2) * textDetails.size;
			var bitmapData: BitmapData = new BitmapData(txt.width, txt.height);
			bitmapData.draw(txt);
			var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.AUTO, true);
			return bitmap;
		} 
		
		 /**
		 * @param displayObject of type displayObject
		 * @return position of type point
		 * funcltion which will return the position of the displayObject 
		**/
		public static function getPosition(displayObject:DisplayObject):Point 
		{
			
			return new Point(displayObject.x, displayObject.y);
			
		}
		
		/**
		 * @param width of type Number
		 * @param height of type Number 
		 * @return diagonal of type Number 
		 * function which will return the diagonal 
		**/
		public static function getDiagonal(width:Number, height:Number):Number
		{
			
			var diagonal:Number = Math.sqrt(((width * width) + (height * height)));
			return diagonal;
			
			
		} 
		
		/**
		 * @param graphics of Type Graphics
		 * @param nofLayers of type Number
		 * functin which will a rectangled stack structure on the graphics
		 * @Author Rajesh
		 * @date 11 aug 2010
		**/
		public static function drawSatckedLayers(graphics:Graphics, nofLayers:Number, width:Number, height:Number):void
		{
			var midPoint:Point = new Point((width / 2), (height / 2));
				
			var angle:Number = getAngleBetweenPoints(midPoint, new Point(0, 0));
			
			var distance:Number = getDistanceBetweenPoints(midPoint, new Point(0, 0));
			
			var rotation:Number = 0;
			
			while(nofLayers > 0)
			{
				
				var bitmapData:BitmapData = new BitmapData(width, height);
				bitmapData.floodFill(0, 0, 0xFFFFFF);
				var matrix:Matrix = new Matrix();
				matrix.rotate(Math.PI / 2); 
				
				var point:Point = midPoint.add(Point.polar(distance, angle));
				
				
				
				/* matrix.translate(point.x, point.y); */ 
				graphics.beginBitmapFill(bitmapData, matrix, false);
				graphics.drawRect(point.x, point.y, width, height); 
				graphics.endFill();
				nofLayers--;
			}
		}
		
		/**
		 * @param graphics of type Graphics
		 * @param radius of type Number
		 * @param x of type Number
		 * @param y of type Number
		 * @param color of type uint
		**/
		public static function drawCircle(graphics:Graphics, radius:Number, x:Number, y:Number, color:uint):void
		{
			
			graphics.beginGradientFill(GradientType.LINEAR,[0x3f3f3f, 0x3f3f3f],[1,1.0],
			[0, 127],null,SpreadMethod.PAD);
			graphics.drawCircle(x, y, radius);
			graphics.endFill();
		} 
		
		/**
		 * @param bitmap of type Bitmap
		 * @param width of type Number
		 * @param height of type Number
		 * @return newBitmap of type Bitmap
		 * function which will return an unstreched bitmap
		**/
		public static function getUnStrechedImage(bitmap:Bitmap, width:Number, height:Number):Bitmap
		{
			
			var devisionFactor:Number = (width > height) ? width : height;
			var scaleFactor:Number = devisionFactor / ((bitmap.width < bitmap.height) ? bitmap.width : bitmap.height);
			var matrix:Matrix = new Matrix();
			matrix.scale(scaleFactor, scaleFactor);
			var bitmapData:BitmapData = new BitmapData(scaleFactor * bitmap.width, scaleFactor * bitmap.height, true);
			bitmapData.draw(bitmap, matrix, null, null, null, true);
			var croppedBitmapData:BitmapData = crop(bitmapData, width, height);
			return new Bitmap(croppedBitmapData);
			
		} 
		
		/**
		 * @param bitmapData of type BitmapData
		 * @param width of type Number
		 * @param height of type Number 
		 * @return bitmapData of type BitmapData
		**/
		public static function crop(bitmapData:BitmapData, width:Number, height:Number):BitmapData
		{
			
			var tempBitmapData:BitmapData=new BitmapData(width, height);

			var startX:int=Math.abs(bitmapData.width - width) / 2;
			var startY:int=Math.abs(bitmapData.height - height) / 2;

			tempBitmapData.copyPixels(bitmapData, new Rectangle(startX, startY, width, height), new Point(0, 0));

			return tempBitmapData;
			
		} 
		
		/**
		 * @param displayObject of type DisplayObject
		 * @return bitmap of type BitMap
		 * @Author rajesh 
		 * @date 26 aug 2010
		**/
		public static function getBitmap(displayObject:DisplayObject):Bitmap
		{
			var bounds:Object = displayObject.getBounds(displayObject);
			var bitmapData:BitmapData = new BitmapData(Math.abs(bounds.topLeft.x) + bounds.width, Math.abs(bounds.topLeft.y) + bounds.height, true, 0xFFFFFF);
			//var bitmapData:BitmapData = new BitmapData(displayObject.width, displayObject.height, true, 0xFFFFFF);
			bitmapData.draw(displayObject);
			return new Bitmap(bitmapData);
		} 
		
		/**
		 * @param of type null
		 * @return bitmapData of type BitmapData
		 * function which will return a transparent BitmapData
		**/
		public static function getTransparentBitmap(width:Number, height:Number, rectAngle:Rectangle):Bitmap
		{
			var bitmapData:BitmapData = new BitmapData(width, height, true, 0x000000);
			
			bitmapData.floodFill(0, 0, 0xFF3F3F3F);
			bitmapData.fillRect(rectAngle, 0x00000000);
			
			return new Bitmap(bitmapData);
		}
		
		
		/**
		 * @param of type null
		 * function whci will return the intersection point of two lines
		 * @author rajesh 
		 * @date 21 sep 2010
		**/ 
		public static function lineIntersectLine(A:Point,B:Point,E:Point,F:Point,as_seg:Boolean=true):Point {
		    var ip:Point;
		    var a1:Number;
		    var a2:Number;
		    var b1:Number;
		    var b2:Number;
		    var c1:Number;
		    var c2:Number;
		 
		    a1= B.y-A.y;
		    b1= A.x-B.x;
		    c1= B.x*A.y - A.x*B.y;
		    a2= F.y-E.y;
		    b2= E.x-F.x;
		    c2= F.x*E.y - E.x*F.y;
		 
		    var denom:Number=a1*b2 - a2*b1;
		    if (denom == 0) {
		        return null;
		    }
		    ip=new Point();
		    ip.x=(b1*c2 - b2*c1)/denom;
		    ip.y=(a2*c1 - a1*c2)/denom;
		 
		    
		    if(as_seg){
		        if(Math.pow(ip.x - B.x, 2) + Math.pow(ip.y - B.y, 2) > Math.pow(A.x - B.x, 2) + Math.pow(A.y - B.y, 2))
		        {
		           return null;
		        }
		        if(Math.pow(ip.x - A.x, 2) + Math.pow(ip.y - A.y, 2) > Math.pow(A.x - B.x, 2) + Math.pow(A.y - B.y, 2))
		        {
		           return null;
		        }
		 
		        if(Math.pow(ip.x - F.x, 2) + Math.pow(ip.y - F.y, 2) > Math.pow(E.x - F.x, 2) + Math.pow(E.y - F.y, 2))
		        {
		           return null;
		        }
		        if(Math.pow(ip.x - E.x, 2) + Math.pow(ip.y - E.y, 2) > Math.pow(E.x - F.x, 2) + Math.pow(E.y - F.y, 2))
		        {
		           return null;
		        }
		    }
		    return ip;
	 	}
		
		/**
		 * @param g of type Graphics
		 * @param x of type Number 
		 * @param y of type Number
		 * @param radius of type Number 
		 * function which will draw a half circle on the graphics
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/ 
		public static function halfCircle(g:Graphics, x:Number,y:Number,r:Number):void {
		    var c1:Number=r * (Math.SQRT2 - 1);
		    var c2:Number=r * Math.SQRT2 / 2;
		    g.moveTo(x+r,y);
		    g.curveTo(x+r,y+c1,x+c2,y+c2);
		    g.curveTo(x+c1,y+r,x,y+r);
		    g.curveTo(x-c1,y+r,x-c2,y+c2);
		    g.curveTo(x-r,y+c1,x-r,y);
		} 
		
		
		/**
		 * @param g of type Graphics
		 * @param p of type Point 
		 * @param radius of type Number 
		 * function which will draw arrow to the graphics
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		public static function drawArrow(g:Graphics, p:Point, radius:Number, angleOfRotation:Number, widthArrowPerc:Number):void 
		{
			var arrowLength:Number = radius * (widthArrowPerc / 100);
			var p1:Point = p.add(Point.polar(arrowLength, degreeToRadian(angleOfRotation + 135)));
			var p2:Point = p.add(Point.polar(arrowLength, degreeToRadian(angleOfRotation + 45)));
			g.moveTo(p.x, p.y);
			g.lineTo(p1.x, p1.y);
			g.moveTo(p.x, p.y);
			g.lineTo(p2.x, p2.y);
		}
		
      	
	}
}