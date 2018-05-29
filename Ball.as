package  {
	import flash.display.MovieClip;
	
	public class Ball extends MovieClip {
		// DATA MEMBERS
		public var vx: Number; //velocity along x axis
		public var vy: Number; //velocity along y axis
		
		public function Ball(velocityX: Number, velocityY: Number) {
			this.x = 300;
			this.y = 300;
			
			vx = velocityX;
			vy = velocityY;
			
		}
		
		public function deleteBall() {
			trace("delete ball");
			parent.removeChild(this);
		}

	}
	
}
