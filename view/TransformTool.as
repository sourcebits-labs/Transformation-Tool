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
	 
	
	
	import com.utils.ImageLoader;
	import com.utils.MathHelper;
	import com.utils.events.ImageLoadedEvent;
	import com.utils.events.TransformEvent;
	import com.view.TransformGeometry;
	import com.view.TransformImage;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	public class TransformTool extends Sprite
	{
		
		
		private var _image:Bitmap;
		
		public static const TRANSFORM_GEOMETRY:String = "TRANSFORM_GEOMETRY";
		public static const TRANSFORM_IMAGE:String = "TRANSFORM_IMAGE";
		
		/***********variable which will hold the target shoud be moved**************/
		private var _target:TransformImage;
		private var imageLoader:ImageLoader;
		
		/**
		 * Contructor function 
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/ 
		public function TransformTool()
		{
			imageLoader = new ImageLoader();
			imageLoader.addEventListener(ImageLoadedEvent.IMAGE_LOADED_EVENT, onImageData);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToSatge);
			//source = "assets/images/1.jpg";
		}
		
		/**
		 * @param velue of type Bitmap
		 * setter function for the _image
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/ 
		public function set image(value:Bitmap):void
		{
			_image = value;
			(!getChildByName(TRANSFORM_IMAGE)) ? addTarget() : upDateImage();
			
		}
		
		
		/**
		 * @param value of type Object 
		 * function which will accept the sourec for the transform tool 
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/ 
		public function set source(value:Object):void 
		{
			
			(value is String) ? imageLoader.source = value as String : (value is Bitmap) ? image = value as Bitmap : "";
			
		}
		
		/**
		 * @param value of type DisplayObject
		 * setter function for _target
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		public function set target(value:TransformImage):void
		{
			
			_target = value;
			addTransformGeometry();
			
		}
		
		/**
		 * @param of type null
		 * getter function for _target
		 * @return _target of type Display Object
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		public function get target():TransformImage
		{
			
			return _target;
			
		}
		
		
		/**
		 * @param of type null
		 * functiuon which will handle the added to stage event for the component
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function addTarget():void
		{
			
			var transformImage:TransformImage = new TransformImage();
			transformImage.sourceBMP = _image;
			transformImage.name = TRANSFORM_IMAGE;
			addChild(transformImage);
			target = transformImage;
			
		}
		
		/**
		 * @param of type null
		 * function which will reset all the properties of the image
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/ 
		private function upDateImage():void 
		{
			var transformGeometry:TransformGeometry = getChildByName(TRANSFORM_GEOMETRY) as TransformGeometry;
			var transformImage:TransformImage = getChildByName(TRANSFORM_IMAGE) as TransformImage;
			transformImage.resetImage();
			transformImage.sourceBMP = _image;
			transformGeometry.resteGeometry();
		}
		
		
		/**
		 * @param of type null
		 * function which will add the transformGeometry 
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function addTransformGeometry():void 
		{
			var transformGeometry:TransformGeometry = new TransformGeometry(target);
			transformGeometry.name = TRANSFORM_GEOMETRY;
			addChildAt(transformGeometry, numChildren);
			transformGeometry.addEventListener(TransformEvent.MOVE, doMove);
		}
		
		
		/**************************************************************/
		/******************Functions for event Handling****************/
		/**************************************************************/
		
		/**
		 * @param event of type Event
		 * function which will handle the added to stage event for the Navigator
		 * @author Rajesh 
		 * @date 14 feb 2011
		 **/
		private function onAddedToSatge(event:Event):void 
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		/**
		 * @param event of type TransformEvent
		 * function which will move the component to next position
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function doMove(event:TransformEvent):void 
		{
			
			var point:Point = new Point(x, y);
			point = point.add(Point.polar(event.distance, MathHelper.degreeToRadian(event.moveAngle)));
			x = point.x;
			y = point.y;
		}
		
		/**
		 * @param event of type ImageLoadedEvent
		 * function which will handle the image laoded event for the imageLaoder
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function onImageData(event:ImageLoadedEvent):void 
		{
			
			image = event.imageData;
			
		}
		
		
	}
}