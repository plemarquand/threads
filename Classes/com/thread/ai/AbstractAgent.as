package com.thread.ai
{

	import com.thread.Thread;
	import com.thread.constant.ThreadConstants;
	import com.thread.vo.IMotionable;
	import com.thread.vo.IRandomizable;
	import com.util.NumberUtils;
	import flash.errors.IllegalOperationError;

	/**
	 * @author Paul
	 */
	public class AbstractAgent implements IAgent, IRandomizable
	{
		protected var _target : IMotionable;
		protected var _index : int;
		protected var _worldAgents : Array;
		private var _ctr : Number;
		private var _followTarget : IMotionable;
		private var _isLeader : Boolean;
		private var _leader : Thread;
		private var _maxDistAchieved : Boolean;

		public function AbstractAgent(target : IMotionable)
		{
			_target = target;
			_ctr = 0;
		}

		public function update() : void
		{
			var dist : Number = getDistance();
			var angle : Number = getAngle();

			// This is the money equation!
			_target.angle += NumberUtils.radToDegree( angle ) / (1 + ( 1 - dist / ThreadConstants.MANAGER_WIDTH / 2)) * ((_index / _worldAgents.length) * Math.PI);
			_ctr += 1;

			if (_isLeader)
			{
				run();
			}
		}

		public function run() : void
		{
			updateFollowTarget();
		}

		public function randomize() : void
		{
			throw new IllegalOperationError( "randomize() not implemented in" + this );
		}

		public function setModifiers(...args) : void
		{
			_worldAgents = args[0];
			_index = args[1];
			_leader = _worldAgents[0];
			_isLeader = (_index == 0);

			var prevThread : Thread = _worldAgents[Math.max( 0, _index - 1 )];
			var currThread : Thread = _worldAgents[ _index ];

			if (! _maxDistAchieved || _isLeader)
			{
				var perc : Number = _index / _worldAgents.length;
				_target.speed = _target.initialSpeed * (1 - perc) + _target.initialSpeed * (perc * ThreadConstants.FOLLOW_TIGHTNESS);
				
				if (! _isLeader)
				{
					var distanceToFollowTarget : Number = NumberUtils.distance( currThread.data.x, currThread.data.y, prevThread.data.x, prevThread.data.y );
					if (distanceToFollowTarget > currThread.data.lineSize * 8 )
					{
						_maxDistAchieved = true;
					}
				}
			}
			else
			{
				_target.speed = prevThread.data.speed;
			}

			updateFollowTarget();
		}

		public function set target(t : IMotionable) : void
		{
			_target = t;
		}

		protected function getDistance() : Number
		{
			var nX : Number = _followTarget.x - _target.x;
			var nY : Number = _followTarget.y - _target.y;
			return Math.sqrt( nX * nX + nY * nY );
		}

		protected function getAngle() : Number
		{
			var nX : Number = _followTarget.x - _target.x;
			var nY : Number = _followTarget.y - _target.y;
			var rad : Number = Math.atan2( nY, nX );
			var angle : Number = rad - NumberUtils.degreeToRad( _target.angle ) % 360;
			while (angle < -Math.PI) angle += 2 * Math.PI;
			while (angle > Math.PI) angle -= 2 * Math.PI;
			return angle;
		}

		private function updateFollowTarget() : void
		{
			var target : Thread = ( _isLeader) ? (_worldAgents[Math.floor( _worldAgents.length * Math.random() )]) : (_worldAgents[_index - 1]);
			_followTarget = target.data;
		}
	}
}
