package {
	// width of 75 for bricks
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.MouseEvent;


	public class BrickBreaker extends MovieClip {
		//GAME DATA
		private const BALL_RADIUS: Number = 15;
		private const TOPBORDER: Number = BALL_RADIUS;
		private const LEFTBORDER: Number = BALL_RADIUS;
		private const RIGHTBORDER: Number = 600 - BALL_RADIUS;
		private const BOTTOMBORDER: Number = 600 - BALL_RADIUS;

		private var ball: Ball;
		private var lastTimeStamp: uint;

		private var brickList: Array;

		private var brick: Brick;

		private var platform: Platform;

		public function BrickBreaker() {
			//TASK 1: POSITION THE START LABEL
			startLabel.x = 300;
			startLabel.y = 300;

			//TASK 2: REGISTER A LISTENER EVENT FOR A STAGE CLICK
			stage.addEventListener(MouseEvent.CLICK, startGame);

		}

		//***********************************************************

		//EVENT HANDLER FOR THE STAGE CLICK
		public function startGame(event: Event) {
			//TASK 1: MOVE THE START LABEL OFF THE SCREEN
			startLabel.x = -300;
			startLabel.y = 300;

			//TASK 2: REMOVE THE EVENT LISTENER
			removeEventListener(MouseEvent.CLICK, startGame);

			//TASK 3: CREATE A BALL WITH VELOCITY AND ADD TO SCREEN
			ball = new Ball(250, 250);
			addChild(ball);

			//TASK 4: SET UP THE ANIMATION
			lastTimeStamp = getTimer();
			addEventListener(Event.ENTER_FRAME, moveObjects);

			//ADD BRICKS TO SCREEN WITH AN ARRAY
			brickList = new Array();
			var gap: Number = 119;
			for (var row: Number = 30; row < 160; row += 55) {
				for (var posX: Number = 34; posX < 600; posX += gap) {
					var brick = new Brick(posX, row);
					addChild(brick);
					brickList.push(brick);
				}
			}

			//ADD PLATFORM TO THE STAGE
			platform = new Platform(300, 580);
			addChild(platform);


			//ADD EVENT LISTENER TO FOLLOW MOUSE
			addEventListener(Event.ENTER_FRAME, followMouse);


		}

		public function moveObjects(event: Event) {
			moveBall();
		}

		//***********************************************************

		public function moveBall() {
			//TASK 1 : COMPUTE THE ELAPSED TIME
			var elapsedTime = getTimer() - lastTimeStamp;
			lastTimeStamp += elapsedTime;

			//COMPUTE NEW LOCATION
			ball.x += ball.vx * elapsedTime / 1000;
			ball.y += ball.vy * elapsedTime / 1000;

			//CHECK FOR COLLISIONS
			if (ball.y < TOPBORDER) {
				ball.vy *= -1;
				ball.y = TOPBORDER;
			} else if (ball.y > BOTTOMBORDER) {
				//ball.vy = 0;
				//ball.vx = 0;
				endGame();
			}

			if (ball.x < LEFTBORDER) {
				ball.vx *= -1;
				ball.x = LEFTBORDER;
			} else if (ball.x > RIGHTBORDER) {
				ball.vx *= -1;
				ball.x = RIGHTBORDER;
			}

			for (var iBrick: int = brickList.length - 1; iBrick >= 0; iBrick--) {

				//BULLET AND PLANE COLLIDE
				if (ball.hitTestObject(brickList[iBrick])) {
					ball.vy *= -1;
					brickList[iBrick].deleteBrick();
					break;
				}
			}

			if (ball.hitTestObject(platform)) {
				ball.y -= 2;
				ball.vy *= -1;
			}

		}

		public function removeBrick(brick: Brick) {
			// SEARCH FOR THE BULLET AND REMOVE IT FROM THE ARRAY: USE SPLICE
			for (var i in brickList) {
				if (brickList[i] == brick) {
					brickList.splice(i, 1);
					break;
				}
			}
		}

		public function followMouse(event: Event) {
			platform.x = mouseX;
		}

		public function endGame() {
			for (var i: Number = 0; i < brickList.length; i += 1) {
				brickList[i].deleteBrick();
				break;
			}

			removeEventListener(Event.ENTER_FRAME, followMouse);
			addEventListener(Event.ENTER_FRAME, moveObjects);

			ball.deleteBall();
			trace("ball is deleted");
			platform.deletePlatform();
			trace("platform is deleted");

			startLabel.x = 300;
			startLabel.y = 300;

			stage.addEventListener(MouseEvent.CLICK, startGame);
		}

	}

}