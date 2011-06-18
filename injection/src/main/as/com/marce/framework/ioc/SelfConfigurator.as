package com.marce.framework.ioc
{
	import com.marce.framework.ioc.configuration.Configurator;
	import com.marce.framework.ioc.configuration.InjectionProccessor;
	import com.marce.framework.ioc.configuration.MappingProccessor;
	import com.marce.framework.ioc.configuration.ProccessorsProxy;
	import com.marce.framework.ioc.injection.Mapper;
	
	public class SelfConfigurator implements Configurator
	{
		private var injectionDelegators:ProccessorsProxy;
		private var mappingDelegators:ProccessorsProxy;
		public function SelfConfigurator(injectionDelegators:ProccessorsProxy,mappingDelegators:ProccessorsProxy)
		{
			this.injectionDelegators = injectionDelegators;
			this.mappingDelegators = mappingDelegators;
		}
		
		public function configure(mapper:Mapper):void
		{
			mapper.map(ProccessorsProxy).named("injectionDelegators").toInstance(injectionDelegators);
			mapper.map(ProccessorsProxy).named("mappingDelegators").toInstance(mappingDelegators);
		}
	}
}