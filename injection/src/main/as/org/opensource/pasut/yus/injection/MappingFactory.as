package org.opensource.pasut.yus.injection
{
	internal class MappingFactory
	{
		public static function createMapping(type:Class):Mapping{
			return new MappingImpl(type);
		}
		
		public static function getMappingWithName(mapping:Mapping,name:String):Mapping{
			var copy:MappingImpl = mapping.copy() as MappingImpl;
			copy.name = name;
			return copy;
		}
		
		public static function getMappingToInstance(mapping:Mapping,toInstance:Object):Mapping{
			var copy:MappingImpl = mapping.copy() as MappingImpl;
			copy.toInstance(toInstance);
			return copy;
		}
		
		public static function getMappingToFactory(mapping:Mapping,toFactory:Class):Mapping{
			var copy:MappingImpl = mapping.copy() as MappingImpl;
			copy.toFactory = toFactory;
			return copy;
		}
	}
}