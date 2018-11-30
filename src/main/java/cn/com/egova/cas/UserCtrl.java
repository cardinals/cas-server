package cn.com.egova.cas;

import com.google.gson.Gson;
import org.jasig.cas.SpringContextUtil;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "casFilter", urlPatterns = {"/fetchHumanList"})
public class UserCtrl extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        String humanname = req.getParameter("q");
        JdbcTemplate jdbcTemplate = (JdbcTemplate) SpringContextUtil.getBean("jdbcTemplate");
        List result = jdbcTemplate.queryForList("select humanname,humancode,humanid from dlsys.tchuman where humanname like '%"+humanname.trim()+"%'");
        Gson gson = new Gson();
        response.reset();
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(gson.toJson(result));
        response.getWriter().flush();
        response.getWriter().close();
    }
}
