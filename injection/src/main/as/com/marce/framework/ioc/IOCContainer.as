package com.marce.framework.ioc
{
	
	import com.marce.framework.ioc.configuration.Configurator;
	import com.marce.framework.ioc.configuration.InjectionModule;
	import com.marce.framework.ioc.configuration.InjectionProccessor;
	import com.marce.framework.ioc.configuration.MappingProccessor;
	import com.marce.framework.ioc.configuration.ProccessorsProxy;
	import com.marce.framework.ioc.injection.Mapper;
	import com.marce.framework.ioc.injection.MapperFactory;
	import com.marce.framework.ioc.injection.Mapping;
	import com.marce.framework.ioc.injection.MappingBuilder;
	import com.marce.framework.ioc.injection.MappingImpl;
	
	import flash.utils.Dictionary;

	internal class IOCContainer
	{
		private var mappings:Vector.<Mapping>;
		
		private var injectionDelegators:ProccessorsProxy;
		
		private var mappingDelegators:ProccessorsProxy;
		
		public function IOCContainer()
		{
			mappings = new Vector.<Mapping>();
			injectionDelegators = new ProccessorsProxy();
			mappingDelegators = new ProccessorsProxy();
			install(new SelfConfigurator(injectionDelegators,mappingDelegators));
		}
		
		public function addModule(module:InjectionModule):void{
			install(module.configurator);
			var injections:Array = module.injectionProccessors;
			var mappings:Array = module.mappingProccessors;
			if(injections)
				addInjectionDelegators(injections);
			if(mappings)
				addMappingDelegators(mappings);
		}
		
		public function install(configurator:Configurator):void{
			var mapper:Mapper = MapperFactory.createMapper();
			configurator.configure(mapper);
			addMappings(mapper);
			proccessMappings();
		}
		
		public function getByType(clazz:Class):Object{
			for each(var mapping:Mapping in mappings){
				if(mapping.type == clazz)
					return mapping.getInstance();
			}
			return null;
		}
		
		public function getByName(name:String):Object{
			for each(var mapping:Mapping in mappings){
				if(mapping.name == name)
					return mapping.getInstance();
			}
			return null;
		}
		
		private function addMappings(mapper:Mapper):void{
			for each(var mapping:Mapping in mapper.mappings){
				mappings.push(mapping);
			}
		}
		
		private function addInjectionDelegators(delegators:Array):void{			
			injectionDelegators.addProccessors(delegators);
		}
		
		private function addMappingDelegators(delegators:Array):void{
			mappingDelegators.addProccessors(delegators);
		}
		
		private function proccessMappings():void{
			for each(var mapping:Mapping in mappings){
				for each(var delegator:MappingProccessor in mappingDelegators.proccessors){
					delegator.proccess(mapping);
				}
			}
		}
	}
}