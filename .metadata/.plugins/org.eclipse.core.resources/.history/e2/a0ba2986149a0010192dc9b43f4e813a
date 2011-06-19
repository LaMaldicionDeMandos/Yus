package com.marce.framework.ioc.injection
{
	internal class MapperImpl implements Mapper
	{
		private var _builders:Vector.<MappingBuilder>;
		
		public function MapperImpl()
		{
			_builders = new Vector.<MappingBuilder>();
		}
		
		public function get mappings():Vector.<Mapping>{
			var _mappings:Vector.<Mapping> = new Vector.<Mapping>();
			for each(var builder:MappingBuilder in _builders){
				_mappings.push(builder.mapping);
			}
			return _mappings;
		}
		
		public function map(type:Class):MappingBuilder{
			var builder:MappingBuilder = new MappingBuilderImpl();
			builder.map(type);
			_builders.push(builder);
			return builder;
		}
	}
}