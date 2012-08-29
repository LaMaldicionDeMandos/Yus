package org.opensource.pasut.yus.injection
{
	public interface YusCreator
	{
		function create( type:Class, params:Array):Object;
	}
}