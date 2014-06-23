package com.scottrade.datagovernance.dao.impl;

import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.WebApplicationInitializer;

import com.scottrade.datagovernance.dao.DashboardDAO;

@Repository
public class DashboardDAOImpl implements DashboardDAO {

	private static final Logger logger = LoggerFactory
			.getLogger(WebApplicationInitializer.class);

	private NamedParameterJdbcTemplate jdbcTemplate;

	@Autowired
	public DashboardDAOImpl(DataSource dataSource) {
		this.jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	}

	public Map<String, String> getAll() {
		Map<String, String> mapy = new HashMap<String, String>();
//		jdbcTemplate
//			.query("SELECT * FROM data_entity_master WHERE entity_id > 0 ORDER BY entity_nm asc",
//					new DashboardRowMapper());
//		if (list.isEmpty()) {
//			throw new NotFoundException("NO data entities found!");
//		} else {
//			return mapy;
//		}
		return mapy;
	}

//	private static class DashboardRowMapper implements RowMapper<DataEntity> {
//		public DataEntity mapRow(ResultSet res, int rowNum) throws SQLException {
//			DataEntity de = new DataEntity();
//			de.setEntityId(res.getInt("entity_id"));
//			de.setEntityNm(res.getString("entity_nm"));
//			de.setEntityDefn(res.getString("entity_defn"));
//			de.setEntityExtUrl(res.getString("entity_ext_url_ref"));
//			return de;
//		}
//	}
}
