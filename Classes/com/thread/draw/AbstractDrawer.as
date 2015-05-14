package com.thread.draw 
{
	import com.thread.vo.IRandomizable;

	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;

	/**
	{
		protected var _modifiers : Array;

		public function AbstractDrawer() 
		{
			randomize();
		}

		public function draw(drawTarget : Sprite, lines : Array) : void
		{
			throw new IllegalOperationError( "draw() not implemented in" + this );

		public function randomize() : void
		{
			throw new IllegalOperationError( "randomize() not implemented in" + this );
		}
		
		public function setModifiers(...args) : void
		{
			_modifiers = args;
		}
	}