package org.opensource.pasut.yus
{
	import org.opensource.pasut.yus.configuration.Configurator;
	import org.opensource.pasut.yus.configuration.InjectionProccessor;
	import org.opensource.pasut.yus.configuration.MappingProccessor;
	import org.opensource.pasut.yus.configuration.ProccessorsProxy;
	import org.opensource.pasut.yus.injection.Mapper;
	
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