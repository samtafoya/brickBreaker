package  {
	
	import flash.display.MovieClip;
	
	
	public class Platform extends MovieClip {
		
		
		public function Platform(positionX: Number, positionY: Number) {
			this.x = positionX;
			this.y = positionY;
		}
		
		public function deletePlatform() {		
			trace("delete platform");
			parent.removeChild(this);
		}
		
	}
	
}
