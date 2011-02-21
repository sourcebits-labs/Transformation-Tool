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
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import flashx.textLayout.events.UpdateCompleteEvent;
	
	public class ResizeHandler extends Sprite
	{
		
		public static const RESIZE_CONTROL:String = "RESIZE_CONTROL";
		
		private var target:DisplayObject;
		private var mouseDownPoint:Point;
		
		private var _handlerLength:Number;
		
		/**
		 * Constructor function 
		 * @author Rajesh
		 * @date 14 feb 2011
		**/ 
		public function ResizeHandler()
		{
			super();
			addResizeControl();
			addEventListener(Event.ADDED_TO_STAGE, onAddedTostage);
		}
		
		/**
		 * @param value of type Number 
		 * setter function for _handlerLength
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		public function set handlerLength(value:Number):void 
		{
			
			_handlerLength = value;
			drawResizeHandle();
			drawLineDirection();
		}
		
		/**
		 * @aparam of type null
		 * function which will add the resize control for the comonent
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/ 
		private function addResizeControl():void 
		{
			
			var sprite:Sprite = new Sprite();
			sprite.name = RESIZE_CONTROL;
			sprite.buttonMode = true;
			sprite.useHandCursor = true;
			sprite.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			sprite.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addChild(sprite);
			
		}
		
		/**
		 * @param of type null
		 * function which will draw the set the shape for the resize control
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function drawResizeHandle():void 
		{
			//handle size will be always 20% of the total size of the resize handler varries on resize 
			var handleSize:Number = _handlerLength * (20 / 100);
			var resizeControl:Sprite = getChildByName(RESIZE_CONTROL) as Sprite;
			resizeControl.graphics.clear();
			resizeControl.graphics.lineStyle(1, 0x000000);
			resizeControl.graphics.beginFill(0xFFFFFF, 0.5);
			resizeControl.graphics.lineTo(0, -(handleSize / 2));
			resizeControl.graphics.lineTo(handleSize, 0);
			resizeControl.graphics.lineTo(0, (handleSize / 2));
			resizeControl.graphics.lineTo(0, 0);
			resizeControl.graphics.endFill();
			
		}
		
		/**
		 * @param of type null
		 * function which will draw a rectangle for the component
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/ 
		private function drawLineDirection():void 
		{
			var handleSize:Number = (_handlerLength * (5 / 100));
			graphics.clear();
			var directorSize:Number = (_handlerLength) * (80 / 100);
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0xFFFFFF, 0.5);
			graphics.drawRect(0, -(handleSize / 2), directorSize, handleSize);
			graphics.endFill();
			getChildByName(RESIZE_CONTROL).x = directorSize;
			(target) ? drawResizeIndicator() : "";
		}
		
		
		/**
		 * @param of type null
		 * function which will draw the resize indicator 
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function drawResizeIndicator():void 
		{
			
			var handleSize:Number = (_handlerLength * (5 / 100));
			var directorSize:Number = (_handlerLength) * (80 / 100);
			var indicatorSize:Number = (_handlerLength) * (70 / 100);
			graphics.lineStyle(2, 0x000000);
			graphics.moveTo(directorSize / 2, -handleSize);
			graphics.lineTo((directorSize / 2) - indicatorSize / 2, -handleSize);
			graphics.moveTo(directorSize / 2, -handleSize);
			graphics.lineTo((directorSize / 2) + indicatorSize / 2, -handleSize);
			MathHelper.drawArrow(graphics, new Point((directorSize / 2) + indicatorSize / 2, -handleSize), (indicatorSize / 2), 90, 5);
			graphics.moveTo(directorSize / 2, -handleSize);
			MathHelper.drawArrow(graphics, new Point((directorSize / 2) - indicatorSize / 2, -handleSize), (indicatorSize / 2), 270, 5);
		}
		
		
		/**
		 * @param event of type mouseEvent
		 * function which will move the component and update the handler size 
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function doMove():void 
		{
			var currentPoint:Point = new Point(mouseX, mouseY);
			var xDefference:Number = currentPoint.x - mouseDownPoint.x;
			handlerLength = _handlerLength + xDefference;
			mouseDownPoint = currentPoint;
			var tranformEvent:TransformEvent = new TransformEvent(TransformEvent.RESIZE);
			tranformEvent.incrimentSize = xDefference;
			dispatchEvent(tranformEvent);
			
		}
		
		
		
		/**************************************************************/
		/******************Functions for event Handling****************/
		/**************************************************************/
		
		/**
		 * @param event of type Event
		 * function which will handle the added to stage event for the component
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function onAddedTostage(event:Event):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedTostage);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		/**
		 * @param event of type MouseEvent
		 * function which will handle the mouseMoveHandler for the component
		 * @author Rajesh 
		 * @date 17 feb 2011
		 **/
		private function onMouseMove(event:MouseEvent):void
		{
			(event.buttonDown && (getChildByName(RESIZE_CONTROL) == target)) ? doMove() : target = null;
			
		}
		
		/**
		 * @param event of type MouseEvent
		 * function which will handle the mouseDown event for the stage
		 * @author Rajesh 
		 * @date 17 feb 2011
		 **/
		private function onMouseDown(event:MouseEvent):void 
		{
			mouseDownPoint = new Point(mouseX, mouseX);
			target = event.target as DisplayObject;
		}
		
		/**
		 * @param event of type MouseEvent
		 * function which will handle the mouseUp event for the stage
		 * @author Rajesh 
		 * @date 17 feb 2011
		 **/
		private function onMouseUp(event:MouseEvent):void 
		{
			target = null;
			drawLineDirection();
			
		}
		
		/**
		 * @param event of type MouseEvent
		 * function which will handle the mouseOver event for the stage 
		 * @author Rajesh 
		 * @date 17 feb 2011
		 **/
		private function onMouseOver(event:MouseEvent):void 
		{
			
			switch(event.target.name)
			{
				case RESIZE_CONTROL:
				{
					(target) ? (target.name == RESIZE_CONTROL) ? drawResizeIndicator() : "" : drawResizeIndicator();
					break;
					
				}
					
			}
			
		}
		/**
		 * @param event of type MouseEvent
		 * function which will handle the mouseOut event 
		 * @auhor Rajesh 
		 * @date 17 feb 2011
		 **/
		private function onMouseOut(event:MouseEvent):void 
		{
			
			if(!event.buttonDown || target != getChildByName(RESIZE_CONTROL))
			{
				drawLineDirection();
			}
				
			
			
		}
		
	}
}