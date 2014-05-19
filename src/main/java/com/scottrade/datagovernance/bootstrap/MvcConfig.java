package com.scottrade.datagovernance.bootstrap;

import org.dozer.DozerBeanMapper;
import org.dozer.Mapper;
import org.dozer.loader.api.BeanMappingBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.scottrade.datagovernance.domain.DataEntity;
import com.scottrade.datagovernance.domain.Person;
import com.scottrade.datagovernance.dto.DataEntityDTO;
import com.scottrade.datagovernance.dto.PersonDto;

/**
 * Bootstrap for REST layer. It's important to isolate this for testability.
 * 
 * @author Raghu Nandakumar
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.scottrade.datagovernance.controller")
public class MvcConfig extends WebMvcConfigurerAdapter {
	@Bean
	public BeanMappingBuilder beanMappingBuilder() {
	    BeanMappingBuilder builder = new BeanMappingBuilder() {
	        protected void configure() {
	            mapping(DataEntityDTO.class, DataEntity.class);
	            mapping(PersonDto.class, Person.class);
	        }
	    };

	    return builder;
	}

	@Bean
	public Mapper mapper() {
	    DozerBeanMapper mapper = new DozerBeanMapper();
	    mapper.addMapping(beanMappingBuilder());

	    return mapper;
	}
}
