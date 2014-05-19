package com.scottrade.datagovernance.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.web.WebApplicationInitializer;

import com.scottrade.datagovernance.dao.DataEntityDAO;
import com.scottrade.datagovernance.domain.DataEntity;
import com.scottrade.datagovernance.exception.NotFoundException;

@Repository
public class DataEntityDAOImpl implements DataEntityDAO {

	private static final Logger logger = LoggerFactory
			.getLogger(WebApplicationInitializer.class);

	private NamedParameterJdbcTemplate jdbcTemplate;

	@Autowired
	public DataEntityDAOImpl(DataSource dataSource) {
		this.jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	}

	public List<DataEntity> getAll() {
		List<DataEntity> list = jdbcTemplate.query(
				"SELECT * FROM data_entity_master WHERE entity_id > 0 ORDER BY entity_nm asc",
				new DataEntityRowMapper());
		if (list.isEmpty()) {
			throw new NotFoundException("NO data entities found!");
		} else {
			return list;
		}
	}

	public List<DataEntity> getDependents(int id) {
		List<DataEntity> list = jdbcTemplate.query(
				"SELECT * FROM data_entity_master demi"
						+ ", data_entity_hierarchy deh "
						+ "WHERE demi.entity_id = deh.data_entity_child_id "
						+ "  AND deh.data_entity_parent_id = :id",
				new DataEntityRowMapper());

		if (list.isEmpty()) {
			throw new NotFoundException("NO data entities found!");
		} else {
			return list;
		}
	}

	public DataEntity getById(int id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);

		List<DataEntity> list = jdbcTemplate.query(
				"SELECT * from data_entity_master WHERE entity_id = :id",
				params, new DataEntityRowMapper());
		if (list.isEmpty()) {
			throw new NotFoundException(
					"NO data entity found for entityId: " + id);
		} else {
			return list.get(0);
		}
	}

	public void insertDataEntity(DataEntity dataEntity) {
		KeyHolder keyHolder = new GeneratedKeyHolder();

		logger.debug("inserting dataEntity into database");
		jdbcTemplate
				.update("INSERT INTO data_entity_master (entity_nm, entity_defn, entity_ext_ref_url) "
						+ "VALUES (:entityNm, :entityDefn, :entityExtUrl)",
						new BeanPropertySqlParameterSource(dataEntity),
						keyHolder);

		Integer newId = keyHolder.getKey().intValue();

		// populate the id
		dataEntity.setEntityId(newId);
	}

	public void updateDataEntity(DataEntity de) {
		int numRowsAffected = jdbcTemplate.update(
				"UPDATE data_entity_master"
						+ "   SET entity_nm          = :entityNm, "
						+ "       entity_defn        = :entityDefn, "
						+ "       entity_ext_ref_url = :entityExtUrl "
						+ "   WHERE entity_id          = :entityId",
				new BeanPropertySqlParameterSource(de));

		if (numRowsAffected == 0) {
			throw new NotFoundException("No person found for id: "
					+ de.getEntityId());
		}
	}

	public void deleteDataEntity(int id) {
		int deDependentsnumRowsAffected = jdbcTemplate.update(
				"DELETE FROM data_entity_hierarchy"
						+ "WHERE data_entity_parent_id = :entityId",
				new BeanPropertySqlParameterSource(id));
		int deNumRowsAffected = jdbcTemplate.update(
				"DELETE FROM data_entity_master"
						+ "WHERE entity_id = :entityId",
				new BeanPropertySqlParameterSource(id));
	}

	private static class DataEntityRowMapper implements RowMapper<DataEntity> {
		public DataEntity mapRow(ResultSet res, int rowNum) throws SQLException {
			DataEntity de = new DataEntity();
			de.setEntityId(res.getInt("entity_id"));
			de.setEntityNm(res.getString("entity_nm"));
			de.setEntityDefn(res.getString("entity_defn"));
			de.setEntityExtUrl(res.getString("entity_ext_url_ref"));
			return de;
		}
	}
}
