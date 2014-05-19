package com.scottrade.datagovernance.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.scottrade.datagovernance.dao.PersonDao;
import com.scottrade.datagovernance.domain.Person;
import com.scottrade.datagovernance.service.PersonService;

@Service
public class PersonServiceImpl implements PersonService {

	private PersonDao personDao;

	@Autowired
	public PersonServiceImpl(PersonDao personDao) {
		super();
		this.personDao = personDao;
	}

	public Person getPersonById(Integer id) {
		return personDao.findById(id);
	}

	@Transactional
	public void savePerson(Person person) {
		personDao.insert(person);
	}

//	public void updatePerson(Person p) {
//		personDao.update(p);
//	}

}
