package com.marce.framework.ioc.injection
{
	import com.marce.framework.ioc.Injector;
	
	import flash.utils.Dictionary;
	
	import org.as3commons.reflect.Constructor;
	import org.as3commons.reflect.Metadata;
	import org.as3commons.reflect.Parameter;
	import org.as3commons.reflect.Type;

	internal class BasicProvider extends Provider
	{
		public function BasicProvider(clazz:Class)
		{
			super(clazz);
		}
		
		override public function getObject():Object
		{
			var type:Type = Type.forClass(clazz);
			var constructor:Constructor = type.constructor;
			var metadatas:Array = type.getMetadata("ConstructorArgument");
			var constructorArguments:Array = createArguments(constructor.parameters,metadatas);
			return InstanceCreator.create(clazz,constructorArguments);
		}
	}
}