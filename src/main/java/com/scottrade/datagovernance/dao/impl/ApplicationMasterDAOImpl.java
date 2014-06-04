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

import com.scottrade.datagovernance.dao.ApplicationMasterDAO;
import com.scottrade.datagovernance.domain.ApplicationMaster;
import com.scottrade.datagovernance.exception.NotFoundException;
import com.scottrade.datagovernance.util.DGStringUtil;

@Repository
public class ApplicationMasterDAOImpl implements ApplicationMasterDAO {

	private static final Logger logger = LoggerFactory
			.getLogger(WebApplicationInitializer.class);

	private NamedParameterJdbcTemplate jdbcTemplate;

	@Autowired
	public ApplicationMasterDAOImpl(DataSource dataSource) {
		this.jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	}

	public List<ApplicationMaster> getAll() {
		List<ApplicationMaster> list = jdbcTemplate
			.query("SELECT * FROM application_master WHERE appl_id > 0 ORDER BY appl_tier_id, appl_nm asc",
					new ApplicationMasterRowMapper());
		if (list.isEmpty()) {
			throw new NotFoundException("NO data entities found!");
		} else {
			return list;
		}
	}

	public ApplicationMaster getById(int id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);

		List<ApplicationMaster> list = jdbcTemplate.query(
			"SELECT * from data_entity_master WHERE entity_id = :id",
			params, new ApplicationMasterRowMapper());

		if (list.isEmpty()) {
			throw new NotFoundException(
				"NO data entity found for Data Entity! entityId == " + id);
		} else {
			return list.get(0);
		}
	}

	public void insertAppMaster(ApplicationMaster appMstr) {
		KeyHolder keyHolder = new GeneratedKeyHolder();

		logger.info("inserting dataEntity into database" + appMstr);
		jdbcTemplate.update(
			"INSERT INTO data_entity_master (entity_nm, entity_defn, entity_ext_url_ref, create_user_id) "
					+ "VALUES (:entityNm, :entityDefn, :entityExtUrl, 1)",
			new BeanPropertySqlParameterSource(appMstr), keyHolder);

		Integer newId = keyHolder.getKey().intValue();

		// populate the id
		appMstr.setApplId(newId);
	}

	public void updateAppMaster(ApplicationMaster appMstr) {
		int numRowsAffected = jdbcTemplate.update(
			"UPDATE data_entity_master"
				+ "   SET entity_nm          = :entityNm, "
				+ "       entity_defn        = :entityDefn, "
				+ "       entity_ext_url_ref = :entityExtUrl "
				+ "   WHERE entity_id        = :entityId",
				new BeanPropertySqlParameterSource(appMstr));

		if (numRowsAffected == 0) {
			throw new NotFoundException("No Data Entity found for id: "
					+ appMstr.getApplId());
		}
	}

	public void deleteAppMaster(int id) {
		int deDependentsnumRowsAffected = jdbcTemplate.update(
				"DELETE FROM data_entity_hierarchy"
						+ "WHERE data_entity_parent_id = :entityId",
				new BeanPropertySqlParameterSource(id));
		if (deDependentsnumRowsAffected == 0) {
			throw new NotFoundException("No Data Entity found for id: " + id);
		}

		int deNumRowsAffected = jdbcTemplate.update(
				"DELETE FROM data_entity_master"
						+ "WHERE entity_id = :entityId",
				new BeanPropertySqlParameterSource(id));
		if (deNumRowsAffected == 0) {
			throw new NotFoundException("No Data Entity found for id: " + id);
		}
	}

	private static class ApplicationMasterRowMapper implements RowMapper<ApplicationMaster> {
		public ApplicationMaster mapRow(ResultSet res, int rowNum) throws SQLException {
			ApplicationMaster am = new ApplicationMaster();

			am.setApplId(res.getInt("appl_id"));
			am.setApplNm(res.getString("appl_nm"));
			am.setApplDsc(res.getString("appl_dsc"));
			am.setApplTierId(res.getInt("appl_tier_id"));
			//am.setApplTierPolicyDefnTxt(res.getString(""));
			am.setApplRbacControlledFlg(DGStringUtil.convertStringToChar(res.getString("appl_rbac_controlled_flg")));
			am.setApplHasBpsInBlueworksFlg(DGStringUtil.convertStringToChar(res.getString("appl_has_bps_in_blueworks_flg")));
			am.setApplLiveFlg(DGStringUtil.convertStringToChar(res.getString("appl_live_flg")));
			am.setApplDecommDate(res.getDate("appl_decomm_date"));
			am.setDevelopedBy(res.getString("developed_by"));
			am.setHostedAt(res.getString("hosted_at"));
			am.setAuthenticationMode(res.getString("authentication_mode"));
			am.setAuthorizedBy(res.getString("authorized_by"));
			am.setVendorNm(res.getString("vendor_nm"));
			am.setPropsdBAOdeptId(res.getInt("propsd_bao_dept_id"));
			//am.setPropsdBAOdeptNm(res.getString(""));
			am.setPropsdBAOtitle(res.getString("propsd_bao_title"));
			am.setPropsdITAOdeptId(res.getInt("propsd_itao_dept_id"));
			//am.setPropsdITAOdeptNm(res.getString(""));
			am.setDrbcId(res.getInt("appl_dr_bc_id"));
			//am.setDrBcDsc(res.getString(""));
			am.setContainsCustInfoFlg(DGStringUtil.convertStringToChar(res.getString("contains_cust_info_flg")));

			return am;
		}
	}
}
