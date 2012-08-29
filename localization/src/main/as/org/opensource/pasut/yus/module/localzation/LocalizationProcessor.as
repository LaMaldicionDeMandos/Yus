package org.opensource.pasut.yus.module.localzation
{
	import flash.events.Event;
	
	import org.as3commons.bytecode.proxy.IClassProxyInfo;
	import org.as3commons.bytecode.proxy.IProxyFactory;
	import org.as3commons.bytecode.proxy.impl.ProxyFactory;
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;
	import org.opensource.pasut.yus.configuration.MappingProccessor;
	import org.opensource.pasut.yus.injection.Mapping;
	
	internal class LocalizationProcessor implements MappingProccessor
	{
		public function LocalizationProcessor()
		{
		}
		
		public function proccess(mapping:Mapping):void
		{
			proccessClass(getType(mapping),mapping);
		}
		
		private function getType(mapping:Mapping):Type{
			return (mapping.to!=null)? Type.forClass(mapping.to) : Type.forClass(mapping.type);
		}
		
		private function proccessClass(type:Type,mapping:Mapping):void{
			var metadatas:Array = type.getMetadataContainers("Localized"); 
			if(metadatas==null || metadatas.length==0) return;
			var proxyFactory:IProxyFactory = new ProxyFactory();
			var classProxyInfo:IClassProxyInfo = proxyFactory.defineProxy(type.clazz);
			addInterceptorToMethods(classProxyInfo,type);
			addInterceptorToAccessors(classProxyInfo,type);
			proxyFactory.generateProxyClasses();
			proxyFactory.loadProxyClasses();
			var creator:LocalizationCreator = new LocalizationCreator(proxyFactory,type);
			proxyFactory.addEventListener(Event.COMPLETE, creator.onComplete);
			mapping.customCreator = creator;
		}
		
		private function addInterceptorToMethods(classProxyInfo:IClassProxyInfo, type:Type):void{
			for each(var method:Method in type.methods){
				var metadatas:Array = method.getMetadata("Localized");
				if(metadatas!=null && metadatas.length>0)
					classProxyInfo.proxyMethod(method.name);
			}
		}
		
		private function addInterceptorToAccessors(classProxyInfo:IClassProxyInfo, type:Type):void{
			for each(var method:Accessor in type.accessors){
				var metadatas:Array = method.getMetadata("Localized");
				if(metadatas!=null && metadatas.length>0)
					classProxyInfo.proxyAccessor(method.name);
			}
		}
	}
}