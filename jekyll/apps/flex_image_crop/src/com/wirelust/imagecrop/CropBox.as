/*
Copyright 2010 Terrence Curran - Approaching Pi

Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an &quot;AS IS&quot; BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
package com.wirelust.imagecrop {
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.core.*;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.graphics.SolidColor;
	import mx.graphics.Stroke;
	
	
	public class CropBox extends UIComponent {
		public static var EVENT_CHANGED:String = "crop.changed";

		public var cropMaxHeight:int = 0;
		public var cropMinHeight:int = 0;
		public var cropMaxWidth:int = 0;
		public var cropMinWidth:int = 0;
		public var keepAspectRatio:Boolean = false;

		private var _cropX:Number = -1;
		private var _cropY:Number = -1;
		private var _cropWidth:Number = 0;
		private var _cropHeight:Number = 0;

		private var handleNw:CropHandle = new CropHandle();
		private var handleNe:CropHandle = new CropHandle();
		private var handleSw:CropHandle = new CropHandle();
		private var handleSe:CropHandle = new CropHandle();
		private var _handleSize:Number = 5;

		private var activeHandle:CropHandle;
		private var boxMoving:Boolean = false;
		
		private var lastMouseX:Number = 0;
		private var lastMouseY:Number = 0;
		
		private var shiftIsPressed:Boolean = false;
		
		public function CropBox() {
			_handleSize = handleNw.size;
			this.addChild(handleNw);
			this.addChild(handleNe);
			this.addChild(handleSw);
			this.addChild(handleSe);

			handleNw.addEventListener(MouseEvent.MOUSE_DOWN, handleDownEvent);

			handleNe.addEventListener(MouseEvent.MOUSE_DOWN, handleDownEvent);

			handleSw.addEventListener(MouseEvent.MOUSE_DOWN, handleDownEvent);

			handleSe.addEventListener(MouseEvent.MOUSE_DOWN, handleDownEvent);
			
			addEventListener(MouseEvent.MOUSE_DOWN, boxDownEvent);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
			addEventListener(Event.MOUSE_LEAVE, mouseUpEvent);
			
			addEventListener(Event.ADDED_TO_STAGE, function( e:Event ):void {
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardDownEvent);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyboardUpEvent);
			});
		}
		
		public function set handleSize(value:Number):void {
			_handleSize = value;
			handleNw.size = value;
			handleNe.size = value;
			handleSw.size = value;
			handleSe.size = value;
		}
		
		public function get handleSize():Number {
			return _handleSize;
		}
		
		public function boxDownEvent(me:MouseEvent):void {
			if (activeHandle != null) {
				return;
			}

			/*
			ExternalInterface.call("console.log", "boxDownEvent " +
				"mouseX:" + mouseX +
				" cropX:" + cropX +
				" mouseY:" + mouseY +
				" cropY:" + cropY +
				" cropWidth:" + cropWidth +
				" cropHeight:" + cropHeight);
			*/

			if (mouseX >= cropX &&
				mouseX <= cropX + cropWidth &&
				mouseY >= cropY &&
				mouseY <= cropY + cropHeight) {
					
				boxMoving = true;
	
				lastMouseX = mouseX;
				lastMouseY = mouseY;
				addEventListener(MouseEvent.MOUSE_MOVE, mouseBoxMoveEvent);
				me.stopPropagation();
			} else {
				cropX = mouseX;
				cropY = mouseY;
				cropWidth = 0;
				cropHeight = 0;
				invalidateDisplayList();
				
				setHandleHeld(handleSe);
			}
		}
		
		public function keyboardDownEvent(ke:KeyboardEvent):void {
			if (ke.shiftKey) {
				shiftIsPressed = true;
			}
		}

		public function keyboardUpEvent(ke:KeyboardEvent):void {
			if (!ke.shiftKey) {
				shiftIsPressed = false;
			}
		}

		public function mouseBoxMoveEvent(me:MouseEvent):void {
			if (!boxMoving) {
				return;
			}
			
			var changeMouseX:Number = lastMouseX - mouseX;
			var changeMouseY:Number = lastMouseY - mouseY;
			
			var newMouseX:Number = _cropX - changeMouseX;
			var newMouseY:Number = _cropY - changeMouseY;
			
			
			//ExternalInterface.call("console.log", "box move event x:" + newMouseX + " y:" + newMouseY + " height:" + cropHeight + " width:" + cropWidth);
			
			if (newMouseX >= 0 &&
				newMouseY >= 0 &&
				newMouseX + _cropWidth <= width &&
				newMouseY + _cropHeight <= height) {
				
				_cropX = newMouseX;
				_cropY = newMouseY;
				
				moveHandles();
			}

			lastMouseX = mouseX;
			lastMouseY = mouseY;
		}
		
		public function mouseMoveEvent(me:MouseEvent):void {
			if (activeHandle == null) {
				return;
			}
			
			var changeMouseX:Number = lastMouseX - mouseX;
			var changeMouseY:Number = lastMouseY - mouseY;


			// keep the square
//			if (activeHandle == handleNw || activeHandle == handleSe) {
//				changeMouseX = changeMouseY = (Math.abs(changeMouseX) > Math.abs(changeMouseY)) ? changeMouseX : changeMouseY;
//			} else {
//				if (Math.abs(changeMouseX) > Math.abs(changeMouseY)) {
//					changeMouseY = -1 * changeMouseX;
//				} else {
//					changeMouseX = -1 * changeMouseY;
//				}
//			}

			var newMouseX:Number = activeHandle.x - changeMouseX;
			var newMouseY:Number = activeHandle.y - changeMouseY;
			//ExternalInterface.call("console.log", "move event changeX:" + changeMouseX + " changeY:" + changeMouseY + " newMouseX:" + newMouseX + " newMouseY:" + newMouseY);



			//ExternalInterface.call("console.log", "move event changeX:" + changeMouseX + " changeY:" + changeMouseY + " newMouseX:" + newMouseX + " newMouseY:" + newMouseY);
			
			if (activeHandle == handleNw) {
				handleNwMoveEvent(newMouseX, newMouseY);
			} else if (activeHandle == handleNe) {
				handleNeMoveEvent(newMouseX, newMouseY);
			} else if (activeHandle == handleSw) {
				handleSwMoveEvent(newMouseX, newMouseY);
			} else if (activeHandle == handleSe) {
				handleSeMoveEvent(newMouseX, newMouseY);
			}
			
			lastMouseX = mouseX;
			lastMouseY = mouseY;
			
		}
		
		public function mouseUpEvent(me:MouseEvent):void {
			if (activeHandle != null) {
				//activeHandle.stopDrag();
				activeHandle = null;
				removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent);
			}
			if (boxMoving) {
				boxMoving = false;
				removeEventListener(MouseEvent.MOUSE_MOVE, mouseBoxMoveEvent);
			}
		}

		private function setHandleHeld(handle:CropHandle):void {
			if (boxMoving) {
				return;
			}
			activeHandle = handle;
			lastMouseX = mouseX;
			lastMouseY = mouseY;
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
		}

		private function handleDownEvent(me:MouseEvent):void {
			if (boxMoving) {
				return;
			}
			activeHandle = CropHandle(me.target);
			lastMouseX = mouseX;
			lastMouseY = mouseY;
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
			me.stopPropagation();
		}

		//
		// NW
		//
		private function handleNwMoveEvent(newMouseX:Number, newMouseY:Number):void {
			var newWidth:Number = handleNe.x - newMouseX;
			var newHeight:Number = handleSw.y - newMouseY;
			
			resizeCrop(newMouseX, newMouseY, newWidth, newHeight);
		}

		//
		// NE
		//
		private function handleNeMoveEvent(newMouseX:Number, newMouseY:Number):void {
			var newWidth:Number = newMouseX - handleNw.x;
			var newHeight:Number = handleSw.y - newMouseY;
			
			resizeCrop(_cropX, newMouseY, newWidth, newHeight);
		}

		//
		// SW
		//
		private function handleSwMoveEvent(newMouseX:Number, newMouseY:Number):void {
			var newWidth:Number = handleNe.x - newMouseX;
			var newHeight:Number = newMouseY - handleNw.y;
			
			resizeCrop(newMouseX, _cropY, newWidth, newHeight);
		}

		//
		// SE
		//
		private function handleSeMoveEvent(newMouseX:Number, newMouseY:Number):void {
			var newWidth:Number = newMouseX - handleNw.x;
			var newHeight:Number = newMouseY - handleNw.y;
			
			resizeCrop(_cropX, _cropY, newWidth, newHeight);
		}
		
		private function resizeCrop(newX:Number, newY:Number, newWidth:Number, newHeight:Number):void {
			if (newWidth >= cropMinWidth &&
					newHeight >= cropMinHeight &&
					newX >= 0 &&
					newX <= width &&
					newY >= 0 &&
					newY <= height &&
					(cropMaxWidth == 0 || newWidth <= cropMaxWidth)
					) {

				if (keepAspectRatio || shiftIsPressed) {
					var aspectRatio:Number = _cropWidth / _cropHeight;
					var newWidthAspect:Number = newHeight * aspectRatio;
					var newHeightAspect:Number = newWidth / aspectRatio;
					if (newWidthAspect > newWidth) {
						if (activeHandle == handleNw || activeHandle == handleSw) {
							newX = newX + newWidth - newWidthAspect;
						}
						newWidth = newWidthAspect;
					}
					if (newHeightAspect > newHeight) {
						if (activeHandle == handleNw || activeHandle == handleNe) {
							newY = newY + newHeight - newHeightAspect;
						}
						newHeight = newHeightAspect;
					}
				}
						
				_cropX = newX;
				_cropY = newY;
				_cropWidth = newWidth;
				_cropHeight = newHeight;
				moveHandles();
			}
		}

		public function get cropX():Number {
			return _cropX;
		}
		public function get cropY():Number {
			return _cropY;
		}
		public function get cropWidth():Number {
			return _cropWidth;
		}
		public function get cropHeight():Number {
			return _cropHeight;
		}
		public function set cropX(i:Number):void {
			_cropX = i;
			moveHandles();
		}
		public function set cropY(i:Number):void {
			_cropY = i;
			moveHandles();
		}
		public function set cropWidth(i:Number):void {
			_cropWidth = i;
			moveHandles();
		}
		public function set cropHeight(i:Number):void {
			_cropHeight = i;
			moveHandles();
		}
		
		protected function moveHandles():void {
			
			handleNw.x = cropX;
			handleNw.y = cropY;

			handleNe.x = cropX + cropWidth;
			handleNe.y = cropY;
		
			handleSw.x = cropX;
			handleSw.y = cropY + cropHeight;
		
			handleSe.x = cropX + cropWidth;
			handleSe.y = cropY + cropHeight;

			dispatchEvent(new Event(EVENT_CHANGED));

			this.invalidateDisplayList();
		}
		
		override protected function updateDisplayList(param1:Number, param2:Number):void {
			//ExternalInterface.call("console.log", "crop x:" + cropX + " y:" + cropY + " height:" + cropHeight + " width:" + cropWidth);
			super.updateDisplayList(param1, param2);
			graphics.clear();

			graphics.beginFill(0x000000, 0); // zero fill so we have something for the mouse to grab
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
			
			if (cropWidth > 0 && cropHeight > 0) {
				// top mask
				graphics.beginFill(0x000000, .5);
				graphics.drawRect(0, 0, width, cropY);
				graphics.endFill();
	
				// left mask
				graphics.beginFill(0x000000, .5);
				graphics.drawRect(0, cropY, cropX, cropHeight);
				graphics.endFill();
	
				// right mask
				graphics.beginFill(0x000000, .5);
				graphics.drawRect(cropX+cropWidth, cropY, width-cropX-cropWidth, cropHeight);
				graphics.endFill();
	
				// bottom mask
				graphics.beginFill(0x000000, .5);
				graphics.drawRect(0, cropY+cropHeight, width, height-cropY-cropHeight);
				graphics.endFill();
			}
			
			// crop box
			graphics.beginFill(0x000000, 0); // zero fill so we have something for the mouse to grab
			graphics.lineStyle(1, 0x000000, 1, true, LineScaleMode.NONE);
			graphics.drawRect(cropX, cropY, cropWidth, cropHeight);
			graphics.endFill();
		}
		
	}
}