package com.thread.ai 
{
	import com.thread.ai.AbstractAgent;
	import com.thread.ai.IAgent;
	import com.thread.vo.IMotionable;

	/**
	 * @author Paul
	 */
	public class SimpleAgent extends AbstractAgent implements IAgent 
	{
		public var angleIncrement : Number = .1;
		
		public function SimpleAgent(target : IMotionable)
		{
			super( target );
		}

		override public function update() : void
		{
			_target.angle = angleIncrement;
		}

		override public function randomize() : void
		{
		}
	}
}
