package  {
	
	import flash.display.MovieClip;
	
	
	public class Brick extends MovieClip {
		
		
		public function Brick(positionX: Number, positionY: Number) {
			this.x = positionX;
			this.y = positionY;
		}
		
		public function deleteBrick() {
			MovieClip(parent).removeBrick(this);	
			parent.removeChild(this);
		}
	}
	
}
