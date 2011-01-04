package eu.scy;

import eu.scy.webapp.spring.impl.SpringConfigurationImpl;
import net.sf.sail.webapp.spring.SpringConfiguration;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.util.StringUtils;
import org.springframework.web.context.ConfigurableWebApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import java.security.InvalidParameterException;

/**
 * Created by IntelliJ IDEA.
 * User: Henrik
 * Date: 09.nov.2009
 * Time: 09:38:44
 * To change this template use File | Settings | File Templates.
 */
public class CustomRemotingServlet extends DispatcherServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Name of servlet initialization parameter that specifies the
     * implementation class which holds all the config locations. Use
     * "contextConfigClass".
     */
    public static final String CONFIG_CLASS_PARAM = "contextConfigClass";

    private String contextConfigClass;

    /**
     * Constructor that adds a required servlet initialization parameter
     * CONFIG_CLASS_PARAM
     */
    public CustomRemotingServlet() {
        super();
        //this.addRequiredProperty(CONFIG_CLASS_PARAM);
    }

    /**
     * @param contextConfigClass
     *            the contextConfigClass to set
     */
    public void setContextConfigClass(String contextConfigClass) {
        this.contextConfigClass = contextConfigClass;
    }

    private String getContextConfigClass() {
        return this.contextConfigClass;
    }

    /**
     * @see org.springframework.web.servlet.FrameworkServlet#createWebApplicationContext(org.springframework.web.context.WebApplicationContext)
     */
    @Override
    protected WebApplicationContext createWebApplicationContext(
            WebApplicationContext parent) throws BeansException {
        try {
            SpringConfigurationImpl springConfig = (SpringConfigurationImpl) BeanUtils
                    .instantiateClass(Class.forName(this
                            .getContextConfigClass()));
            this
                    .setContextConfigLocation(StringUtils
                            .arrayToDelimitedString(
                                    springConfig
                                            .getRemotingContextConfigLocations(),
                                    ConfigurableWebApplicationContext.CONFIG_LOCATION_DELIMITERS));
        } catch (ClassNotFoundException e) {
            if (this.logger.isErrorEnabled()) {
                this.logger.error(CONFIG_CLASS_PARAM + " <"
                        + this.getContextConfigClass() + "> not found.", e);
            }
            throw new InvalidParameterException("ClassNotFoundException: "
                    + this.getContextConfigClass());
        }
        return super.createWebApplicationContext(parent);
    }


}
