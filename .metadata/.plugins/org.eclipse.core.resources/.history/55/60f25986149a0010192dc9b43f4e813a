package org.opensource.pasut.yus.injection
{
	internal class MappingBuilderImpl implements MappingBuilder
	{
		private var _mapping:Mapping;
		public function MappingBuilderImpl()
		{
		}
		
		public function map(type:Class):MappingBuilder{
			_mapping = MappingFactory.createMapping(type);
			return this;
		}
		
		public function to(type:Class):MappingBuilder{
			_mapping.to = type;
			return this;
		}
		
		public function named(name:String):MappingBuilder{
			_mapping = MappingFactory.getMappingWithName(_mapping,name);
			return this;
		}
		
		public function toInstance(object:Object):MappingBuilder{
			_mapping = MappingFactory.getMappingToInstance(_mapping,object);
			return this;
		}
		
		public function toFactory(type:Class):MappingBuilder{
			_mapping = MappingFactory.getMappingToFactory(_mapping,type);
			return this;
		}
		
		public function asSingleton():void{
			_mapping.asSingleton();
		}
		
		public function get mapping():Mapping{
			return _mapping;
		}
		
		public function get mappingName():String{
			return _mapping.name;
		}
	}
}