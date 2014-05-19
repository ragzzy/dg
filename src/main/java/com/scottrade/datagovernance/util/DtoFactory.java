package com.scottrade.datagovernance.util;

import org.springframework.stereotype.Component;

import com.scottrade.datagovernance.domain.DataEntity;
import com.scottrade.datagovernance.domain.Person;
import com.scottrade.datagovernance.dto.DataEntityDTO;
import com.scottrade.datagovernance.dto.PersonDto;

/**
 * Factory methods for creating DTOs.
 * 
 * @author Raghu Nandakumar
 */
@Component
public class DtoFactory {

	/**
	 * Converts a domain entity to a dto.
	 * @param domain
	 * @return
	 */
	public PersonDto createPerson(Person domain) {
		// TODO convert to dozer
		PersonDto dto = new PersonDto();
		dto.setId(domain.getId());
		dto.setFullname(domain.getFirstName() + " " + domain.getLastName());
		return dto;
	}

	public DataEntityDTO createDataEntity (DataEntity domain) {
		DataEntityDTO dto = new DataEntityDTO();
		dto.setEntityId(domain.getEntityId());
		dto.setEntityNm(domain.getEntityNm());
		dto.setEntityDefn(domain.getEntityDefn());
		dto.setEntityExtUrl(domain.getEntityExtUrl());
		return dto;
	}
}
