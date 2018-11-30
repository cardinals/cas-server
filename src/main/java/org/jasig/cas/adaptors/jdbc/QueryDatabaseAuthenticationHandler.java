package org.jasig.cas.adaptors.jdbc;

import org.apache.commons.lang3.StringUtils;
import org.jasig.cas.UsernamePasswordCredentialWithAuthCode;
import org.jasig.cas.authentication.HandlerResult;
import org.jasig.cas.authentication.PreventedException;
import org.jasig.cas.authentication.UsernamePasswordCredential;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.stereotype.Component;

import javax.security.auth.login.AccountNotFoundException;
import javax.security.auth.login.FailedLoginException;
import javax.sql.DataSource;
import javax.validation.constraints.NotNull;
import java.security.GeneralSecurityException;

/**
 * Class that if provided a query that returns a password (parameter of query
 * must be username) will compare that password to a translated version of the
 * password provided by the user. If they match, then authentication succeeds.
 * Default password translator is plaintext translator.
 *
 * @author Scott Battaglia
 * @author Dmitriy Kopylenko
 * @author Marvin S. Addison
 * @since 3.0.0
 */
@Component("queryDatabaseAuthenticationHandler")
public class QueryDatabaseAuthenticationHandler extends AbstractJdbcUsernamePasswordAuthenticationHandler {

    @NotNull
    private String sql;

    @Override
    protected final HandlerResult authenticateUsernamePasswordInternal(UsernamePasswordCredential credential)
            throws GeneralSecurityException, PreventedException {

        if (StringUtils.isBlank(this.sql) || getJdbcTemplate() == null) {
            throw new GeneralSecurityException("Authentication handler is not configured correctly");
        }

        UsernamePasswordCredentialWithAuthCode usernamePasswordCredentialWithAuthCode = (UsernamePasswordCredentialWithAuthCode) credential;
        final String username = credential.getUsername();
        String humandid = usernamePasswordCredentialWithAuthCode.getHumanid();
        try {
            //返回用户密码和用户ID，逗号隔开
            String dbPasswordAndHumanId = null;
            if (StringUtils.isEmpty(humandid))
                dbPasswordAndHumanId = getJdbcTemplate().queryForObject(this.sql, String.class, username);
            else
                dbPasswordAndHumanId = getJdbcTemplate().queryForObject("select humanpassword ||','|| humanid from dlsys.tchuman where humanid = ?", String.class, humandid);
            String[] ary = dbPasswordAndHumanId.split(",");
            humandid = ary[1];
            final String encryptedPassword = this.getPasswordEncoder().encode(credential.getPassword() + "," + ary[1]);
            String dbPassword = ary[0];
            //密码为空直接返回
            if (!dbPassword.equals(encryptedPassword) && StringUtils.isNotEmpty(dbPassword)) {
                throw new FailedLoginException("Password does not match value on record.");
            }
        } catch (final IncorrectResultSizeDataAccessException e) {
            if (e.getActualSize() == 0) {
                throw new AccountNotFoundException(username + " not found with SQL query");
            } else {
                throw new FailedLoginException("Multiple records found for " + username);
            }
        } catch (final DataAccessException e) {
            throw new PreventedException("SQL exception while executing query for " + username, e);
        }
        //返回humanid
        credential.setUsername(((UsernamePasswordCredentialWithAuthCode) credential).getHumanid());
        return createHandlerResult(credential, this.principalFactory.createPrincipal(humandid), null);
    }

    /**
     * @param sql The sql to set.
     */
    @Autowired
    public void setSql(@Value("${cas.jdbc.authn.query.sql:}") final String sql) {
        this.sql = sql;
    }

    @Override
    @Autowired(required = false)
    public void setDataSource(@Qualifier("queryDatabaseDataSource") final DataSource dataSource) {
        super.setDataSource(dataSource);
    }
}
