package com.thread.transform 
{
	import com.geom.Line;
	import com.thread.constant.ThreadConstants;
	import com.thread.vo.IPositionable;
	import com.util.Randomizer;

	/**
	 * @author Paul
	 */
	public class FourWayIntermittentTransform extends AbstractTransform implements IDrawTransform 
	{
		protected var _drawProbability : Number = .95;

		public function FourWayIntermittentTransform()
		{
			super();
		}

		override public function transform(d : IPositionable) : Array
		{
			var lines : Array = [];
			
			if(Math.random( ) > _drawProbability)
			{
				lines.push( new Line( d.prevX, d.prevY, d.x, d.y ) );
				
				//drawTarget.graphics.moveTo( d.prevX, d.prevY );
				//drawTarget.graphics.lineTo( d.x, d.y ) ;
			}
			if(Math.random( ) > _drawProbability)
			{
				lines.push( new Line( -d.prevX + ThreadConstants.MANAGER_WIDTH, d.prevY, -d.x + ThreadConstants.MANAGER_HEIGHT, d.y ) );
				
				//drawTarget.graphics.moveTo( ( -d.prevX + ThreadConstants.MANAGER_WIDTH ), d.prevY );
				//drawTarget.graphics.lineTo( ( -d.x + ThreadConstants.MANAGER_HEIGHT ), d.y );
			}
			if(Math.random( ) > _drawProbability)
			{
				lines.push( new Line( d.prevX, -d.prevY + ThreadConstants.MANAGER_HEIGHT, d.x, -d.y + ThreadConstants .MANAGER_HEIGHT ) );
				
				//drawTarget.graphics.moveTo( d.prevX, (-d.prevY + ThreadConstants.MANAGER_HEIGHT) );
				//drawTarget.graphics.lineTo( d.x, -d.y + ThreadConstants .MANAGER_HEIGHT );
			}
			if(Math.random( ) > _drawProbability)
			{
				lines.push( new Line( -d.prevX + ThreadConstants.MANAGER_WIDTH, -d.prevY + ThreadConstants.MANAGER_HEIGHT, -d.x + ThreadConstants.MANAGER_WIDTH, -d.y + ThreadConstants .MANAGER_HEIGHT ) );
				//drawTarget.graphics.moveTo( ( -d.prevX + ThreadConstants.MANAGER_WIDTH ), (-d.prevY + ThreadConstants.MANAGER_HEIGHT ) );
				//drawTarget.graphics.lineTo( ( -d.x + ThreadConstants.MANAGER_WIDTH ), -d.y + ThreadConstants .MANAGER_HEIGHT );
			}
			return lines;
		}

		public function get drawProbability() : Number
		{
			return _drawProbability;	
		}

		public function set drawProbability(n : Number) : void
		{
			_drawProbability = n;
		}

		override public function randomize() : void
		{
			var randomizer : Randomizer = new Randomizer( );
			randomizer.addRule( Number, "drawProbability", .8, 1 );
			randomizer.randomize( this );
		}
	}
}
