package cn.com.egova.cas;

import com.google.code.kaptcha.servlet.KaptchaServlet;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "captcha", urlPatterns = {"/captcha.jpg"},
        initParams = {
                @WebInitParam(name = "kaptcha.border", value = "no"),
                @WebInitParam(name = "kaptcha.textproducer.char.length", value = "4"),
                @WebInitParam(name = "kaptcha.textproducer.font.color", value = "black"),
                @WebInitParam(name = "kaptcha.noise.color", value = "red"),
                @WebInitParam(name = "kaptcha.image.width", value = "120"),
                @WebInitParam(name = "kaptcha.image.height", value = "45"),
                @WebInitParam(name = "kaptcha.textproducer.char.space", value = "4")}
)
public class SSOKaptchaServlet extends KaptchaServlet {
}
