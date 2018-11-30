package org.jasig.cas;

import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.jasig.cas.authentication.UsernamePasswordCredential;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class UsernamePasswordCredentialWithAuthCode extends UsernamePasswordCredential {
    private static final long serialVersionUID = 1L;
    /**
     * 验证码
     */
    @NotNull
    @Size(min = 1, message = "required.authcode")
    private String authcode;
    private String humanid;

    public String getHumanid() {
        return humanid;
    }

    public void setHumanid(String humanid) {
        this.humanid = humanid;
    }

    /**
     * @return
     */
    public final String getAuthcode() {
        return authcode;
    }

    /**
     * @param authcode
     */
    public final void setAuthcode(String authcode) {
        this.authcode = authcode;
    }


    public UsernamePasswordCredentialWithAuthCode() {
        super();
    }

    public UsernamePasswordCredentialWithAuthCode(String userName,
                                                  String password) {
        super(userName, password);
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        final UsernamePasswordCredentialWithAuthCode that = (UsernamePasswordCredentialWithAuthCode) o;

        if (getPassword() != null ? !getPassword().equals(that.getPassword())
                : that.getPassword() != null) {
            return false;
        }

        if (getPassword() != null ? !getPassword().equals(that.getPassword())
                : that.getPassword() != null) {
            return false;
        }
        if (authcode != null ? !authcode.equals(that.authcode)
                : that.authcode != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder().append(getUsername())
                .append(getPassword()).append(authcode).toHashCode();
    }

}
