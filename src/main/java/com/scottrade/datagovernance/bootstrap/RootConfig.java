package com.scottrade.datagovernance.bootstrap;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

/**
 * Bootstrap for service layer.
 * 
 * @author Raghu Nandakumar
 */
@Configuration
@Import({DatabaseConfig.class})
@ComponentScan(basePackages = { "com.scottrade.datagovernance.service", "com.scottrade.datagovernance.dao", "com.scottrade.datagovernance.util" })
public class RootConfig {

}
