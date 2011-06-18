package com.marce.framework.ioc.injection
{
	public class MapperFactory
	{
		public static function createMapper():Mapper{
			return new MapperImpl();
		}
	}
}