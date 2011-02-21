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
	import flash.errors.EOFError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	
	
	
	public class Navigator extends Sprite
	{
		
		public static const CENTER_NAVIGATOR:String = "CENTER_NAVIGATOR";
		public static const ROTATOR_CONTROL:String = "ROTATOR_CONTROL";
		public static const ROTATION_INDICATOR:String = "ROTATION_INDICATOR";
		
		public static const TRACK_WIDTH_PERCENTAGE:Number = 40;
		public static const CENTER_NAVIGATOR_WIDTH_PERCENTAGE:Number = 10;
		
		private var mousePoint:Point;
		public var angleofRotation:Number = 0;
		private var _radius:Number;
		private var _currentTarget:DisplayObject;
		private var _alpha:Number = 0.5;
		private var stagePoint:Point;
		
		/**
		 * Constructor function 
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/ 
		public function Navigator()
		{
			super();
			addCenterNavigator();
			addRotatorCotrol();
			addRotationIndicator();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToSatge);
		}
		
		/**
		 * @param value of type Number 
		 * setter function for the variable _radius
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		public function set radius(value:Number):void
		{
			
			_radius = value;
			addRotationTrack();
			positionRotatorControl();
			updateCenterNavigator();
			
		}
		
		/**
		 * @param of type null
		 * @return _radius of type Number
		 * getter function for _radius
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		public function get radius():Number
		{
			
			return _radius;
			
			
		}
		
		
		/**
		 * @param of type null
		 * function which will add the rotator indicator for the navigator component
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function addRotationIndicator():void 
		{
			
			var rotatorIndicator:Sprite = new Sprite();
			rotatorIndicator.name = ROTATION_INDICATOR;
			addChild(rotatorIndicator);
			rotatorIndicator.visible = false;
		}
		
		
		/**
		 * @param of type null
		 * function which will draw the rotator Indicator
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function drawRotatorIndicator():void 
		{
			var indicatorRadius:Number = radius + radius * (10 / 100);
			var rotatorIndicator:Sprite = getChildByName(ROTATION_INDICATOR) as Sprite;
			rotatorIndicator.rotation = angleofRotation + 30;
			rotatorIndicator.graphics.clear();
			rotatorIndicator.visible = true;
			rotatorIndicator.graphics.lineStyle(2, 0x000000);
			MathHelper.halfCircle(rotatorIndicator.graphics, 0, 0, indicatorRadius);
			var p:Point = Point.polar(indicatorRadius, MathHelper.degreeToRadian(180));
			MathHelper.drawArrow(rotatorIndicator.graphics, p, indicatorRadius, 0, 10);
			p = Point.polar(indicatorRadius, MathHelper.degreeToRadian(0));
			MathHelper.drawArrow(rotatorIndicator.graphics, p, indicatorRadius, 0, 10);
		}
		
		/**
		 * @param of type null
		 * function which will draw the move Indicator
		 * @author Rajesh 
		 * @date 17 feb 2011
		 **/
		private function drawMoveIndicator():void 
		{
			var indicatorRadius:Number = radius  * (TRACK_WIDTH_PERCENTAGE / 100);
			var moveIndicator:Sprite = getChildByName(CENTER_NAVIGATOR) as Sprite;
			moveIndicator.visible = true;
			moveIndicator.rotation = angleofRotation;
			moveIndicator.graphics.lineStyle(2, 0x000000);
			var angle:Number = 0;
			for(var i:int = 0; i < 4; i++)
			{
				moveIndicator.graphics.moveTo(0, 0);
				var p:Point = Point.polar(indicatorRadius, MathHelper.degreeToRadian(angle));
				moveIndicator.graphics.lineTo(p.x, p.y);
				MathHelper.drawArrow(moveIndicator.graphics, p, indicatorRadius, (angle + 90), 30);
				angle += 90;
			}
			
			
			
		}
		
		
		/**
		 * @param of type null
		 * function which will add the center navigator for the navigator 
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/ 
		private function addCenterNavigator():void 
		{
			
			var sprite:Sprite = new Sprite();
			sprite.name = CENTER_NAVIGATOR;
			sprite.buttonMode = true;
			sprite.useHandCursor = true;
			sprite.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			sprite.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addChild(sprite);
		}
		
		
		/**
		 * @param of type null
		 * function which will update the center navigator size
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function updateCenterNavigator():void 
		{
			var navigatorRadius:Number = (radius) * (CENTER_NAVIGATOR_WIDTH_PERCENTAGE / 100)
			var centerNavigator:Sprite = getChildByName(CENTER_NAVIGATOR) as Sprite;
			centerNavigator.graphics.clear();
			centerNavigator.graphics.lineStyle(1, 0x000000, _alpha);
			centerNavigator.graphics.beginFill(0xFFFFFF, _alpha);
			centerNavigator.graphics.drawCircle(0, 0, navigatorRadius);
			centerNavigator.graphics.endFill();
			(_currentTarget == centerNavigator) ? drawMoveIndicator() : "";
			
		}
		
		
		/**
		 * @param of type null
		 * function which will add the ratation track fro the component 
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function addRotationTrack():void
		{
			var trackWidth:Number = radius * (TRACK_WIDTH_PERCENTAGE / 100);
			graphics.clear();
			graphics.lineStyle(1, 0x000000, _alpha);
			graphics.beginFill(0xFFFFFF, _alpha);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
			graphics.beginFill(0xFFFFFF, 0.0);
			graphics.drawCircle(0, 0, (radius - trackWidth));
			
		}
		
		/**
		 * @param of type null
		 * function which will add the roatator control for the Navigator
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function addRotatorCotrol():void 
		{
			var rotatorControl:Sprite = new Sprite();
			rotatorControl.name = ROTATOR_CONTROL;
			rotatorControl.buttonMode = true;
			rotatorControl.useHandCursor = true;
			rotatorControl.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			rotatorControl.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addChild(rotatorControl);
		}
		
		
		/**
		 * @param of type null
		 * function which will set the position fro the rotator
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function positionRotatorControl():void 
		{
			var trackWidth:Number = radius * (TRACK_WIDTH_PERCENTAGE / 100);
			var position:Point = Point.polar((radius - (trackWidth / 2)), MathHelper.degreeToRadian(angleofRotation));
			var rotatorControl:Sprite = getChildByName(ROTATOR_CONTROL) as Sprite;
			
			rotatorControl.graphics.clear();
			rotatorControl.graphics.lineStyle(1, 0x000000, _alpha);
			rotatorControl.graphics.beginFill(0xFFFFFF, 1);
			rotatorControl.graphics.drawCircle(0, 0, ((trackWidth / 2) - 2));
			rotatorControl.graphics.endFill();
			rotatorControl.x = position.x;
			rotatorControl.y = position.y;
		}
		
		/**
		 * @param of type null
		 * function which will determine the angle of rotation for
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function determineAngle():void 
		{
			var child:DisplayObject = getChildByName(CENTER_NAVIGATOR);
			angleofRotation = MathHelper.getAngleBetweenPoints(localToGlobal(new Point(child.x, child.y)), mousePoint);
			positionRotatorControl();
			var event:TransformEvent = new TransformEvent(TransformEvent.ROTATE);
			event.rotationAngle = angleofRotation;
			dispatchEvent(event);
			drawRotatorIndicator();
		}
		
		/**
		 * @param of type null
		 * function which will hide all the indicators
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function hideIndicators():void 
		{
			
			getChildByName(ROTATION_INDICATOR).visible = false;
			updateCenterNavigator();
		}
		
		
		
		/********************************************************************/
		/****************Functions for event handling************************/
		/********************************************************************/
		
		/**
		 * @param event of type Event
		 * function which will handle the added to stage event for the Navigator
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function onAddedToSatge(event:Event):void 
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToSatge);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		/**
		 * @param event of type MouseEvent
		 * function which will handle the mouseMoveHandler for the CENTER_NAVIGATOR
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function onMouseMove(event:MouseEvent):void
		{
			
			mousePoint = localToGlobal((new Point(this.mouseX, this.mouseY)));
			(event.buttonDown) ? (_currentTarget.name == ROTATOR_CONTROL) ? determineAngle() : 
				(_currentTarget.name == CENTER_NAVIGATOR) ? doMove(event) : "" : [_currentTarget = null]; 
			
		}
		
		/**
		 * @param event of type MouseEvent
		 * function which will handle the mouseDown event for the stage
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function onMouseDown(event:MouseEvent):void 
		{
			_currentTarget = event.target as DisplayObject;
			stagePoint = new Point(event.stageX, event.stageY);
		}
		
		/**
		 * @param event of type mouseEvent
		 * funcltion which will calculate the distance and angle of movement
		 * @author Rajesh 
		 * @date 14 feb 2011
		**/
		private function doMove(event:MouseEvent):void
		{
			var moveEvent:TransformEvent = new TransformEvent(TransformEvent.MOVE);
			var currentPoint:Point = new Point(event.stageX, event.stageY);
			moveEvent.moveAngle = MathHelper.getAngleBetweenPoints(stagePoint, currentPoint);
			moveEvent.distance = MathHelper.getDistanceBetweenPoints(stagePoint, currentPoint);
			dispatchEvent(moveEvent);
			stagePoint = currentPoint;
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
				
				case ROTATOR_CONTROL:
				{
					(_currentTarget) ? (_currentTarget.name == ROTATOR_CONTROL) ? drawRotatorIndicator() : "" : drawRotatorIndicator();
					break;
					
				}
			    case CENTER_NAVIGATOR:
				{
					(_currentTarget) ? (_currentTarget.name == CENTER_NAVIGATOR) ? drawMoveIndicator() : "" : drawMoveIndicator();
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
			
			if(!event.buttonDown)
			{
				getChildByName(ROTATION_INDICATOR).visible = false;
				updateCenterNavigator();
				
			}else if(_currentTarget != getChildByName(ROTATION_INDICATOR))
			{
				getChildByName(ROTATION_INDICATOR).visible = false;
			}else if(_currentTarget != getChildByName(CENTER_NAVIGATOR))
			{
				
				updateCenterNavigator();
				
			}
			
		}
		
		/**
		 * @param event of type MouseEvent
		 * function which will handle the mouseUp event for the stage
		 * @author Rajesh 
		 * @date 17 feb 2011
		**/
		private function onMouseUp(event:MouseEvent):void 
		{
			
			hideIndicators();
			
		}
		
		
		
	}
}