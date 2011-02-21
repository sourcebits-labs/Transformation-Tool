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
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class TransformGeometry extends Sprite
	{
		
		public static const NAVIGATOR_CONTROL:String = "NAVIGATOR_CONTROL";
		public static const RESIZE_HANDLER:String = "RESIZE_HANDLER";
		public static const NAVIGATOR_PERCENTAGE:Number = 20;
		public static const RESIZE_HANDLER_PERCENTAGE:Number = 80;
		
		
		public static const TRANSFORM_GEOMETRY:String = "TRANSFORM_GEOMETRY";
		
		public var centerPoint:Point;
		
		
		private var _target:TransformImage;
		
		/**
		 * Constructor function 
		 * @author Rajesh 
		 * @date 12 feb 2011
		**/ 
		public function TransformGeometry(target:TransformImage)
		{
			super();
			_target = target;
			centerPoint = new Point(_target.targetWidth / 2, _target.targetHeight / 2);
			designGeometry();
		}
		
		/**
		 * @param of type null
		 * function which will reset tehh transform geometry
		 * @author Rajesh 
		 * @date 18 feb 2011
		**/ 
		public function resteGeometry():void 
		{
			
			centerPoint = new Point(_target.targetWidth / 2, _target.targetHeight / 2);
			designGeometry();
			
		}
		
		
		/**
		 * @param event of type Event
		 * functiuon which will handle the added to stage event for the component
		 * @author Rajesh 
		 * @date 12 feb 2011
		 **/
		public function designGeometry():void
		{
			addNavigator();
			addResizeHandler();
			
		}
		
		/**
		 * @param of type null
		 * functiuon which will add the background for the geometry
		 * @author Rajesh 
		 * @date 12 feb 2011
		**/
		private function addBackground():void
		{
			
			MathHelper.drawRectangle(graphics, _target.targetWidth, _target.targetHeight, 0, 0, Math.random() * 0xFFFFFF, 0.2);
		}
		
		/**
		 * @param of type null
		 * functiuon which will add resize handler for the geometry
		 * @author Rajesh 
		 * @date 12 feb 2011
		**/
		private function addResizeHandler():void
		{
			var resizeHandler:ResizeHandler = getResizeandler();
			resizeHandler.rotation = 0;
			updateResizeHandle();
		}
		
		/**
		 * @param of type null
		 * function which will update the resizehandler 
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/ 
		private function updateResizeHandle():void 
		{
			var value:Number = (_target.targetWidth < _target.targetHeight) ? _target.targetWidth / 2 : _target.targetHeight / 2;
			var resizeHandler:ResizeHandler = getChildByName(RESIZE_HANDLER) as ResizeHandler;
			resizeHandler.handlerLength = value * (RESIZE_HANDLER_PERCENTAGE / 100);
			var distance:Number = value * (NAVIGATOR_PERCENTAGE / 100);
			
			var position:Point = centerPoint.add(Point.polar(distance, MathHelper.degreeToRadian(_target.rotation)));
			resizeHandler.x = position.x;
			resizeHandler.y = position.y;
			
		}
		
		
		/**
		 * @param of type null
		 * function which will add the navigator control
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function addNavigator():void 
		{
			var value:Number = (_target.targetWidth < _target.targetHeight) ? _target.targetWidth / 2 : _target.targetHeight / 2;
			var navigator:Navigator = getNavigator();
			navigator.angleofRotation = 0;
			navigator.x = (_target.targetWidth / 2);
			navigator.y = (_target.targetHeight / 2);
			navigator.radius = value * (NAVIGATOR_PERCENTAGE / 100);
			
		}
		
		/**
		 * @param of type null
		 * function which will return the instance of navigator
		 * @author Rajesh 
		 * @date 18 feb 2011
		**/ 
		private function getNavigator():Navigator 
		{
			var navigator:Navigator;
			if(!getChildByName(NAVIGATOR_CONTROL))
			{
				navigator = new Navigator();
				navigator.name = NAVIGATOR_CONTROL;
				addChild(navigator);
				navigator.addEventListener(TransformEvent.ROTATE, rotateTarget);
				navigator.addEventListener(TransformEvent.MOVE, doMove);
			}else 
			{
				
				navigator = getChildByName(NAVIGATOR_CONTROL) as Navigator;
				
			}
			return navigator;
		}
		
		/**
		 * @param of type null
		 * function which will return the instance of resize handler 
		 * @autho Rajesh 
		 * @date 18 feb 2011
		**/
		private function getResizeandler():ResizeHandler 
		{
			var resizeHandler:ResizeHandler;
			
			if(!getChildByName(RESIZE_HANDLER))
			{
				resizeHandler = new ResizeHandler();
				resizeHandler.name = RESIZE_HANDLER;
				addChild(resizeHandler);
				resizeHandler.addEventListener(TransformEvent.RESIZE, doResize);
			}else 
			{
				resizeHandler = getChildByName(RESIZE_HANDLER) as ResizeHandler;
			}
			return resizeHandler;
			
		}
		
		
		/**************************************************************/
		/******************Functions for event Handling****************/
		/**************************************************************/
		
		/**
		 * @param event of type TransformEvent
		 * function which will handle the move event for the navigator
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function rotateTarget(event:TransformEvent):void 
		{
			getChildByName(RESIZE_HANDLER).rotation = event.rotationAngle;
			_target.rotate(event.rotationAngle, centerPoint);
			updateResizeHandle();
		}
		
		/**
		 * @aparam event of type Event
		 * function which will handle the move event for the navigator
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function doMove(event:TransformEvent):void 
		{
			var moveEvent:TransformEvent = new TransformEvent(TransformEvent.MOVE);
			moveEvent.moveAngle = event.moveAngle;
			moveEvent.distance = event.distance;
			dispatchEvent(moveEvent);
			
		}
		
		
		/**
		 * @param event of type TransformEvent
		 * function which will handle the transform event resize for the resize handler 
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function doResize(event:TransformEvent):void 
		{
			var value:Number = (_target.targetWidth < _target.targetHeight) ? _target.targetWidth / 2 : _target.targetHeight / 2;
			_target.doResizeBy(event.incrimentSize, centerPoint);
			(getChildByName(NAVIGATOR_CONTROL) as Navigator).radius = value * (NAVIGATOR_PERCENTAGE / 100);
			updateResizeHandle();
			
		}
	}
}